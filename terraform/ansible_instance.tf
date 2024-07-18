resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible_key"
  public_key = file(var.ANSIBLE_KEY_PUB)
}

resource "aws_instance" "Ansible_Main" {
  ami               = var.AMI
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.ansible_key.key_name
  availability_zone = "us-west-1b"
  security_groups   = [aws_security_group.ansible_security.id]
  root_block_device {
    volume_size = 10
  }
  subnet_id = aws_subnet.pub-sub-1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = data.aws_secretsmanager_secret_version.my_private_key_ansible.secret_string
    host        = self.public_ip
  }
  tags = {
    Name = "Ansible_Main"
  }
}

