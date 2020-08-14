# terraform-aws-msk

[![open-issues](https://img.shields.io/github/issues-raw/insight-infrastructure/terraform-aws-msk?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-aws-msk/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-infrastructure/terraform-aws-msk?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-aws-msk/pulls)

## Features

This module...

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/terraform-aws-msk"

}
```
## Examples

- [defaults](https://github.com/insight-infrastructure/terraform-aws-msk/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_security\_groups | A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster | `list(string)` | `[]` | no |
| broker\_ebs\_volume\_size | Size in GiB of the EBS volume for the data drive on each broker node | `number` | `100` | no |
| broker\_node\_instance\_type | Instance type to use for the Kafka brokers | `string` | `"kafka.m5.large"` | no |
| certificate\_authority\_arns | List of ACM Certificate Authority Amazon Resource Names (ARNS) | `list(string)` | `[]` | no |
| client\_broker\_encryption | Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS\_PLAINTEXT and PLAINTEXT | `string` | `"TLS"` | no |
| cluster\_name | Name of the MSK Cluster | `string` | n/a | yes |
| create | Whether or not to create the MSK Cluster | `bool` | `true` | no |
| create\_cw\_alarm | Whether or not to create a Broker Diskspace CloudWatch Alarm | `bool` | `false` | no |
| create\_dashboard | Whether or not to create the MSK Dashboard | `bool` | `false` | no |
| create\_kms\_key | Bool to create kms key | `bool` | `true` | no |
| custom\_configuration\_description | Description of the MSK Custom configuration | `string` | `""` | no |
| custom\_kms\_key | ARN to kms key to use instead of creating | `string` | n/a | yes |
| dashboard\_template | Location for the custom MSK Dashboard template | `string` | `""` | no |
| encryption\_kms\_key\_arn | KMS key short ID or ARN to use for encrypting your data at rest. If no key is specified an AWS managed KMS key will be used for encrypting the data at rest | `string` | `""` | no |
| enhanced\_monitoring\_level | Desired enhanced MSK CloudWatch monitoring level. Valid values are DEFAULT, PER\_BROKER, or PER\_TOPIC\_PER\_BROKER | `string` | `"DEFAULT"` | no |
| in\_cluster\_encryption | Whether data communication among broker nodes is encrypted | `bool` | `true` | no |
| kafka\_version | Desired Kafka software version | `string` | `"2.2.1"` | no |
| msk\_broker\_log\_group\_name | The name of the CloudWatch log group where the MSK broker logs are sent. Defaults to `/aws/msk/{cluster_name}/brokers` | `string` | `""` | no |
| msk\_broker\_log\_group\_retention\_period | The CloudWatch Log Group retention period in days. Defaults to `30` days | `number` | `30` | no |
| msk\_configuration\_arn | ARN of the MSK Configuration to use in the cluster | `string` | `""` | no |
| msk\_configuration\_name | Name of the MSK Custom configuration - blank for cluster name | `string` | `""` | no |
| msk\_configuration\_revision | Revision of the MSK Configuration to use in the cluster | `number` | `1` | no |
| num\_of\_broker\_nodes | Desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets | `number` | `3` | no |
| server\_properties | Contents of the server.properties file for Kafka broker | `string` | `"auto.create.topics.enable = false\ndefault.replication.factor = 3\ndelete.topic.enable = true\nmin.insync.replicas = 2\nnum.io.threads = 8\nnum.network.threads = 5\nnum.partitions = 1\nnum.replica.fetchers = 2\nsocket.request.max.bytes = 104857600\nunclean.leader.election.enable = true\n"` | no |
| subnet\_ids | A list of subnets to connect to in the client VPC | `list(string)` | n/a | yes |
| tags | Additional tags to apply to all module resources | `map(any)` | `{}` | no |
| use\_client\_authentication | Use client authentication | `bool` | `false` | no |
| use\_custom\_configuration | Use a custom configuration on each Kafka Broker | `bool` | `false` | no |
| vpc\_id | The VPC ID for the MSK Cluster | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN for the MSK Cluster |
| bootstrap\_brokers | List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster |
| bootstrap\_brokers\_tls | List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster |
| client\_authentication | Certificate authority arns used for client authentication |
| cloudwatch\_dashboard\_arn | The ARN of the MSK Cloudwatch dashboard |
| cloudwatch\_diskspace\_alarm\_arn | The ARN of the Broker Diskspace CloudWatch Alarm for the MSK Cluster |
| cloudwatch\_diskspace\_alarm\_id | The ID of the Broker Diskspace CloudWatch Alarm for the MSK Cluster |
| custom\_configuration\_arn | Custom configuration ARN |
| custom\_configuration\_latest\_revision | The latest revision of the MSK custom configuration |
| security\_group\_id | MSK Cluster Security Group ID |
| zookeeper\_connect\_string | Zookeeper connection string |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-infrastructure](https://github.com/insight-infrastructure)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.