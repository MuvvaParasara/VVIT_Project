output "name" {
    value = aws_db_instance.project_db.id
}

output "address" {
    value = aws_db_instance.project_db.address
}

output "port" {
    value = aws_db_instance.project_db.port
}

output "username" {
    value = aws_db_instance.project_db.username
}

output "db_name" {
    value = aws_db_instance.project_db.db_name
}

output "engine" {
    value = aws_db_instance.project_db.engine
}

output "project_ec2_ip" {
    value = aws_instance.project_instance.public_ip
}