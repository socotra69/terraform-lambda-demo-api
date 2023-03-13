output "private_rt" {
  value = aws_route_table.private
}

output "public_subnets" {
  value = aws_subnet.public
}

output "private_subnets" {
  value = aws_subnet.private
}
