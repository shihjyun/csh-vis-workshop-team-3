<script>
	import { onMount } from 'svelte';
	import { gsap } from 'gsap';
	import { DrawSVGPlugin } from 'gsap/dist/DrawSVGPlugin';

	// import { draw } from 'svelte/transition';
	// import { quintOut } from 'svelte/easing';

	onMount(() => {
		gsap.registerPlugin(DrawSVGPlugin);
		const paths = document.querySelectorAll('#story-1 path');
		const tl = gsap.timeline();
		tl.from(paths, {
			duration: 0.3,
			drawSVG: 0,
			stagger: 0.3,
			ease: 'power1.inOut'
		});
	});
</script>

<svg
	width="100%"
	height="100%"
	viewBox="0 0 1600 1200"
	fill="none"
	xmlns="http://www.w3.org/2000/svg"
>
	<g id="Frame 1">
		<g id="story-1">
			<path
				id="Vector"
				d="M294.338 774.635C283.1 773.278 277.661 783.679 266.673 781.481C234.985 775.144 207.963 747.703 253.455 730.644C258.434 728.777 258.543 730.135 263.623 729.627C285.351 727.454 306.352 720.382 327.678 718.443C342.304 717.113 356.902 724.966 371.398 726.577C405.675 730.385 442.596 739.566 477.14 735.728C536.196 729.166 613.897 704.361 673.373 710.309C686.589 711.63 698.839 716.979 712.01 718.443C727.572 720.172 739.775 712.684 754.713 711.326C772.201 709.736 833.856 718.807 839.103 739.795C851.151 787.986 728.736 777.775 701.842 780.465C660.021 784.647 616.171 771.535 573.732 774.364C541.411 776.519 510.659 786.432 478.157 788.599C459.449 789.846 430.176 793.014 412.068 787.582C403.858 785.119 396.364 778.502 387.666 777.414C374.437 775.761 361.902 777.582 349.03 774.364C336.501 771.232 319.204 777.838 305.309 774.364C298.632 772.695 294.033 775.381 288.025 775.381C286.297 775.381 281.317 775.807 282.941 776.398M282.941 776.398C286.97 777.863 291.057 779.164 295.142 780.465C291.075 779.109 287.008 777.753 282.941 776.398Z"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_2"
				d="M875.532 741.821C855.708 741.98 914.632 737.884 921.46 735.728C935.497 731.295 948.232 725.56 963.147 725.56C982.07 725.56 987.099 725.039 986.532 724.543M986.532 724.543C983.773 722.129 980.557 720.274 977.381 718.443C980.432 720.476 983.482 722.51 986.532 724.543Z"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_3"
				d="M989.731 711.673C967.057 704.917 989.131 727.82 998.733 731.661C999.919 732.135 1005.43 734.119 1003.82 735.728C994.804 744.74 985.192 758.204 973.314 762.163"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_4"
				d="M1077.3 687.869C1072.93 657.185 1079.32 721.232 1079.06 728.61C1078.53 743.448 1080.21 771.044 1073.97 783.515"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_5"
				d="M1081.88 685.316C1065.04 676.261 1132.24 675.244 1140.06 674.723C1149.53 674.091 1147.09 662.204 1154.3 667.605"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_6"
				d="M1084.42 739.531C1070.06 734.853 1143.4 718.657 1109.56 728.61"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_7"
				d="M1168.37 728.23C1174.14 705.744 1119.59 732.675 1138.03 753.012C1143.53 759.08 1163.91 725.173 1175.65 720.476C1188.39 715.379 1173.71 746.454 1178.7 748.945C1179.28 749.236 1180.15 748.123 1179.71 748.945"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_8"
				d="M1212.49 659.373C1188.94 661.218 1213.15 737.541 1204.12 760.13C1203.82 760.866 1203.18 759.372 1203.1 760.13"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_9"
				d="M1236.3 699.696C1240.52 680.87 1228.1 720.735 1225.47 725.56C1222.83 730.401 1213.7 735.728 1214.28 735.728C1234.81 735.728 1276.09 710.927 1248.85 724.543C1248.31 724.813 1248.64 724.543 1249.87 724.543C1256.29 724.543 1269.27 712.261 1261.06 720.476"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_10"
				d="M1277.44 710.734C1275.68 710.074 1276.94 711.674 1278.34 711.326C1285.26 709.595 1316.89 678.959 1303.76 673.706C1276.14 662.657 1244.65 716.718 1282.7 747.156C1301.24 761.986 1344.4 704.605 1336.29 723.527"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_11"
				d="M1384.37 644.017C1381.73 636.572 1382.05 659.705 1382.05 667.605C1382.05 697.837 1375.95 758.096 1375.95 758.096C1377.98 747.251 1380.01 736.405 1382.05 725.56"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
			<path
				id="Vector_12"
				d="M1380.62 774.072C1374.42 777.068 1389.86 790.279 1384.08 785.548"
				stroke="#FF000D"
				stroke-width="10.76"
				stroke-miterlimit="1.5"
				stroke-linecap="round"
				stroke-linejoin="round"
			/>
		</g>
	</g>
</svg>

<style>
	svg {
		position: absolute;
		inset: 0;
		width: 100%;
	}
</style>
