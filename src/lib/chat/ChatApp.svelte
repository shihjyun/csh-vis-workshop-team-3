<script>
	import Annotation from './Annotation.svelte';
</script>

<div class="container">
	<div class="bg-wrapper">
		<img width="100%" src="/bg-image.jpg" />
		<Annotation></Annotation>
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
		background: black;
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
