locals {
  public_subnet_map = {
    for idx, az in var.availability_zones : az => {
      cidr = var.public_subnet_cidrs[idx]
      az   = az
    }
  }

  private_subnet_map = {
    for idx, az in var.availability_zones : az => {
      cidr = var.private_subnet_cidrs[idx]
      az   = az
    }
  }

  nat_gateway_keys = var.enable_nat_gateway ? (var.single_nat_gateway ? [keys(local.public_subnet_map)[0]] : keys(local.public_subnet_map)) : []
}

resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-igw"
  })
}

resource "aws_subnet" "public" {
  for_each = local.public_subnet_map

  vpc_id                  = var.vpc_id
  availability_zone       = each.value.az
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-public-${each.key}"
    Tier = "public"
  })
}

resource "aws_subnet" "private" {
  for_each = local.private_subnet_map

  vpc_id            = var.vpc_id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-private-${each.key}"
    Tier = "private"
  })
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-public-rt"
  })
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  for_each = toset(local.nat_gateway_keys)

  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-nat-eip-${each.key}"
  })
}

resource "aws_nat_gateway" "this" {
  for_each = toset(local.nat_gateway_keys)

  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = aws_eip.nat[each.key].id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-nat-${each.key}"
  })

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-private-rt-${each.key}"
  })
}

resource "aws_route" "private_nat" {
  for_each = var.enable_nat_gateway ? aws_subnet.private : {}

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[var.single_nat_gateway ? local.nat_gateway_keys[0] : each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
