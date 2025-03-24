resource "aws_instance" "project_instance" {
  ami             = "ami-08b5b3a93ed654d19"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.project_key.key_name
  security_groups = [aws_security_group.project_sg.name]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "userdata.sh"
    destination = "/tmp/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "sudo /tmp/userdata.sh"
    ]
  }

  tags = {
    Name = "Project Instance"
  }
}

resource "aws_security_group" "project_sg" {
  name        = "project-instance"
  description = "Allow inbound traffic on port 22 and 80"

  # Ingress rule open for all 
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "project_key" {
  key_name   = "project-key"
  public_key = file("~/.ssh/id_rsa.pub")
}