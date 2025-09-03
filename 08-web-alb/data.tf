## fetching app_alb sg id ##
data "aws_ssm_parameter" "web_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/web_alb_sg_id"
}

## fetching private subnet ids ##
data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

## fetching acm certificate arn ##
data "aws_ssm_parameter" "acm_certificate_arn" {
    name = "/${var.project_name}/${var.environment}/acm_certificate_arn"
}