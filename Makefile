uq_samples: swirlcode tubbs_1k_20kmx20km_10xflat.npy uq_samples_1000_1.npy small_scale_config.pbtxt
	python3 swirl-lm/swirl_lm/example/fire/fire_main.py \
		--flagfile="small_scale_flags.flags" \
		--data_dump_prefix="gs://tubbs-scale-fire-simulations/small-scale-many-fuel-fix/uq_cases/" \
		--read_uq_file=True \
		--target=swirl-lm-tubbs-test-pod \
		--terrain_filepath=tubbs_1k_20kmx20km_10xflat.npy \
		--uq_start_id=0 \
		--uq_end_id=1000 \
		--uq_filename='./uq_samples_1000_1.npy'

uq_filtered: swirlcode tubbs_1k_20kmx20km_10xflat.npy uq_filtered_20_0.npy small_scale_config.pbtxt
	python3 swirl-lm/swirl_lm/example/fire/fire_main.py \
		--flagfile="small_scale_flags.flags" \
		--data_dump_prefix="gs://tubbs-scale-fire-simulations/uq_filtered/uq_cases/" \
		--read_uq_file=True \
		--target=swirl-lm-tubbs-test-pod \
		--terrain_filepath=tubbs_1k_20kmx20km_10xflat.npy \
		--uq_start_id=0 \
		--uq_end_id=5 \
		--uq_filename='./uq_filtered_20_0.npy'


tubbs_1k_20kmx20km_10xflat.npy:
	gsutil cp gs://tubbs-scale-fire-simulations/tubbs_1k_20kmx20km_10xflat.npy .


swirlcode: swirl-lm/swirl_lm/example/fire/fire_main.py
	echo Done


swirl-lm/swirl_lm/example/fire/fire_main.py:
	git clone https://github.com/Algopaul/swirl-lm-uq.git swirl-lm
	./swirl-lm/swirl_lm/setup.sh


uq_samples_1000_1.npy:
	gsutil cp gs://tubbs-scale-fire-simulations/uq_samples_1000_1.npy .

small_scale_config.pbtxt:
	gsutil cp gs://tubbs-scale-fire-simulations/small_scale_config.pbtxt .

uq_filtered_20_0.npy:
	gsutil cp gs://tubbs-scale-fire-simulations/uq_samples_20_0.npy .
