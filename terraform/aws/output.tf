# output "master_instance_id" {
#   value = aws_instance.k3s_master.id
# }

# output "worker_instance_ids" {
#   value = aws_instance.k3s_worker[*].id
# # }

# output "master_instance_ip" {
#   value = aws_instance.k3s_master.public_ip
# }

# output "worker_instance_ips" {
#   value = aws_instance.k3s_worker[*].public_ip
# }

# output "security_group_id" {
#   value = aws_security_group.k3s_sg.id
# }

output "master" {
  value     = "ssh -i ${path.root}/aws-key-pair.pem ubuntu@${aws_instance.k3s_master.public_ip}"
  sensitive = false
}
output "node1" {
  value     = "ssh -i ${path.root}/aws-key-pair.pem ubuntu@${aws_instance.k3s_worker[0].public_ip}"
  sensitive = false
}
output "node2" {
  value     = "ssh -i ${path.root}/aws-key-pair.pem ubuntu@${aws_instance.k3s_worker[1].public_ip}"
  sensitive = false
}