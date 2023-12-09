
resource "aws_vpc" "production_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "Production VPC"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.production_vpc.id
}

resource "aws_eip" "nat_eip" {
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet1.id
    tags = {
      Name = "NAT Gateway"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.production_vpc.id
    route {
        cidr_block = var.all_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "Public RT"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.production_vpc.id
    route {
        cidr_block = var.all_cidr
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
      Name = "Private RT"
    }
}

resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.production_vpc.id
    cidr_block = var.public_subnet1_cidr
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true
    tags = {
      Name = "Public Subnet 1"
    }
}

resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.production_vpc.id
    cidr_block = var.public_subnet2_cidr
    availability_zone = var.availability_zone2
    map_public_ip_on_launch = true
    tags = {
      Name = "Public Subnet 2"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.production_vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.availability_zone2
    tags = {
      Name = "Private Subnet"
    }
}

resource "aws_route_table_association" "public_association1" {
    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_association2" {
    subnet_id = aws_subnet.public_subnet2.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_association" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "jenkins_sg" {
    name = "Jenkins SG"
    description = "Allow ports 8080 and 22"
    vpc_id = aws_vpc.production_vpc.id

    ingress {
        description = "Jenkins"
        from_port = var.jenkins_port
        to_port = var.jenkins_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
        Name = "Jenkins SG"
    }
}

resource "aws_security_group" "sonarqube_sg" {
    name = "Sonarqube SG"
    description = "Allow ports 9000 and 22"
    vpc_id = aws_vpc.production_vpc.id

    ingress {
        description = "Sonarqube"
        from_port = var.sonarqube_port
        to_port = var.sonarqube_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
        Name = "Sonarqube SG"
    }
}

resource "aws_security_group" "ansible_sg" {
    name = "Ansible SG"
    description = "Allow port 22"
    vpc_id = aws_vpc.production_vpc.id

    ingress {
        description = "SSH"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
        Name = "Ansible SG"
    }
}

resource "aws_security_group" "grafana_sg" {
    name = "Grafana SG"
    description = "Allow ports 3000 and 22"
    vpc_id = aws_vpc.production_vpc.id

    ingress {
        description = "Grafana"
        from_port = var.grafana_port
        to_port = var.grafana_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
        Name = "Grafana SG"
    }
}

resource "aws_security_group" "app_sg" {
    name = "Application SG"
    description = "Allow ports 80 and 22"
    vpc_id = aws_vpc.production_vpc.id

    ingress {
        description = "Application"
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
        Name = "Application SG"
    }
}

resource "aws_security_group" "lb_sg" {
    name = "LoadBalancer SG"
    description = "Allow port 80"
    vpc_id = aws_vpc.production_vpc.id

    ingress {
        description = "LoadBalancer"
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
        Name = "LoadBalancer SG"
    }
}

resource "aws_network_acl" "nacl" {
    vpc_id = aws_vpc.production_vpc.id
    subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id, aws_subnet.private_subnet.id]

    egress {
        protocol = "tcp"
        rule_no = "100"
        action = "allow"
        cidr_block = var.vpc_cidr
        from_port = 0
        to_port = 0
    }

    ingress {
        protocol = "tcp"
        rule_no = "100"
        action = "allow"
        cidr_block = var.all_cidr
        from_port = var.http_port
        to_port = var.http_port
    }

    ingress {
        protocol = "tcp"
        rule_no = "101"
        action = "allow"
        cidr_block = var.all_cidr
        from_port = var.ssh_port
        to_port = var.ssh_port
    }

    ingress {
        protocol = "tcp"
        rule_no = "102"
        action = "allow"
        cidr_block = var.all_cidr
        from_port = var.jenkins_port
        to_port = var.jenkins_port
    }

    ingress {
        protocol = "tcp"
        rule_no = "103"
        action = "allow"
        cidr_block = var.all_cidr
        from_port = var.sonarqube_port
        to_port = var.sonarqube_port
    }

    ingress {
        protocol = "tcp"
        rule_no = "104"
        action = "allow"
        cidr_block = var.all_cidr
        from_port = var.grafana_port
        to_port = var.grafana_port
    }

    tags = {
        Name = "Main ACL"
    }
}

resource "aws_ecr_repository" "ecr_repo" {
    name = "docker_repository"

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_key_pair" "auth_key" {
    key_name = var.key_name
    public_key = var.key_value
}


/*terraform {
    backend "s3" {
        bucket = "eldrago-terraform"
        key = "prod/terraform.tfstate"
        region = "us-east-1"
    }
}
*/

resource "aws_instance" "Jenkins" {
    ami = var.linux2_ami
    instance_type = var.micro_instance
    availability_zone = var.availability_zone
    subnet_id = aws_subnet.public_subnet1.id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
    user_data = file("jenkins_install.sh")

    tags = {
        Name = "Jenkins"
    }
}

resource "aws_instance" "Ansible"{
  ami = var.linux2_ami
  instance_type = var.micro_instance
  availability_zone = var.availability_zone
  subnet_id = aws_subnet.public_subnet1.id
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data = file("ansible_install.sh")

  tags = {
    Name = "Ansible"
  }
}

resource "aws_instance" "Sonarqube"{
  ami = var.ubuntu_ami
  instance_type = var.small_instance
  availability_zone = var.availability_zone
  subnet_id = aws_subnet.public_subnet1.id
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]

  tags = {
    Name = "Sonarqube"
  }
}

resource "aws_instance" "Grafana"{
  ami = var.linux2_ami
  instance_type = var.micro_instance
  availability_zone = var.availability_zone
  subnet_id = aws_subnet.public_subnet1.id
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.grafana_sg.id]
  user_data = file("grafana_install.sh")

  tags = {
    Name = "Grafana"
  }
}

resource "aws_launch_configuration" "app-launch-config" {
  name = "app-launch-config"
  image_id      = "ami-00f22f6155d6d92c5"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.app_sg.id]
  key_name = var.key_name
}

resource "aws_autoscaling_group" "app-asg" {
  name                      = "app-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.app-launch-config.name
  vpc_zone_identifier       = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  target_group_arns         = [aws_lb_target_group.app-target-group.arn]
}

resource "aws_lb_target_group" "app-target-group" {
  name     = "app-target-group"
  port     = 80
  target_type = "instance"
  protocol = "HTTP"
  vpc_id   = aws_vpc.production_vpc.id
}

resource "aws_autoscaling_attachment" "autoscaling-attachment" {
  autoscaling_group_name = aws_autoscaling_group.app-asg.id
  alb_target_group_arn   = aws_lb_target_group.app-target-group.arn
}

resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}

resource "aws_lb_listener" "app-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-target-group.arn
  }
}
