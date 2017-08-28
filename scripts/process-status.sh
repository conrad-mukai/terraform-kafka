#!/usr/bin/env bash
#
# Script to check the process and to post the status to CloudWatch.

# get the process status
value=`ps -ef | grep ${service} | grep -v grep | grep -v $0 | wc -l`

# post the status
aws --region ${region} cloudwatch put-metric-data --metric-name ${metric} \
    --namespace CMXAM/Kafka --value $value \
    --dimensions InstanceId=`curl http://169.254.169.254/latest/meta-data/instance-id` \
    --timestamp `date '+%FT%T.%N%Z'`
