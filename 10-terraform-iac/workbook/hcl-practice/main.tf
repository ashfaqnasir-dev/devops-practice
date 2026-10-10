# ============================================
# Block 1: terraform (settings)
# ============================================
terraform {
  required_version = ">= 1.0"
}

# ============================================
# Block 2: variable (input)
# ============================================
variable "filename" {
  description = "File ka naam"
  type        = string
  default     = "greeting.txt"
}

variable "content" {
  description = "File ka content"
  type        = string
  default     = "Hello from Terraform!"
}

# ============================================
# Block 3: locals (computed values)
# ============================================
locals {
  name  = "john cena"
  fruit = ["apple", "banana", "orange"]

  # Complex message using multiple functions
  message = "Hello ${title(local.name)}! I know you like ${join(", ", local.fruit)}. Welcome to Terraform!"

  # Computed values for outputs
  content_upper = upper(var.content)
  content_length = length(var.content)
}

# ============================================
# Block 4: resource (create file)
# ============================================
resource "local_file" "greeting" {
  filename = "${path.module}/${var.filename}"
  content  = var.content
}

# ============================================
# Block 5: resource (create message file)
# ============================================
resource "local_file" "message" {
  filename = "${path.module}/message.txt"
  content  = local.message
}

# ============================================
# Block 6: outputs (results)
# ============================================
output "filename" {
  description = "Bani hui file ka naam"
  value       = var.filename
}

output "content_upper" {
  description = "Content in UPPERCASE"
  value       = local.content_upper
}

output "content_length" {
  description = "Content ki length"
  value       = local.content_length
}

output "message" {
  description = "Generated welcome message"
  value       = local.message
}

output "files_created" {
  description = "Files jo bani"
  value = [
    local_file.greeting.filename,
    local_file.message.filename
  ]
}
