output "eks-node-instance-zone" {
  value = data.aws_instance.this.availability_zone
}

output "ebs-id" {
  value = aws_ebs_volume.this.id
}
