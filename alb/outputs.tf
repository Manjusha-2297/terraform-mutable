output "INTERNAL_LB_NAME" {
  value = aws_lb.internal.dns_name
}

output "PUBLIC_LB_NAME" {
  value = aws_lb.public.dns_name
}