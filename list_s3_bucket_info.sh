#!/bin/bash

# This script is quick and dirty.
# The account name in the account_bucket array must match the profile names in ~/.aws/credentials.
# Array elements must be comma delimited account name and bucket name.
# Fill in the array. Ensure there is no white space in the array elements.
# Run the script.

account_bucket=(
    'dev,bucket_name_1'
    'dev,bucket_name_2'
    'dev,bucket_name_3'
    'prod,bucket_name_4'
)

# analyze buckets
printf "%-8s %-32s %-16s %10s %20s\n" "Acct" "S3 Bucket" "Last Modified" "Object Count" "Size (bytes)"
for account_bucket in ${account_bucket[@]}; do
    account=$(echo $account_bucket | cut -d',' -f1)
    bucket=$(echo $account_bucket | cut -d',' -f2)
    last_modified=$(aws s3 --profile $account ls $bucket --recursive | sort | tail -1 | awk '{print $1}')
    total_objects=$(aws s3 --profile $account ls $bucket --recursive --summarize | grep "Total Objects" | awk '{print $3}')
    size=$(aws s3 --profile $account ls $bucket --recursive --summarize | grep "Total Size" | awk '{print $3}')
    printf "%-8s %-32s %-18s %'10d %'20d\n" "$account" "$bucket" "$last_modified" "$total_objects" "$size"
done
