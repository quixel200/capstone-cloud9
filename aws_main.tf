terraform{
    provider "aws"{
        region = "ap-south-1"
    }
resource "aws_security_group" "eks_security_group" {
    name                = "eks_security_group"

    ingress {
        from_port      = 0
        to_port          = 0
        protocol        = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port      = 0
        to_port          = 0
        protocol        = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "eks_security_group"
    }
}

resource "aws_instance" "my-ec2" {
    ami = "ami-09b0a86a2c84101e1"
    instance_type = "t2.micro"
    key_name = <key>
    tags = {
        Name = "eks_ec2"
    }
}

module "eks" {
    source    = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"

    cluster_name        = "my-cluster-eks"
    cluster_version = "1.31"

    cluster_endpoint_public_access = true
    eks_managed_node_groups = {
        green = {
            min_size = 1
            max_size = 1
            desired_size = 1
            instance_types = ["t3.medium"]
        }
    }
}
