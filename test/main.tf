/*
 * Kafka test
 *
 * To run the test do the following:
 *   1. create a terraform.tfvars from the example file;
 *   2. terraform init;
 *   3. terraform apply -target module.network; and
 *   4. terraform apply.
 */

provider "aws" {
  region = "${var.region}"
}

resource "aws_eip" "public-ips" {
  count = "${length(var.availability_zones)}"
  vpc = true
}

module "network" {
  source = "git::https://github.com/conrad-mukai/terraform-network.git"
  environment = "${var.environment}"
  app_name = "infra"
  cidr_vpc = "${var.cidr_vpc}"
  availability_zones = "${var.availability_zones}"
  nat_eips = "${aws_eip.public-ips.*.id}"
  allowed_ingress_list = "${var.allowed_ingress_list}"
  bastion_ami = "${var.ami}"
  bastion_user = "${var.user}"
  private_key_path = "${var.private_key_path}"
  authorized_keys = "${file(var.authorized_key_path)}"
  key_name = "${var.key_name}"
}

module "kafka_volumes" {
  source = "git::https://github.com/conrad-mukai/terraform-ebs-volume.git"
  volumes_per_az = "${var.brokers_per_az}"
  environment = "${var.environment}"
  app_name = "infra"
  role = "kafka"
  availability_zones = "${var.availability_zones}"
  type = "sc1"
  size = 500
}

module "kafka" {
  source = ".."
  environment = "${var.environment}"
  app_name = "infra"
  ebs_volume_ids = "${module.kafka_volumes.volume_ids}"
  subnet_ids = "${module.network.private_subnet_ids}"
  static_subnet_ids = "${module.network.static_subnet_ids}"
  security_group_ids = ["${module.network.internal_security_group_id}"]
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name = "${var.key_name}"
  zookeeper_ami = "${var.ami}"
  zookeeper_user = "${var.user}"
  zookeeper_instance_type = "${var.zookeeper_instance_type}"
  zookeeper_addr = "${var.zookeeper_addr}"
  brokers_per_az = "${var.brokers_per_az}"
  kafka_ami = "${var.ami}"
  kafka_user = "${var.user}"
  kafka_instance_type = "${var.kafka_instance_type}"
  num_partitions = "${var.num_partitions}"
  bastion_ip = "${module.network.bastion_ips[0]}"
  bastion_user = "${var.user}"
  private_key = "${var.private_key_path}"
  bastion_private_key = "${var.bastion_private_key_path}"
  cloudwatch_alarm_arn = "${var.cloudwatch_alarm_arn}"
}
