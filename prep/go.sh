#! /bin/bash
profile=playground
region=eu-west-1
VPCName="PlaygroundVPC"
prepstackname=pge-7-prep
userstackprefix=pge
artifactbucket=pge-artifact-bucket
deploybucket=pge-deploy-bucket
aws cloudformation deploy \
    --stack-name $prepstackname \
    --template-file prep.yaml \
    --profile $profile \
    --region $region \
    --parameter-overrides \
        VPCName=$VPCName \
        PrepStackName=$prepstackname \
        ArtifactBucketName=$artifactbucket \
        DeploymentBucketName=$deploybucket \
    --capabilities=CAPABILITY_NAMED_IAM

iterations=$1
for i in $(seq 1 $iterations)
do
    bootstack=$userstackprefix-${i}
    stackname=pipeline-${i}
    user=pge-${i}
    password=abcd12345
    repo=pge-${i}
    subnetId=subnet-e5224381
    repourl=ssh://git-codecommit.eu-west-1.amazonaws.com/v1/repos/$repo
    #echo "$user,$password,$repo,$bootstack,$stackname" >> test.csv
    aws cloudformation deploy \
        --stack-name $bootstack \
        --template-file pipeline.yaml \
        --profile $profile \
        --region $region \
        --parameter-overrides \
            RepositoryName=$repo \
            StackName=$stackname \
            UserName=$user \
            Password=$password \
            SubnetId=$subnetId \
            InstanceType=t2.medium \
            PrepStackName=$prepstackname \
        --capabilities=CAPABILITY_NAMED_IAM
done