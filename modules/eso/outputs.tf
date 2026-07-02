output "parameter_names" {
  value = {
    for key, parameter in aws_ssm_parameter.secret_parameters : key => parameter.name
  }
}

output "parameter_path_prefix" {
  value = var.parameter_path_prefix
}