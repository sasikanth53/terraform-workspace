resource "aws_instance" "example" {
  ami                    = "ami-057752b3f1d6c4d6c" # Replace with your desired AMI ID
  instance_type          = "t2.micro"
  key_name   = "${terraform.workspace}-${var.keypair}-${random_integer.ri.result}" # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.sg_web.id]
user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              sudo chmod 777 /usr/share/nginx/html/index.html
              echo '<h1>HashTek solution!</h1>' >> /usr/share/nginx/html/index.html
              sudo systemctl restart nginx
              EOF

  tags = {
    Name = "${terraform.workspace}-${var.instance_name}"
  }
}
