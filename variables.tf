variable "create" {
  description = "Whether or not to create the MSK Cluster"
  type        = bool
  default     = true
}

variable "create_kms_key" {
  description = "Bool to create kms key"
  type        = bool
  default     = true
}

variable "custom_kms_key" {
  description = "ARN to kms key to use instead of creating"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "Name of the MSK Cluster"
  type        = string
}

variable "use_custom_configuration" {
  description = "Use a custom configuration on each Kafka Broker"
  type        = bool
  default     = false
}

variable "use_client_authentication" {
  description = "Use client authentication"
  type        = bool
  default     = false
}

#######
# Kafka
#######
variable "kafka_version" {
  description = "Desired Kafka software version"
  type        = string
  default     = "2.2.1"
}

#########
# Network
#########
variable "subnet_ids" {
  description = "A list of subnets to connect to in the client VPC"
  type        = list(string)
  default     = null
}

variable "vpc_id" {
  description = "The VPC ID for the MSK Cluster"
  type        = string
  default     = ""
}

########
# Broker
########
variable "num_of_broker_nodes" {
  description = "Desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets"
  type        = number
  default     = 3
}

variable "broker_node_instance_type" {
  description = "Instance type to use for the Kafka brokers"
  type        = string
  default     = "kafka.m5.large"
}

variable "broker_ebs_volume_size" {
  description = "Size in GiB of the EBS volume for the data drive on each broker node"
  type        = number
  default     = 100
}

variable "create_open_monitoring" {
  description = "Bool to create prometheus exporters on ports "
}

variable "additional_security_groups" {
  description = "A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster"
  type        = list(string)
  default     = []
}

variable "client_broker_encryption" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT and PLAINTEXT"
  type        = string
  default     = "TLS"
}

variable "in_cluster_encryption" {
  description = "Whether data communication among broker nodes is encrypted"
  type        = bool
  default     = true
}

variable "encryption_kms_key_arn" {
  description = "KMS key short ID or ARN to use for encrypting your data at rest. If no key is specified an AWS managed KMS key will be used for encrypting the data at rest"
  type        = string
  default     = ""
}

variable "certificate_authority_arns" {
  description = "List of ACM Certificate Authority Amazon Resource Names (ARNS)"
  type        = list(string)
  default     = []
}

variable "enhanced_monitoring_level" {
  description = "Desired enhanced MSK CloudWatch monitoring level. Valid values are DEFAULT, PER_BROKER, or PER_TOPIC_PER_BROKER"
  type        = string
  default     = "DEFAULT"
}

variable "msk_broker_log_group_name" {
  description = "The name of the CloudWatch log group where the MSK broker logs are sent. Defaults to `/aws/msk/{cluster_name}/brokers`"
  type        = string
  default     = ""
}

variable "msk_broker_log_group_retention_period" {
  description = "The CloudWatch Log Group retention period in days. Defaults to `30` days"
  type        = number
  default     = 30
}

## Configuration

variable "msk_configuration_name" {
  description = "Name of the MSK Custom configuration - blank for cluster name"
  type        = string
  default     = ""
}

variable "custom_configuration_description" {
  description = "Description of the MSK Custom configuration"
  type        = string
  default     = ""
}

variable "msk_configuration_arn" {
  description = "ARN of the MSK Configuration to use in the cluster"
  type        = string
  default     = ""
}

variable "msk_configuration_revision" {
  description = "Revision of the MSK Configuration to use in the cluster"
  type        = number
  default     = 1
}

variable "server_properties" {
  description = "Contents of the server.properties file for Kafka broker"
  type        = string
  default     = <<EOF
auto.create.topics.enable = false
default.replication.factor = 3
delete.topic.enable = true
min.insync.replicas = 2
num.io.threads = 8
num.network.threads = 5
num.partitions = 1
num.replica.fetchers = 2
socket.request.max.bytes = 104857600
unclean.leader.election.enable = true
EOF
}

## Dashboard
variable "create_dashboard" {
  description = "Whether or not to create the MSK Dashboard"
  type        = bool
  default     = false
}

variable "dashboard_template" {
  description = "Location for the custom MSK Dashboard template"
  type        = string
  default     = ""
}


variable "create_cw_alarm" {
  description = "Whether or not to create a Broker Diskspace CloudWatch Alarm"
  type        = bool
  default     = false
}

## VPC

variable "tags" {
  description = "Additional tags to apply to all module resources"
  type        = map(any)
  default     = {}
}
