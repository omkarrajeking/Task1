variable "cidr_block"{
  default = "12.0.0.0/16"
}

variable "vpc_name" {
  default = "Task3"
}


variable "subnet1_cidr_block" {
  default = "12.0.1.0/24"
}

variable "subnet2_cidr_block" {
  default = "12.0.3.0/24"
}

# variable "new_security_group_id" {
#    default = "sg-00a1482f9e9149b99"
#    description = "Security group ID for the ECS service"
# }

variable "zone1" {
  default = "ap-south-1a"
}
variable "zone2" {
  default = "ap-south-1b"
}
variable "sub1" {
  default = "sub-1"
}

variable "sub2" {
  default = "sub-2"     
  
}

variable "table1" {
  default = "table-1"
}
