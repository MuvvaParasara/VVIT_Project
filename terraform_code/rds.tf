resource "aws_security_group" "rds_sg" {
    name_prefix = "rds-sg-"

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "rds-security-group"
    }
}

resource "aws_db_instance" "project_db" {
    allocated_storage    = 10
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    db_name                 = "project_db"
    username             = "admin"
    password             = "password123"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true
    publicly_accessible  = true
    vpc_security_group_ids = [aws_security_group.rds_sg.id]

    tags = {
        Name = "project_db"
    }
}