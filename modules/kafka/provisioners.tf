/*
 * Kafka provisioners
 */

resource "null_resource" "zookeeper-nodes" {
  count = "${aws_instance.zookeeper-server.count}"

  triggers {
    zookeeper_id = "${element(aws_instance.zookeeper-server.*.id, count.index)}"
  }

  connection {
    host                = "${element(aws_instance.zookeeper-server.*.private_ip, count.index)}"
    user                = "${var.zookeeper_user}"
    private_key         = "${file(var.private_key)}"
    bastion_host        = "${var.bastion_ip}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${file(var.bastion_private_key)}"
  }

  provisioner "file" {
    content     = "${data.template_file.setup-zookeeper.rendered}"
    destination = "/tmp/setup-zookeeper.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.zookeeper-ctl.rendered}"
    destination = "/tmp/zookeeper-ctl"
  }

  provisioner "file" {
    content     = "${data.template_file.zookeeper-status.rendered}"
    destination = "/tmp/zookeeper-status.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup-zookeeper.sh",
      "sudo /tmp/setup-zookeeper.sh ${count.index+1}",
      "rm /tmp/setup-zookeeper.sh",
      "sudo mv /tmp/zookeeper-ctl /etc/init.d/zookeeper",
      "sudo chmod a+x /etc/init.d/zookeeper",
      "sudo chown root:root /etc/init.d/zookpeer",
      "sudo chkconfig zookeeper on",
      "sudo service zookeeper start",
      "sudo mv /tmp/zookeeper-status.sh /opt/zookeeper",
      "sudo chmod a+x /opt/zookeeper/zookeeper-status.sh",
      "sudo chown zookeeper:zookeeper /opt/zookeeper/zookeeper-status.sh",
      "echo '* * * * * /opt/zookeeper/zookeeper-status.sh' > /tmp/crontab",
      "sudo crontab -u zookeeper /tmp/crontab",
      "rm /tmp/crontab",
    ]
  }
}

resource "null_resource" "kafka-nodes" {
  count      = "${aws_instance.kafka-server.count}"
  depends_on = ["null_resource.zookeeper-nodes"]

  triggers {
    kafka_attach_id = "$(element(var.ebs_attachment_strategy, count.index)}"
    zookeeper_id    = "${join(",", null_resource.zookeeper-nodes.*.id)}"
  }

  connection {
    host                = "${element(aws_instance.kafka-server.*.private_ip, count.index)}"
    user                = "${var.kafka_user}"
    private_key         = "${file(var.private_key)}"
    bastion_host        = "${var.bastion_ip}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${file(var.bastion_private_key)}"
  }

  provisioner "file" {
    content     = "${element(data.template_file.setup-kafka.*.rendered, count.index)}"
    destination = "/tmp/setup-kafka.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.kafka-ctl.rendered}"
    destination = "/tmp/kafka-ctl"
  }

  provisioner "file" {
    content     = "${data.template_file.kafka-status.rendered}"
    destination = "/tmp/kafka-status.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup-kafka.sh",
      "sudo /tmp/setup-kafka.sh ${count.index} ${element(data.aws_subnet.subnet.*.availability_zone, count.index % data.aws_subnet.subnet.count)}",
      "rm /tmp/setup-kafka.sh",
      "sudo mv /tmp/kafka-ctl /etc/init.d/kafka",
      "sudo chmod a+x /etc/init.d/kafka",
      "sudo chown root:root /etc/init.d/kafka",
      "sudo chkconfig kafka on",
      "sudo service kafka start",
      "sudo mv /tmp/kafka-status.sh /opt/kafka",
      "sudo chmod a+x /opt/kafka/kafka-status.sh",
      "echo '* * * * * /opt/kafka/kafka-status.sh' > /tmp/crontab",
      "sudo crontab /tmp/crontab",
      "rm /tmp/crontab",
    ]
  }
}
