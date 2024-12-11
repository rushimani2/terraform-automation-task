provider "aws" {
    region = "us-east-1"
}
variable "cidr" {
    default = "10.0.0.0/16"
}

resource "aws_key_pair" "keypair_pem" {
    key_name = "first_key.pem"
    public_key = file("C:/Users/9908216665/.ssh/id_rsa.pub")
}

resource "aws_vpc" "main" {
    cidr_block = var.cidr
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "rtas" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "public_sg" {
    name = "public_sg"
    vpc_id = aws_vpc.main.id

    ingress {
        description = "HTTP from VPC"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH from VPC"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "public_sg"
    }
}
resource "aws_instance" "first_instance" {
    ami = "ami-0e2c8caa4b6378d8c"
    subnet_id = aws_subnet.public_subnet.id
    key_name = aws_key_pair.keypair_pem.key_name
    vpc_security_group_ids = [aws_security_group.public_sg.id]
    instance_type = "t2.micro"
connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("C:/Users/9908216665/.ssh/id_rsa")
    host = self.public_ip
}

provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
}

provisioner "remote-exec" {
    inline = [
        "sudo apt-get update",
        "sudo apt install python3",
        "sudo apt install python3-pip -y",
        "sudo apt install python3-flask -y",
        "cd /home/ubuntu",
        "sudo python3 app.py",
    ]
}
}

