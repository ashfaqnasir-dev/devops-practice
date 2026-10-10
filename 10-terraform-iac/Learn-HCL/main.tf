# Learn HCL iwth Cloudchamp

/*
this is 
multi-line comment
*/

#Block
block_type{
    attribute1 = value1
    attribute2 = value2
}

resource "resource_type" "resource_name" {
    attribute1 = value1
    attribute2 = value2
}

resource "aws_instance" "example" {
    ami = "ami=0c8888446665499"
    instance_type = "t2.micro"
    count = 3
    enabled = true
}
key = value

#Data Types
"string"
number 2
boolean true false
list = ["item1","item2","item3"]
security_group_ids = ["sg-12345678", "sg-87654321"]

maps
variable "example_map" {
    type = map
    default = {key1 = value1, key2 = value2, key3 = value3} 
}

local = {
    key1 = value1
    key2 = value2
    key3 = value3
}   

#Conditions
 
resource "aws_instance" "server" {
     instance_type = var.environment == "production" ? "t2.large" : "t2.micro"
}


#Functions
# https://developer.hashicorp.com/terraform/language/functions

locals {
    name = "john cena"
    fruit = ["apple", "banana", "orange"]

    message = "Hello ${upper(local.name)},! I know you like ${join(", ", local.fruit)}! Welcome to Terraform!"
    }

    Hello JOHN CENA,! I know you like apple, banana, orange! Welcome to Terraform!

#ResourcesDependencies

# 1. Neenv (foundation)
resource "foundation" "ghar" { }

# 2. Deewar (foundation ke upar)
resource "wall" "ghar" {
  foundation_id = foundation.ghar.id    ← Dependency
}

# 3. Chhat (deewar ke upar)
resource "roof" "ghar" {
  wall_id = wall.ghar.id    ← Dependency
}
