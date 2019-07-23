NUM_GPUS=$1
echo NUM_GPUS=$NUM_GPUS
python ./scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
 --num_gpus=$NUM_GPUS \
 --batch_size=32 \
 --model=resnet50 \
 --variable_update=parameter_server
