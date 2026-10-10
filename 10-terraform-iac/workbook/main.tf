terraform {
  required_version = ">= 1.0"
}

resource "local_file" "welcome" {
  filename = "${path.module}/welcome.txt"
  content  = "Welcome to Terraform!\nTime: ${timestamp()}"
}
