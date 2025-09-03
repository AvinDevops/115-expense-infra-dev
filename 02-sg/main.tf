#### security groups ####
### creating db sg ###
module "db" {
    source = "../../114-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for DB Mysql Instances"
    sg_name = "db"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

### creating backend sg ###
module "backend" {
    source = "../../114-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for backend Instances"
    sg_name = "backend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

### creating frontend sg ###
module "frontend" {
    source = "../../114-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for frontend Instances"
    sg_name = "frontend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

### creating bastion sg ###
module "bastion" {
    source = "../../114-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for bastion Instances"
    sg_name = "bastion"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

### creating app_alb sg ###
module "app_alb" {
    source = "../../114-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for app-alb Instances"
    sg_name = "app-alb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

### creating web_alb sg ###
module "web_alb" {
    source = "../../114-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for web-alb Instances"
    sg_name = "web-alb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

### creating vpn sg ###
module "vpn" {
    source = "../../114-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for vpn Instances"
    sg_name = "vpn"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
    inbound_rules = var.vpn_sg_rules
}



#### SG Rules ####

### db ###
## db accepting connection from backend ##
resource "aws_security_group_rule" "db_backend" {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_group_id = module.db.sg_id
    source_security_group_id = module.backend.sg_id
}

## db accepting connection from bastion ##
resource "aws_security_group_rule" "db_bastion" {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_group_id = module.db.sg_id
    source_security_group_id = module.bastion.sg_id
}

## db accepting connection from vpn ##
resource "aws_security_group_rule" "db_vpn" {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_group_id = module.db.sg_id
    source_security_group_id = module.vpn.sg_id
}

### backend ###
## backend accepting connection from app_alb ##
resource "aws_security_group_rule" "backend_app_alb" {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.app_alb.sg_id
}

## backend accepting connection from bastion ##
resource "aws_security_group_rule" "backend_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.bastion.sg_id
}

## backend accepting connection from vpn_ssh ##
resource "aws_security_group_rule" "backend_vpn_ssh" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.vpn.sg_id
}

## backend accepting connection from vpn_http ##
resource "aws_security_group_rule" "backend_vpn_http" {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.vpn.sg_id
}

### app_alb ###
## app_alb accepting connection from vpn ##
resource "aws_security_group_rule" "app_alb_vpn" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_group_id = module.app_alb.sg_id
    source_security_group_id = module.vpn.sg_id
}

## app_alb accepting connection from bastion ##
resource "aws_security_group_rule" "app_alb_bastion" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_group_id = module.app_alb.sg_id
    source_security_group_id = module.bastion.sg_id
}

## app_alb accepting connection from frontend ##
resource "aws_security_group_rule" "app_alb_frontend" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_group_id = module.app_alb.sg_id
    source_security_group_id = module.frontend.sg_id
}

### frontend ###
## frontend accepting connection from web_alb ##
resource "aws_security_group_rule" "frontend_web_alb" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_group_id = module.frontend.sg_id
    source_security_group_id = module.web_alb.sg_id
}

## frontend accepting connection from bastion ##
resource "aws_security_group_rule" "frontend_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_group_id = module.frontend.sg_id
    source_security_group_id = module.bastion.sg_id
}

## frontend accepting connection from vpn ##
resource "aws_security_group_rule" "frontend_vpn" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_group_id = module.frontend.sg_id
    source_security_group_id = module.vpn.sg_id
}

### web_alb ###
## web_alb accepting connection from public ##
resource "aws_security_group_rule" "web_alb_public" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_group_id = module.web_alb.sg_id
    cidr_blocks = ["0.0.0.0/0"]
}

## web_alb accepting connection from public_https ##
resource "aws_security_group_rule" "web_alb_public_https" {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_group_id = module.web_alb.sg_id
    cidr_blocks = ["0.0.0.0/0"]
}


### bastion ###
## bastion accepting connection from public ##
resource "aws_security_group_rule" "bastion_public" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_group_id = module.bastion.sg_id
    cidr_blocks = ["0.0.0.0/0"]
}



