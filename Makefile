uq_samples_all_vars: swirlcode tubbs_1k_20kmx20km_10xflat.npy uq_samples.npy small_scale_config_all_vars.pbtxt
	python3 swirl-lm/swirl_lm/example/fire/fire_main.py \
		--flagfile="small_scale_flags_all_vars.flags" \
		--data_dump_prefix="gs://tubbs-scale-fire-simulations/small-scale-many-fuel-fix/uq_cases_all_vars/" \
		--read_uq_file=True \
		--target=swirl-lm-tubbs-test-pod \
		--terrain_filepath=tubbs_1k_20kmx20km_10xflat.npy \
		--uq_start_id=0 \
		--uq_end_id=20 \
		--uq_filename='./uq_samples.npy'

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
		--uq_start_id=6 \
		--uq_end_id=20 \
		--uq_filename='./uq_filtered_20_0.npy'


BUCKETFILES = tubbs_1k_20kmx20km_10xflat.npy uq_samples_1000_1.npy uq_samples.npy small_scale_config.pbtxt small_scale_config_all_vars.pbtxt uq_filtered_20_0.npy

$(BUCKETFILES): %:
	gsutil cp gs://tubbs-scale-fire-simulations/${*} .


swirlcode: swirl-lm/swirl_lm/example/fire/fire_main.py
	echo Done


swirl-lm/swirl_lm/example/fire/fire_main.py:
	git clone https://github.com/Algopaul/swirl-lm-uq.git swirl-lm
	./swirl-lm/swirl_lm/setup.sh

