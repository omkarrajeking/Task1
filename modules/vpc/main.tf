resource "aws_vpc" "Task"{
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "Task" {
    vpc_id = aws_vpc.Task.id
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "sub-1" {
    vpc_id = aws_vpc.Task.id
    cidr_block = var.subnet1_cidr_block
    availability_zone = var.zone1
    map_public_ip_on_launch = true
    tags = {
        Name = var.sub1
    }
}


resource "aws_subnet" "sub-2" {
    vpc_id = aws_vpc.Task.id
    cidr_block = var.subnet2_cidr_block
    availability_zone = var.zone2
    map_public_ip_on_launch = true
    tags = {
        Name = var.sub2
    }
}


resource "aws_route_table" "table-1" {
    vpc_id = aws_vpc.Task.id
    tags = {
        Name = var.table1
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Task.id
    }
}

resource "aws_route_table_association" "Task-association-1" {
  subnet_id      = aws_subnet.sub-1.id
  route_table_id = aws_route_table.table-1.id
}


resource "aws_route_table_association" "Task-association-2" {
  subnet_id      = aws_subnet.sub-2.id
  route_table_id = aws_route_table.table-1.id
}