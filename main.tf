terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.81.0"
        }
    }
}
provider "aws" {
    region = "us-east-1"
}

variable "ami" {
    description = "ami for the stage"
}

variable "instance_type" {
    description = "value"
    type = map(string)

    default = {
        dev = "t2.micro"
        stage = "t2.medium"
        test = "t2.xlarge"
    }
}

module "ec2_instance" {
    source = "./modules/ec2-instance"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}