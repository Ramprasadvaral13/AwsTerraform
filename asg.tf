resource "aws_autoscaling_group" "my-asg" {
    launch_template {
      id = aws_launch_template.demo-lt.id
      version = "$Latest"
    }
    vpc_zone_identifier = [ aws_subnet.demo-vpc-private-subnet.id ]
    min_size = 1
    max_size = 3
    desired_capacity = 2

  
}