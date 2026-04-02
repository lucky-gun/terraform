data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name                     = "lucky-gun-public-a"
    Type                     = "public"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.100.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name                     = "lucky-gun-public-b"
    Type                     = "public"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.50.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name                              = "lucky-gun-private-a"
    Type                              = "private"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.150.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name                              = "lucky-gun-private-b"
    Type                              = "private"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
