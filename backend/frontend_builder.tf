resource "local_file" "script_js" {
  content  = templatefile("./script.js.tpl", {
    invoke_url = "${aws_api_gateway_deployment.api_deployment.invoke_url}/capture" # Adjust with your actual path and variables
  })
  filename = "../script.js"
}