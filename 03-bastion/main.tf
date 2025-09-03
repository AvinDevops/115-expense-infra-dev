### creating bastion instance ###
module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = local.bastion_name

  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  ami = data.aws_ami.ami_info.id
  subnet_id     = local.public_subnet_id
  user_data = file("bastion.sh")

  tags = merge (
    var.common_tags,
    {
        Name = local.bastion_name
    }
  )
}