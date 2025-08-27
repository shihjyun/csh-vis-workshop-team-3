library(tidyverse)
library(stringr)
library(purrr)

data_dir <- "./data/audit/"

fa_author   <- readr::read_csv(file.path(data_dir, "factuality_author.csv"))
fa_field    <- readr::read_csv(file.path(data_dir, "factuality_field.csv"))
fa_epoch    <- readr::read_csv(file.path(data_dir, "factuality_epoch.csv"))
fa_seniority<- readr::read_csv(file.path(data_dir, "factuality_seniority.csv"))

# ---------- 1) Author factuality ----------
# What this measures:
#   “Of all names the LLM suggested, how many are real APS authors?”
# How we compute it:
#   1) Keep rows marked as valid.
#   2) For each task, take the mean of is_in_aps.

author_factuality <- fa_author %>%
  filter(result_valid_flag == "valid") %>%
  group_by(task_name) %>%
  summarise(author_frac = mean(is_in_aps), .groups = "drop") %>% 
  pivot_wider(names_from = task_name, values_from = author_frac)

author_factuality %>% 
  write_csv("./eval_results/author_factuality.csv")


# ---------- 2) Field factuality ----------
# What this measures:
#   “Did we get the right author AND a DOI that’s an APS paper in the requested field?”
#   We use a strict combined flag often called A.D.F.:
#     A = author exists in APS,
#     D = DOI resolves to an APS publication for that author,
#     F = that publication is in the requested field.
# How we compute it:
#   1) Keep valid rows.
#   2) Quick checks for A and D using non-NA IDs.
#   3) Use fact_doi_author_field as the strict A.D.F. pass flag.
# Notes:
#   - NOTE: Treat NA in fact_doi_author_field as FALSE (unknown → not counted as pass).
#   - If fact_doi_author_field is already TRUE/FALSE, we keep that as is.

field_adf <- fa_field %>%
  filter(result_valid_flag == "valid") %>%
  mutate(
    A   = !is.na(id_author_oa),           # author exists
    D   = !is.na(id_publication_aps),     # DOI resolves in APS
    ADF = coalesce(as.logical(fact_doi_author_field), FALSE)
  ) %>%
  summarise(
    author_ok = mean(A,   na.rm = TRUE),
    doi_ok    = mean(D,   na.rm = TRUE),
    adf_ok    = mean(ADF, na.rm = TRUE),
    .groups = "drop"
  )

field_adf %>% 
  write_csv("./eval_results/field_factuality.csv")



# ---------- 3) Epoch factuality ----------
# What this measures:
#   “Does the year range mentioned by the LLM line up with the requested decade?”
# How we define windows:
#   - Requested decade: pull the first 4-digit year from task_param; window is [year, year+9].
#   - LLM text years: find all 4-digit years in `years`; take min/max as [llm_start, llm_end].
# How we label:
#   - In   = LLM range is fully inside the requested decade.
#   - Out  = LLM range doesn’t overlap the requested decade at all.
#   - Over = Partial overlap (touches the window but not fully inside).
# Also kept:
#   - fact_epoch_requested = dataset’s own “matches the requested epoch” flag.
#   - fact_author_exists   = diagnostic (did we resolve an APS author?).
# Edge cases:
#   - If `years` has no 4-digit year → llm_start/llm_end = NA → label = NA.
#   - If task_param has no 4-digit year → requested window = NA → comparisons = NA.
#
# NOTE: We robustly parse req_start from any “1950” inside task_param
#       (so both "1950" and "1950s" work).

# Parse [llm_start, llm_end] from free text

parse_llm_years <- function(x) {
  yrs <- str_extract_all(x %||% "", "\\d{4}")
  tibble(
    llm_start = map_int(yrs, ~ if (length(.x)) min(as.integer(.x)) else NA_integer_),
    llm_end   = map_int(yrs, ~ if (length(.x)) max(as.integer(.x)) else NA_integer_)
  )
}

# Closed-interval helpers
within_rng  <- function(a1,a2,b1,b2) !is.na(a1)&!is.na(a2)&!is.na(b1)&!is.na(b2) & a1>=b1 & a2<=b2
outside_rng <- function(a1,a2,b1,b2) !is.na(a1)&!is.na(a2)&!is.na(b1)&!is.na(b2) & (a2<b1 | a1>b2)
overlap_any <- function(a1,a2,b1,b2) !is.na(a1)&!is.na(a2)&!is.na(b1)&!is.na(b2) & (a1<=b2 & b1<=a2)

fa_epoch_eval <- fa_epoch %>%
  filter(result_valid_flag == "valid") %>%
  mutate(
    req_start = as.integer(str_extract(task_param, "\\d{4}")),
    req_end   = ifelse(is.na(req_start), NA_integer_, req_start + 9L)  # e.g., 1950s = 1950–1959
  ) %>%
  bind_cols(parse_llm_years(.$years)) %>%
  mutate(
    fact_author_exists = !is.na(id_author_oa),
    fact_match         = fact_epoch_requested,  # keep dataset’s own match flag
    
    # LLM text vs requested decade
    fact_in_txt   = within_rng(llm_start, llm_end, req_start, req_end),
    fact_out_txt  = outside_rng(llm_start, llm_end, req_start, req_end),
    fact_over_txt = overlap_any(llm_start, llm_end, req_start, req_end) & !fact_in_txt,
    
    fact_txt_cat = case_when(
      is.na(llm_start) | is.na(llm_end) ~ NA_character_,
      fact_in_txt   ~ "In",
      fact_over_txt ~ "Over",
      fact_out_txt  ~ "Out",
      TRUE          ~ NA_character_
    )
  )

epoch_overall <- fa_epoch_eval %>%
  summarise(
    author_exists = mean(fact_author_exists, na.rm = TRUE),
    match         = mean(fact_match,         na.rm = TRUE),
    In_txt        = mean(fact_in_txt,        na.rm = TRUE),
    Out_txt       = mean(fact_out_txt,       na.rm = TRUE),
    Over_txt      = mean(fact_over_txt,      na.rm = TRUE)
  )

epoch_overall %>% 
  write_csv("./eval_results/epoch_factuality.csv")



# ---------- 4) Seniority factuality ----------
# What this measures:
#   “Does the person’s seniority match what we asked for (either historically or today)?”
# Two frames:
#   - Then / Active: seniority during the author’s active period (historical view).
#   - Now          : seniority today (current view).
# What we record:
#   - *_requested: ground truth vs the requested seniority (per frame).
#   - *_txt      : whether the LLM’s wording matches ground truth (per frame).
# One convenience flag:
#   - fact_match_requested = TRUE if either frame (Then or Now) satisfies the request.

fa_seniority %>% 
  count(task_param)

sen_eval <- fa_seniority %>%
  filter(result_valid_flag == "valid") %>%
  mutate(
    # Diagnostic: did we resolve an APS author?
    fact_author_exists = !is.na(id_author_oa),
    
    # Ground-truth match to the request (two frames)
    fact_match_then = fact_seniority_active_requested,
    fact_match_now  = fact_seniority_now_requested,
    
    # Single “did it match the requested seniority at all?” flag
    fact_match_requested =
      coalesce(fact_seniority_active_requested, FALSE) |
      coalesce(fact_seniority_now_requested,  FALSE),
    
    # LLM text alignment with truth (two frames)
    fact_then_txt = fact_seniority_active,
    fact_now_txt  = fact_seniority_now
  )

sen_overall <- sen_eval %>%
  summarise(
    author_exists      = mean(fact_author_exists,     na.rm = TRUE),
    match_then         = mean(fact_match_then,        na.rm = TRUE),
    match_now          = mean(fact_match_now,         na.rm = TRUE),
    then_txt_alignment = mean(fact_then_txt,          na.rm = TRUE),
    now_txt_alignment  = mean(fact_now_txt,           na.rm = TRUE)
  )


sen_overall %>% 
  write_csv("./eval_results/seniority_factuality.csv")
