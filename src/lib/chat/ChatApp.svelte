<script>
	import Annotation from './Annotation.svelte';
	import { onMount } from 'svelte';
	import { json } from 'd3';

	let imgsConfig;

	let wrapperWidth = 0;
	let wrapperHeight = 0;

	onMount(async () => {
		const response = await fetch('/imgs-config.json');
		imgsConfig = await response.json();
	});
</script>

<div class="container">
	<div class="bg-wrapper" bind:clientWidth={wrapperWidth} bind:clientHeight={wrapperHeight}>
		<!-- <img width="100%" src="/bg-image.jpg" /> -->
		{#if imgsConfig}
			<Annotation {imgsConfig} {wrapperWidth} {wrapperHeight}></Annotation>
		{/if}
	</div>
</div>

<style lang="scss">
	.container {
		width: 100vw;
		height: 100vh;
		overflow: hidden;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.bg-wrapper {
		aspect-ratio: 4 / 3;
		width: 100%;
		position: relative;
	}
	.bg-wrapper img {
		object-fit: cover;
		position: absolute;
		top: 0;
		left: 0;
	}
</style>
