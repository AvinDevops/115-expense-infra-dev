## creating parameter for db sg id ##
resource "aws_ssm_parameter" "db_sg_id" {
    name = "/${var.project_name}/${var.environment}/db_sg_id"
    type = "String"
    value = module.db.sg_id
}

## creating parameter for backend sg id ##
resource "aws_ssm_parameter" "backend_sg_id" {
    name = "/${var.project_name}/${var.environment}/backend_sg_id"
    type = "String"
    value = module.backend.sg_id
}

## creating parameter for frontend sg id ##
resource "aws_ssm_parameter" "frontend_sg_id" {
    name = "/${var.project_name}/${var.environment}/frontend_sg_id"
    type = "String"
    value = module.frontend.sg_id
}

## creating parameter for bastion sg id ##
resource "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project_name}/${var.environment}/bastion_sg_id"
    type = "String"
    value = module.bastion.sg_id
}

## creating parameter for app_alb sg id ##
resource "aws_ssm_parameter" "app_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
    type = "String"
    value = module.app_alb.sg_id
}

## creating parameter for web_alb sg id ##
resource "aws_ssm_parameter" "web_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/web_alb_sg_id"
    type = "String"
    value = module.web_alb.sg_id
}

## creating parameter for vpn sg id ##
resource "aws_ssm_parameter" "vpn_sg_id" {
    name = "/${var.project_name}/${var.environment}/vpn_sg_id"
    type = "String"
    value = module.vpn.sg_id
}