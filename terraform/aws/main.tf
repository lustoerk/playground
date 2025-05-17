resource "aws_instance" "k3s_master" {
  ami = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.k3s_sg.name]
  key_name        = aws_key_pair.aws-keypair.key_name
  
  tags         = {
    Name = "K3s Master"
  }
}
resource "aws_instance" "k3s_worker" {
  count = 2
  ami = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.k3s_sg.name]
  key_name        = aws_key_pair.aws-keypair.key_name
  
  tags = {
    Name = "K3s Worker ${count.index + 1}"
  }
}

resource "tls_private_key" "aws-keypair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  content  = tls_private_key.aws-keypair.private_key_pem
  filename = "${path.root}/aws-key-pair.pem"
}

resource "aws_key_pair" "aws-keypair" {
  key_name   = "aws-key-pair"
  public_key = tls_private_key.aws-keypair.public_key_openssh
}
