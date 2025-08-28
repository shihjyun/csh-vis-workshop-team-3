<script>
	import { onMount } from 'svelte';
	import { gsap } from 'gsap';
	import { DrawSVGPlugin } from 'gsap/dist/DrawSVGPlugin';
	import StoryImages from './svgs/StoryImages.svelte';
	import Story1 from './svgs/Story1.svelte';
	import Story2 from './svgs/Story2.svelte';

	export let imgsConfig;

	export let wrapperWidth;
	export let wrapperHeight;

	// import { draw } from 'svelte/transition';
	// import { quintOut } from 'svelte/easing';

	onMount(() => {
		gsap.registerPlugin(DrawSVGPlugin);

		const tl = gsap.timeline({ repeat: -1, repeatDelay: 1 });
		tl.from(document.querySelectorAll('#story-1 path'), {
			duration: 0.3,
			drawSVG: 0,
			stagger: 0.3,
			ease: 'power1.inOut'
		});
		tl.from(
			document.querySelectorAll('#story-2 path'),
			{
				duration: 0.3,
				drawSVG: 0,
				stagger: 0.3,
				ease: 'power1.inOut'
			},
			'+=0.5'
		);
		tl.to('#img_1', { opacity: 1, duration: 0.5 }, '+=0.5');
		tl.to('#img_2', { opacity: 1, duration: 0.5 }, '+=0.5');
	});
</script>

<svg
	width="100%"
	height="100%"
	viewBox="0 0 1600 1200"
	fill="none"
	xmlns="http://www.w3.org/2000/svg"
>
	<Story1 />
	<Story2 />
</svg>

<StoryImages {imgsConfig} {wrapperWidth} {wrapperHeight}></StoryImages>

<style>
	svg {
		position: absolute;
		inset: 0;
		width: 100%;
	}
</style>
