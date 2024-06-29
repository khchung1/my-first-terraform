resource "aws_instance" "public" {
  ami                         = "ami-008c09a18ce321b3c"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0cc94b815da8f0c95"
  associate_public_ip_address = true
  key_name                    = "kokhui-key" #Change to your keyname 
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
 
  tags = {
    Name = "khchung-ec2"    #Change to your name
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "kokhui-sg" #Change
  description = "Allow SSH inbound and all outbound"
  vpc_id      = "vpc-071f8836040c9beba"  #VPC Id of the default VPC
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "128.106.234.117/32"  #Get your public ip from whatismyip.com.Add /32
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


output "instance_public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the EC2 instance"
}
