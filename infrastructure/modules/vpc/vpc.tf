##### VPC
resource "aws_vpc" "ecs-fider-vpc" {
    cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "ecs-fider-vpc"
  }
}



##### Public Subnets
resource "aws_subnet" "public" {
    count = "${length(var.subnet_cidrs_public)}"
    vpc_id = aws_vpc.ecs-fider-vpc.id

    cidr_block = "${var.subnet_cidrs_public[count.index]}"
    availability_zone = "${var.availability_zones[count.index]}"
    tags = {
        Name = "fider-public-${count.index}"
    }
}

##### Private Subnets
resource "aws_subnet" "private" {
    count = "${length(var.subnet_cidrs_private)}"
    vpc_id = aws_vpc.ecs-fider-vpc.id

    cidr_block = "${var.subnet_cidrs_private[count.index]}"
    availability_zone = "${var.availability_zones[count.index]}"
    tags = {
        Name = "fider-private-${count.index}"
    }
}

##### IGW
resource "aws_internet_gateway" "fider-igw" {
    vpc_id = aws_vpc.ecs-fider-vpc.id
}

##### Elastic IP address
resource "aws_eip" "fider-eip" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.fider-igw]
}


##### NGW
resource "aws_nat_gateway" "fider-ngw" {
    allocation_id = aws_eip.fider-eip.id
    subnet_id = aws_subnet.public[0].id

    depends_on = [aws_internet_gateway.fider-igw]
}


##### Route Table
resource "aws_route_table" "public-2-igw" {
    vpc_id = aws_vpc.ecs-fider-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.fider-igw.id
    }
}

resource "aws_route_table" "private-2-ngw" {
    vpc_id = aws_vpc.ecs-fider-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.fider-ngw.id
    }
}

##### Subnet Association
resource "aws_route_table_association" "public" {
    count = "${length(var.subnet_cidrs_public)}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = aws_route_table.public-2-igw.id
}

resource "aws_route_table_association" "private" {
    count = "${length(var.subnet_cidrs_private)}"
    subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id = aws_route_table.private-2-ngw.id
}