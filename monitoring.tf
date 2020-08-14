data "aws_region" "current" {}

locals {
  dashboard_template = var.dashboard_template == "" ? "${path.module}/templates/dashboard-default.tpl" : var.dashboard_template
}

data "template_file" "msk_dashboard" {
  //  count = var.create_dashboard ? 1 : 0

  template = file(local.dashboard_template)

  vars = {
    cluster_name = var.cluster_name
    region       = data.aws_region.current.name
  }
}

# Current Dashboard based on DataDog MSK Overview Dashboard
# discussed in an article on their blog:
#   https://www.datadoghq.com/blog/monitor-amazon-msk/

resource "aws_cloudwatch_dashboard" "msk" {
  //  count = var.create_dashboard ? 1 : 0

  dashboard_name = var.cluster_name
  dashboard_body = data.template_file.msk_dashboard.rendered
}

resource "aws_cloudwatch_metric_alarm" "msk_broker_disk_space" {
  count = var.create_cw_alarm ? var.num_of_broker_nodes : 0

  alarm_name                = "${var.cluster_name}-DataLogs-DiskUsed-Broker-${count.index + 1}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "KafkaDataLogsDiskUsed"
  namespace                 = "AWS/Kafka"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "85"
  alarm_description         = "This metric monitors the MSK Broker Data Logs Disk Usage"
  insufficient_data_actions = []

  dimensions = {
    "Cluster Name" = var.cluster_name
    "Broker ID"    = count.index + 1
  }

  tags = merge(map("Name", var.cluster_name), var.tags)
}
