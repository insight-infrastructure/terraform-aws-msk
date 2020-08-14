resource "aws_security_group" "this" {
  count = var.create ? 1 : 0

  name        = var.cluster_name
  description = "MSK Security Group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}
