variable "project_name" {
    type = string
    default = "expense"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
        Component = "acm"
    }
}

variable "zone_name" {
    type = string
    default = "aviexpense.online"
}

variable "zone_id" {
    default = "Z074597133KN1IHDWRZO"
}