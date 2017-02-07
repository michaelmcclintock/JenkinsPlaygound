provider "aws" {
  access_key = "$ACCESS_KEY"
  secret_key = "$SECRET_KEY"
  region     = "us-west-2a"
}

resource "aws_instance" "example" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
}
