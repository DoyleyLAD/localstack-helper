#!/bin/sh

RESOURCE=$1
RESOURCE_NAME=$2
VALUE=$3
REGION="eu-west-2"

aws_ls() {
    AWS_ACCESS_KEY_ID=localstack \
    AWS_SECRET_ACCESS_KEY=locslstack \
    aws --endpoint-url=http://localhost:4566 "$@"
}

if [ $RESOURCE = "S3" ] || [ $RESOURCE = "s3" ]; then
    aws_ls s3api create-bucket \
        --bucket $RESOURCE_NAME \
        --region $REGION \
        --create-bucket-configuration LocationConstraint=$REGION
    aws_ls s3 ls
fi

if [ $RESOURCE = "SQS" ] || [ $RESOURCE = "sqs" ]; then
    aws_ls sqs create-queue \
        --queue-name $RESOURCE_NAME \
        --region $REGION
    aws_ls sqs list-queues --region $REGION 
fi

if [ $RESOURCE = "param" ] || [ $RESOURCE = "PS" ] || [ $RESOURCE = "ps" ]; then
    aws_ls ssm put-parameter \
        --name $RESOURCE_NAME \
        --value $VALUE \
        --type "SecureString" \
        --region $REGION 
    aws_ls ssm describe-parameters --region $REGION 
fi

if [ $RESOURCE = "list" ]; then
    echo ""
    echo "------------------------------------------------------------------" 
    echo "S3 Buckets:" 
    echo "------------------------------------------------------------------" 
    aws_ls s3 ls
    echo "------------------------------------------------------------------" 
    echo "SQS:" 
    echo "------------------------------------------------------------------" 
    aws_ls sqs list-queues --region $REGION
    echo "------------------------------------------------------------------" 
    echo "Parameter Store:" 
    echo "------------------------------------------------------------------" 
    aws_ls ssm describe-parameters --region $REGION | grep "Name"
    echo "------------------------------------------------------------------" 
fi