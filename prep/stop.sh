#! /bin/bash
iterations=$1
for i in $(seq 1 $iterations)
do
    bootstack=boot-${i}
    aws cloudformation delete-stack \
        --stack-name $bootstack \
        --profile ecs-training \
        --region eu-west-1 \
done