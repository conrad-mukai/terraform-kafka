/*
 * Kafka module outputs
 */

output "zk_connect" {
  value = "${join(",", formatlist("%s:2181", aws_instance.zookeeper-server.*.private_ip))}"
}
