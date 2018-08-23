#! /bin/bash
iterations=$1
for i in $(seq 1 $iterations)
do
    bootstack=boot-${i}
    stackname=pipeline-${i}
    user=pge-${i}
    password=abcd12345
    repo=serverless-${i}
    repourl=ssh://git-codecommit.eu-west-1.amazonaws.com/v1/repos/$repo
    echo $repo
    echo $user
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
        --capabilities=CAPABILITY_NAMED_IAM
done