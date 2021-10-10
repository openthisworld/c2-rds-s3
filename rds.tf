resource "aws_db_instance" "itea-rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "test"
  skip_final_snapshot  = true
  publicly_accessible  = true
  username             = "1111"
  password             = "1111"
  parameter_group_name = "default.mysql5.7"

  tags = {
    "Name" = "itea-rds"
  }
}