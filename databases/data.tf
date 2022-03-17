data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "^Centos-7*"
  owners           = ["973714476881"]
}
