#! /bin/bash
set -e
iterations=$1
for i in $(seq 1 $iterations)
do
    bootstack=boot-${i}
    stackname=pipeline-${i}
    user=pge-${i}
    password=abcd12345
    repo=serverless-${i}
    subnetId=subnet-e5224381
    repourl=ssh://git-codecommit.eu-west-1.amazonaws.com/v1/repos/$repo
    #echo "$user,$password,$repo,$bootstack,$stackname" >> test.csv
    aws cloudformation deploy \
        --stack-name $bootstack \
        --template-file pipeline.yaml \
        --profile ecs-training \
        --region eu-west-1 \
        --parameter-overrides \
            RepositoryName=$repo \
            StackName=$stackname \
            UserName=$user \
            Password=$password \
            SubnetId=$subnetId \
            InstanceType=t2.medium \
        --capabilities=CAPABILITY_NAMED_IAM
done