output "invoke_url_with_vacunas" {
  value = format("%s/vacunas", aws_api_gateway_deployment.vacunas_api_deployment.invoke_url)
}

data "local_file" "script_template" {
  filename = "${path.module}/script_template.js"
}

resource "local_file" "generated_script" {
  content  = templatefile(data.local_file.script_template.filename, { invoke_url = aws_api_gateway_deployment.vacunas_api_deployment.invoke_url })
  filename = "${path.module}/scripts/generated_script.js"
}
