#!/bin/bash

# This script lists public IP addresses by AWS account (profile) and region.
# This script could be cloned or modified to list other attributes.
# Profiles in the array must match profile names in your ~/.aws/credentials file

profiles=(
    profile_name_1
    profile_name_2
    profile_name_3
)

regions=(
    us-east-1
    us-east-2
    us-west-1
    us-west-2
)

for profile in ${profiles[@]}; do
    echo -e "\nAWS credentials profile: $profile"
    
    for region in ${regions[@]}; do
        echo -e "\nregion: $region\n" 
        
        aws ec2 describe-instances --profile $profile --region $region \
            --query "Reservations[*].Instances[*].PublicIpAddress" --output=text
    done 
done
