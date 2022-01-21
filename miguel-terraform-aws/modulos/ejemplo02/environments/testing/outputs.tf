output "connection_string" {
  value       = "ssh -l ubuntu ${module.ec2.eip}"
}
