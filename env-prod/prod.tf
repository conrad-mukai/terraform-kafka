provider "aws" {
    region = "us-east-1"
}

data "aws_availability_zone" "prod" {
    name = "us-east-1a" 
}

module "kafka" {
    source = "../modules/kafka"

    availability_zone = "${data.aws_availability_zone.prod.name}"

    # Network and User configuration
    environment = "placenote-demo"
    app_name = "kafka"

    iam_instance_profile = "OpsTools"
    subnet_ids = ["subnet-c19f3bee"]
    static_subnet_ids = ["subnet-c19f3bee"]
    security_group_ids = ["sg-8ca35bc5"]

    # Bastion machine information where the SSH can happen
    bastion_ip = "54.210.22.199"
    bastion_private_key = "/Users/saurabhjain/Downloads/saurabh-throwaway.pem"
    bastion_user = "ec2-user"
    private_key = "/Users/saurabhjain/Downloads/saurabh-throwaway.pem"

    # Kafka cluster configuration
    ebs_volume_ids = ["vol-05d4ba2c56b9de23f", "vol-07a4bdf7a09ff2383", "vol-02de324f1619d4302", "vol-06f4dc86fac846672", "vol-06286c41e35683633", "vol-036818006ef643252", "vol-0ac08d2d8b8307491", "vol-055d466bf1109e95d", "vol-0ce5d2c0d8f8c4c19"]
    ebs_attachment_strategy = "aws_volume_attachment.prod.*.id"

    key_name = "saurabh-throwaway"
    kafka_ami = "ami-1853ac65"
    kafka_instance_type = "m5.large"
    kafka_version = "1.1.0"
    kafka_user = "ec2-user"
    log_retention = "10"  # in hours
    num_partitions = 30
    brokers_per_az = 3

    # Zookeeper configuration
    zookeeper_instance_type = "t2.medium"
    zookeeper_addr = 30
    zookeeper_ami = "ami-1853ac65"
    zookeeper_user = "ec2-user"

    # Cloudwatch SNS Topic Notification
    cloudwatch_alarm_arn = "arn:aws:sns:us-east-1:489114792760:Kafka"
}
