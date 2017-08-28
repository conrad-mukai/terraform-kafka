# Kafka Module

## Description

This module creates a Kafka cluster.

## Variables

Name | Description | Default
---- | ----------- | -------
`app_name` | application name | |
`bastion_ip` | bastion IP address for ssh access | |
`bastion_private_key` | local path to ssh private key for bastion access | |
`brokers_per_az` | number of Kafka brokers per AZ | |
`cloudwatch_alarm_arn` | cloudwatch alarm ARN | |
`ebs_device_name` | EBS attached device | /dev/xvdf |
`ebs_mount_point` | mount point for EBS volume | /mnt/kafka |
`ebs_volume_ids` | list of EBS volume IDs | |
`environment` | environment to configure | |
`iam_instance_profile` | IAM instance profile | |
`kafka_ami` | AWS AMI for kafka | |
`kafka_instance_type` | instance type for kafka server | |
`kafka_repo` | Kafka distro site | http://apache.org/dist/kafka |
`kafka_user` | user in kafka AMI | |
`kafka_version` | Kafka version | 0.11.0.0 |
`key_name` | key pair for SSH access | |
`log_retention` | retention period (hours) | 168 |
`num_partitions` | number of partitions per topic | 1 |
`private_key` | local path to ssh private key | |
`scala_version` | Scala version used in Kafka package | 2.12 |
`subnet_ids` | list of subnet IDs | |
`static_subnet_ids` | list of subnet IDs for static IP addresses (for zookeeper) |
`security_group_ids` | comma-separated list of security groups | |
`zookeeper_addr` | network number for zookeeper addresses | |
`zookeeper_ami` | AWS AMI for zookeeper | |
`zookeeper_instance_type` | instance type for zookeeper server | |
`zookeeper_repo` | Zookeeper distro site | http://apache.org/dist/zookeeper |
`zookeeper_user` | user in zookeeper AMI | |
`zookeeper_version` | Zookeeper version | 3.4.10 |

## Outputs

Name | Description
---- | -----------
`zk_connect` | Zookeeper connection string |

## Tests
The test documentation can be found in test/main.tf.
