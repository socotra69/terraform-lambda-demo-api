output "vpc" {
  value = aws_vpc.main
}

output "public_rt" {
  value = aws_route_table.public
}

output "private_rts" {
  value = [
    for net in module.zonenetwork : net.private_rt
  ]
}

output "public_subnets" {
  value = [
    for net in module.zonenetwork : net.public_subnets
  ]
}

output "private_subnets" {
  value = [
    for net in module.zonenetwork : net.private_subnets
  ]
}
