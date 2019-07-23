#!/bin/bash
JOB_NAME=$1
NUM_GPUS=2
PS_HOSTS=10.0.41.12:2221
WORKER_HOSTS=10.0.41.12:2222
echo JOB_NAME=$JOB_NAME
echo NUM_GPUS=$NUM_GPUS
echo PS_HOSTS=$PS_HOSTS
echo WORKER_HOSTS=$WORKER_HOSTS

##############################
MODEL=resnet50
SAVE_MODEL_SECS=1000
NUM_BATCHES=150
BATCH_SIZE=64


if [ "$1" = "ps" ]; then 
    export CUDA_VISIBLE_DEVICES=""
fi;

TASK_INDEX=0
PRINT_TRAINING_ACCURACY=True
VARIABLE_UPDATE=parameter_server
# CROSS_REPLICA_SYNC=True
CROSS_REPLICA_SYNC=False
SERVER_PROTOCOL=grpc
SUMMARY_VERBOSITY=1
SAVE_SUMMARIES_STEPS=1500
RESULT_STORAGE=log
#ALL_REDUCE_SPEC='nccl/xring'
ALL_REDUCE_SPEC='pscpu'
	# --data_dir=${DATASET_DIR} \
python3 scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
	--model=${MODEL} \
	--batch_size=${BATCH_SIZE} \
	--data_name="imagenet" \
	--num_batches=${NUM_BATCHES} \
    --num_gpus=${NUM_GPUS} \
	--ps_hosts=${PS_HOSTS} \
	--worker_hosts=${WORKER_HOSTS} \
	--print_training_accuracy=${PRINT_TRAINING_ACCURACY} \
	--job_name=${JOB_NAME} \
	--variable_update=${VARIABLE_UPDATE} \
	--task_index=${TASK_INDEX} \
	--data_format=NHWC \
    --local_parameter_device='cpu' \
	--server_protocol=${SERVER_PROTOCOL} \
	--cross_replica_sync=${CROSS_REPLICA_SYNC}