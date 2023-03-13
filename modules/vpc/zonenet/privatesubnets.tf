## private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index].cidr
  availability_zone = var.zone

  tags = merge({
    Name = "${var.company}-${var.env}-subnet-${ var.private_subnets[count.index].label}-private-${var.index + count.index}"
    Tier = "Private"
    },
  var.tags)
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
