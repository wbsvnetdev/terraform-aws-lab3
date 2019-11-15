#----networking/main.tf----

data "aws_availability_zones" "available" {}

resource "aws_vpc" "lab_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "lab_vpc"
  }
}

resource "aws_internet_gateway" "lab_internet_gateway" {
  vpc_id = "${aws_vpc.lab_vpc.id}"

  tags {
    Name = "lab_igw"
  }
}

resource "aws_route_table" "lab_public_rt" {
  vpc_id = "${aws_vpc.lab_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.lab_internet_gateway.id}"
  }

  tags {
    Name = "lab_public_rt"
  }
}


resource "aws_subnet" "lab_public_subnet" {
  count			  = 2
  vpc_id                  = "${aws_vpc.lab_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "lab_public_${count.index +1}"
  }
}

resource "aws_route_table_association" "lab_public_assoc" {
  count          ="${aws_subnet.lab_public_subnet.count}" 
  subnet_id      = "${aws_subnet.lab_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.lab_public_rt.id}"
}

resource "aws_security_group" "lab_public_sg" {
  name        = "lab_public_sg"
  description = "Used for access to lab-app"
  vpc_id      = "${aws_vpc.lab_vpc.id}"

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  #HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
