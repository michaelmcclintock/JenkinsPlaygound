provider "aws" {
  access_key = "$ACCESS_KEY"
  secret_key = "$SECRET_KEY"
  region     = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-f173cc91"
  instance_type = "t2.micro"
}
