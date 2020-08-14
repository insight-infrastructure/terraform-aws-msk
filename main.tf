
resource "random_pet" "this" {
  length = 2
}

resource "aws_kms_key" "kms" {
  count       = var.create_kms_key == "" ? 1 : 0
  description = "MSK - ${var.cluster_name}"
  tags        = var.tags
}

resource "aws_msk_cluster" "this" {
  count = var.create ? 1 : 0

  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.num_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_node_instance_type
    ebs_volume_size = var.broker_ebs_volume_size
    client_subnets  = var.subnet_ids
    security_groups = concat(var.additional_security_groups, aws_security_group.this.*.id)
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = var.create_kms_key == "" ? aws_kms_key.kms[0].arn : var.custom_kms_key
  }

  //  encryption_info {
  //    encryption_in_transit {
  //      client_broker = var.client_broker_encryption
  //      in_cluster    = var.in_cluster_encryption
  //    }
  //
  //    encryption_at_rest_kms_key_arn = var.encryption_kms_key_arn
  //  }

  enhanced_monitoring = var.enhanced_monitoring_level


  //  dynamic "configuration_info" {
  //    for_each = var.count_custom_configuration == 1 ? ["enabled"] : []
  //    content {
  //      arn      = var.msk_configuration_arn
  //      revision = var.msk_configuration_revision
  //    }
  //  }
  //
  //
  //  dynamic "client_authentication" {
  //    for_each = var.count_client_authentication == 1 ? ["enabled"] : []
  //    content {
  //      tls {
  //        certificate_authority_arns = var.certificate_authority_arns
  //      }
  //    }
  //  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk_broker_log_group.name
      }
    }
  }

  tags = merge(map("Name", var.cluster_name), var.tags)
}



resource "aws_msk_configuration" "this" {
  kafka_versions = [var.kafka_version]

  name        = var.msk_configuration_name == "" ? var.cluster_name : var.msk_configuration_name
  description = var.custom_configuration_description

  server_properties = <<PROPERTIES
  ${var.server_properties}
PROPERTIES
}

resource "aws_cloudwatch_log_group" "msk_broker_log_group" {
  name              = var.msk_broker_log_group_name == "" ? "/aws/msk/${var.cluster_name}/brokers" : var.msk_broker_log_group_name
  retention_in_days = var.msk_broker_log_group_retention_period

  tags = merge(map("Name", var.cluster_name), var.tags)
}