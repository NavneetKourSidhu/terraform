# provider 

provider "aws" {
    region = "us-east-1"
}

/*resource "<provider>_<resource_type>" "name" {
    config options.....
    key = "value"
    key1 = "another value"
}*/

# instance creation

resource "aws_instance" "server-1" {
    ami = ""
    instance_type = "t2.micro"
    tags = {
        Name = "ubuntu"
    }
}

# vpc creation

resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name "development"
    }
}

# subnet

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.vpc-1
    cidr_block = "10.0.0.1/24"
    tags = {
        Name = "dev-subnet"
    }
}
 
# Internet gateway

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.vpc-1.id
}

# Route table

resource "aws_route_table" "dev-route-table" {
    vpc_id = aws_vpc.vpc-1.id

    route {
      cidr_block = "10.0.0.1/24"
      gateway_id = aws_internet_gateway.gw.id
}

}

resource "aws_route_table_association" "rt-a" {

    subnet_id = aws_subnet.subnet-1.id
    route_table_id = aws_route_table.rt-a.id
}


