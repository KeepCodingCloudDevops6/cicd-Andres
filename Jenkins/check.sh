#!/bin/bash

BUCKET_NAME="acme-storage-andres"
BUCKET_SIZE=0
MAX_SIZE=20971520
BUCKET_EXISTS=0


aws s3 ls s3://$BUCKET_NAME 2>&1 > /dev/null

BUCKET_EXISTS=$?

if [[ $BUCKET_EXISTS != 0 ]]; then 
	echo "No Bucket Available"
	exit 0
fi

BUCKET_SIZE=$(aws s3 ls s3://$BUCKET_NAME --recursive | awk '{print $3}')

if [[ ! $BUCKET_SIZE =~ ^[0-9]+$ ]]; then
    echo "Incorrect value for Bucket size"
    exit 0
fi

if [[ $BUCKET_SIZE > $MAX_SIZE ]]; then
    aws s3 rm s3://$BUCKET_NAME --recursive
    aws s3api delete-bucket --bucket $BUCKET_NAME
    exit 0
fi

echo "Bucket is smaller than max size"