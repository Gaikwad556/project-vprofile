resource "aws_key_pair" "kubernetes_key" {
  key_name   = "kubernetes_key"
  public_key = file(var.KUBERNETES_KEY_PUB)
}

resource "aws_instance" "Kubernetes_Main" {
  ami               = var.AMI
  instance_type     = "t2.small"
  key_name          = aws_key_pair.kubernetes_key.key_name
  availability_zone = "us-west-1b"
  security_groups   = [aws_security_group.kubernetes_security.id]
  root_block_device {
    volume_size = 10
  }
  subnet_id = aws_subnet.pub-sub-1.id

  tags = {
    Name = "Kubernetes_Main"
  }
}

