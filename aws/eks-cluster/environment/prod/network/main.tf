module "network" {
  source = "../../modules/network"

  vpc_id = aws_vpc.main.id

  azs = {
    a = {
      public_subnet_id  = aws_subnet.public_a.id
      private_subnet_id = aws_subnet.private_a.id
    }
    b = {
      public_subnet_id  = aws_subnet.public_b.id
      private_subnet_id = aws_subnet.private_b.id
    }
  }

  name = "dev"
}
