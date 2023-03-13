module "zonenetwork" {
  for_each = toset(var.zones)
  source   = "./zonenet"

  vpc_id       = aws_vpc.main.id
  zone         = each.key
  publicrtt_id = aws_route_table.public.id

  public_subnets  = var.public_subnets[each.key]
  private_subnets = var.private_subnets[each.key]

  env     = var.env
  company = var.company
  tags    = var.tags
  index   = var.index

}
