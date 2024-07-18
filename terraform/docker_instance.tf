resource "aws_key_pair" "docker_key" {
  key_name   = "docker_key"
  public_key = file(var.DOCKER_KEY_PUB)
}

resource "aws_instance" "Docker_Main" {
  ami               = var.AMI
  instance_type     = "t2.small"
  key_name          = aws_key_pair.docker_key.key_name
  availability_zone = "us-west-1c"
  security_groups   = [aws_security_group.docker_security.id]
  root_block_device {
    volume_size = 10
  }
  subnet_id = aws_subnet.pub-sub-2.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = data.aws_secretsmanager_secret_version.my_private_key_docker.secret_string
    host        = self.public_ip
  }
  tags = {
    Name = "Docker_Main"
  }
}

