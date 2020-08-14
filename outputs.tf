
output "security_group_id" {
  description = "MSK Cluster Security Group ID"
  value       = join("", aws_security_group.this.*.id)
}

output "arn" {
  description = "The ARN for the MSK Cluster"
  value       = join("", aws_msk_cluster.this.*.arn)
  depends_on  = [aws_msk_cluster.this]
}

output "zookeeper_connect_string" {
  description = "Zookeeper connection string"
  value       = join("", aws_msk_cluster.this.*.zookeeper_connect_string)
  depends_on  = [aws_msk_cluster.this]
}

# Only contains value if `client_broker` encryption in transit is set to `PLAINTEXT` or `TLS_PLAINTEXT`
output "bootstrap_brokers" {
  description = "List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster"
  value       = join("", aws_msk_cluster.this.*.bootstrap_brokers)
  depends_on  = [aws_msk_cluster.this]
}

# Only contains value if `client_broker` encryption in transit is set to 'TLS_PLAINTEXT` or `TLS`
output "bootstrap_brokers_tls" {
  description = "List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster"
  value       = join("", aws_msk_cluster.this.*.bootstrap_brokers_tls)
  depends_on  = [aws_msk_cluster.this]
}

//output "encryption_at_rest_kms_key_arn" {
//  description = "The ARN of the KMS key used for encryption at rest of the broker data volume"
//  value       = join("", aws_msk_cluster.this.*.encryption_info[0].encryption_at_rest_kms_key_arn)
//  depends_on  = [aws_msk_cluster.this]
//}

output "client_authentication" {
  description = "Certificate authority arns used for client authentication"
  value       = var.certificate_authority_arns
}

output "custom_configuration_arn" {
  description = "Custom configuration ARN"
  value       = join("", aws_msk_configuration.this.*.arn)
  depends_on  = [aws_msk_configuration.this]
}

output "custom_configuration_latest_revision" {
  description = "The latest revision of the MSK custom configuration"
  value       = join("", aws_msk_configuration.this.*.latest_revision)
  depends_on  = [aws_msk_configuration.this]
}

output "cloudwatch_dashboard_arn" {
  description = "The ARN of the MSK Cloudwatch dashboard"
  value       = join("", aws_cloudwatch_dashboard.msk.*.dashboard_arn)
  depends_on  = [aws_cloudwatch_dashboard.msk]
}

output "cloudwatch_diskspace_alarm_arn" {
  description = "The ARN of the Broker Diskspace CloudWatch Alarm for the MSK Cluster"
  value       = join("", aws_cloudwatch_metric_alarm.msk_broker_disk_space.*.arn)
  depends_on  = [aws_cloudwatch_metric_alarm.msk_broker_disk_space]
}

output "cloudwatch_diskspace_alarm_id" {
  description = "The ID of the Broker Diskspace CloudWatch Alarm for the MSK Cluster"
  value       = join("", aws_cloudwatch_metric_alarm.msk_broker_disk_space.*.id)
  depends_on  = [aws_cloudwatch_metric_alarm.msk_broker_disk_space]
}
