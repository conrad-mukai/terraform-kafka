/*
 * Kafka EBS configuration
 */

resource "aws_volume_attachment" "prod" {
  count       = "${aws_instance.kafka-server.count}"
  device_name = "${var.ebs_device_name}"
  volume_id   = "${element(var.ebs_volume_ids, count.index)}"
  instance_id = "${element(aws_instance.kafka-server.*.id, count.index)}"
}

resource "aws_volume_attachment" "staging" {
  count       = "${aws_instance.kafka-server.count}"
  device_name = "${var.ebs_device_name}"
  volume_id   = "${element(aws_ebs_volume.staging.*.id, count.index)}"
  instance_id = "${element(aws_instance.kafka-server.*.id, count.index)}"
}

resource "aws_ebs_volume" "staging" {
  count             = 3
  availability_zone = "${var.availability_zone}"
  size              = 1
}