resource "aws_launch_template" "app_lt" {
  name_prefix   = "codedeploy-lt-"
  image_id      = var.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git
              cd /home/ec2-user
              git clone https://github.com/joaov-barbosa/app-teste-web.git
              cd app-teste-web
              sudo chmod 770 start.sh
              sudo ./start.sh
            EOF
  )
}
