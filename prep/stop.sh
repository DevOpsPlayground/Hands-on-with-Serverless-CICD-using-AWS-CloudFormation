#! /bin/bash
profile=playground
region=eu-west-1
iterations=$1
prepstackname=pge-7-prep
userstackprefix=pge
for i in $(seq 1 $iterations)
do
    bootstack=$userstackprefix-${i}
    aws cloudformation delete-stack \
        --stack-name $bootstack \
        --profile $profile \
        --region $region
done

aws cloudformation delete-stack \
    --stack-name $prepstackname \
    --profile $profile \
    --region $region