<script>
	export let imgsConfig;
	export let wrapperWidth;
	export let wrapperHeight;
</script>

{#each imgsConfig as img}
	<img
		id={img.id}
		style:width={img.wr * 100 + '%'}
		style:height={img.hr * 100 + '%'}
		style:transform={`translate(${img.xr * wrapperWidth}px, ${img.yr * wrapperHeight}px)`}
		src={`/${img.id}.png`}
	/>
{/each}

<style>
	img {
		position: absolute;
    opacity: 0;
	}
</style>
