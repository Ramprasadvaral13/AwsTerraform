resource "aws_key_pair" "demo-tf" {
    key_name = var.key-name
    public_key = file("/Users/ramprasad/.ssh/id_rsa.pub")
  
}

resource "aws_instance" "my-demo" {
    instance_type = var.instance
    ami = var.ami
    key_name = aws_key_pair.demo-tf.key_name
    subnet_id = aws_subnet.demo-vpc-public-subnet.id
    security_groups = [ aws_security_group.my-sg.id ]

    provisioner "remote-exec" {

        inline = [ "sudo apt update" ]

        connection {
          user = "ubuntu"
          type = "ssh"
          private_key = file("/Users/ramprasad/.ssh/id_rsa")
          host = self.public_ip
        }
    }
  
}