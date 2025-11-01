variable "ami" {
  type = string
}
# variable "count" {
#   type = number
# }
variable "i-type" {
  type = string
}
variable "region" {
  type = list
}
variable "az" {
  type = string
  default = "us-east-2b"
}
variable "api-termn" {
  type = bool
}
variable "role" {
  type = string
}
variable "key" {
  type = string
}





























##########  Practice  ########
# variable "user1" {
#   type    = string
#   default = "Avinash"
# }

# variable "user2" {
#   type    = number
#   default = 1010
# }

# variable "user3" {
#   type    = list
#   default = ["Sahil","Amit","Sneha","Aditya","Suhas" ]
#            #    0       1      2       3       4
# }

# variable "user4" {
#   type    = map
#   default = {
#     u1 = "Sahil"
#     certified = "Amit"
#     u3 = "abcd"
#     u4 = "Sneha"

#   }
# }

# variable "all" {
#   type    = any
#   default = {
#     u1 = "Sakshi"
#     n1 = 09251400 
#     l1= ["Sahil","Amit","Sneha","Aditya","Suhas" ]
#     map = {
#       map_a = "user_1"
#       map_b = "user_11"
#       map_c = "user_12"
#       map_d = "user_13"
#       map_e = "user_14"
#     }
#   }
# }