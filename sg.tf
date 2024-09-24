resource "aws_security_group" "my-sg" {
    vpc_id = aws_vpc.demo-vpc.id
    name = "demo-tf"
    description = "demo-tf"

    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        protocol = "tcp"
        from_port = 22
        to_port = 22
    }

    egress {
        cidr_blocks = [ "0.0.0.0/0" ]
        protocol = "-1"
        from_port = 0
        to_port = 0
    }
  
}

