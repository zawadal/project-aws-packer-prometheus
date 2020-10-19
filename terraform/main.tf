terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  #shared_credentials_file = "C:\\Users\\l00gan\\.aws\\credentials"
}

terraform {
    backend "s3" {
        bucket  = "terraform-myp01-state-bucket"
        key     = "terraform-combined.tfstate"
        region  = "eu-central-1"
    }
}

#state of sample project
data "terraform_remote_state" "awsstate" {
  backend = "s3"
  config = {
    bucket = "terraform-myp01-state-bucket"
    key    = "terraform-myp01-aws.tfstate"
    region = "eu-central-1"
  }
}


data "aws_ami" "myubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["packer-Ubuntu-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["614662575946"] 
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.myubuntu.id
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.awsstate.outputs.publicnetid
  vpc_security_group_ids = list(data.terraform_remote_state.awsstate.outputs.secgroupid)

  tags = {
    Name = "project001-instance"
  }

   provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip} > myip.txt"
  }

}