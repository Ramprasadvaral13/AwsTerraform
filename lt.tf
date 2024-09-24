resource "aws_launch_template" "demo-lt" {
    image_id = var.image
    instance_type = var.instance
    network_interfaces {
      security_groups = [ aws_security_group.my-sg.id ]
      subnet_id = aws_subnet.demo-vpc-public-subnet.id
      associate_public_ip_address = false
    }
  
}