provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "alexis_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "alexis_subnet" {
  vpc_id     = aws_vpc.alexis_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "alexis_security_group" {
  vpc_id = aws_vpc.alexis_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "alexis_instance" {
  ami           = "ami-0183b16fc359a89dd"  # Replace this with your desired Linux AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.alexis_subnet.id

  tags = {
    Name = "alexis-instance-test"
  }
}

output "ec2_host" {
  value = aws_instance.alexis_instance.public_dns
}

output "ec2_username" {
  value = "ec2-user"  # Default username for most Linux AMIs
}
