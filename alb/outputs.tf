output "internal_lb_name" {
  value = aws_lb.internal.dns_name
}

output "public_lb_name" {
  value = aws_lb.public.dns_name
}