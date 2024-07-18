resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins_key"
  public_key = file(var.JENKINS_KEY_PUB)
}

resource "aws_instance" "Jenkins_Main" {
  ami           = var.AMI
  instance_type = "t2.small"
  key_name      = aws_key_pair.jenkins_key.key_name
  availability_zone = "us-west-1c"
  security_groups = [aws_security_group.jenkins_security.id]
  root_block_device {
    volume_size = 10
  }
  subnet_id   = aws_subnet.pub-sub-1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = data.aws_secretsmanager_secret_version.my_private_key_jenkins.secret_string
    host        = self.public_ip
  }
  tags = {
    Name = "Jenkins_Main"
  }
}

