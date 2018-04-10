# Network and User configuration
region = "us-east-1"
environment = "sjain"
app_name = "kafka"
availability_zones = ["us-east-1a"]
cidr_vpc = "172.31.0.0/16"
ami = "ami-1853ac65" # Amazon Linux AMI (Community)
user = "ec2-user"
iam_instance_profile = "OpsTools"
#subnet_ids = ["subnet-05066d61", "subnet-9e1d9ea1", "subnet-0813ca55","subnet-c19f3bee", "subnet-1c7e1e57", "subnet-5ce7f050"]
#static_subnet_ids = ["subnet-05066d61","subnet-9e1d9ea1", "subnet-0813ca55","subnet-c19f3bee", "subnet-1c7e1e57", "subnet-5ce7f050"]
subnet_ids = ["subnet-c19f3bee"]
static_subnet_ids = ["subnet-c19f3bee"]
security_group_ids = ["sg-8ca35bc5"]
private_key_path = "/Users/saurabhjain/Downloads/saurabh-throwaway.pem"

# Bastion machine information where the SSH can happen
bastion_ip = "54.210.22.199"
bastion_private_key = "/Users/saurabhjain/Downloads/saurabh-throwaway.pem"
bastion_user = "ec2-user"
private_key = "/Users/saurabhjain/Downloads/saurabh-throwaway.pem"


# Kafka cluster configuration

ebs_volume_ids = ["vol-05d4ba2c56b9de23f", "vol-07a4bdf7a09ff2383", "vol-02de324f1619d4302", "vol-06f4dc86fac846672", "vol-06286c41e35683633", "vol-036818006ef643252", "vol-0ac08d2d8b8307491"]
key_name = "saurabh-throwaway"
kafka_ami = "ami-1853ac65"
kafka_instance_type = "m4.large"
kafka_version = "1.1.0"
kafka_user = "ec2-user"
log_retention = "10"  # in hours
num_partitions = 30
brokers_per_az = 2


# Zookeeper configuration

zookeeper_instance_type = "t2.medium"
zookeeper_addr = 20
zookeeper_ami = "ami-1853ac65"
zookeeper_user = "ec2-user"
