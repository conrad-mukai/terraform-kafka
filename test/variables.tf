/*
 * Kafka test variables
 */

variable "region" {
  type = "string"
}

variable "environment" {
  type = "string"
}

variable "ami" {
  type = "string"
}

variable "user" {
  type = "string"
}

variable "key_name" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "cidr_vpc" {
  type = "string"
}

variable "allowed_ingress_list" {
  type = "list"
}

variable "authorized_key_path" {
  type = "string"
}

variable "zookeeper_instance_type" {
  type = "string"
}

variable "zookeeper_addr" {
  type = "string"
}

variable "brokers_per_az" {
  type = "string"
}

variable "num_partitions" {
  type = "string"
}

variable "kafka_instance_type" {
  type = "string"
}

variable "iam_instance_profile" {
  type = "string"
}

variable "private_key_path" {
  type = "string"
}

variable "bastion_private_key_path" {
  type = "string"
}

variable "cloudwatch_alarm_arn" {
  type = "string"
}
