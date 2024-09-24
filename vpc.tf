resource "aws_vpc" "demo-vpc" {
    cidr_block = var.cidr
    enable_dns_hostnames = true
    enable_dns_support = true
  
}

resource "aws_internet_gateway" "demo-vpc-igw" {
    vpc_id = aws_vpc.demo-vpc.id
  
}

resource "aws_subnet" "demo-vpc-public-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = var.public-subnet
    availability_zone = var.Az
    map_public_ip_on_launch = true
}

resource "aws_subnet" "demo-vpc-private-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = var.private-subnet
    availability_zone = var.Az
}

resource "aws_route_table" "demo-vpc-public-route" {
    vpc_id = aws_vpc.demo-vpc.id
    route {
        cidr_block = var.route-cidr
        gateway_id = aws_internet_gateway.demo-vpc-igw.id
    }
  
}

resource "aws_route_table_association" "demo-vpc-public-rtba" {
    route_table_id = aws_route_table.demo-vpc-public-route.id
    subnet_id = aws_subnet.demo-vpc-public-subnet.id
  
}

resource "aws_eip" "demo-eip" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "demo-natgateway" {
    subnet_id = aws_subnet.demo-vpc-public-subnet.id
    id = aws_eip.demo-eip.id
  
}

resource "aws_route_table" "demo-vpc-private-route" {
    vpc_id = aws_vpc.demo-vpc.id
    route {
        cidr_block = var.route-cidr
        nat_gateway_id = aws_nat_gateway.demo-natgateway.id
    }
  
}

resource "aws_route_table_association" "demo-vpc-private-rtba" {
    route_table_id = aws_route_table.demo-vpc-private-route.id
    subnet_id = aws_subnet.demo-vpc-private-subnet.id
  
}