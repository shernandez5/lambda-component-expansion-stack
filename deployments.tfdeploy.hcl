identity_token "aws" {
  audience = ["aws.workload.identity"]
}


deployment "dev-west-coast" {
  variables = {
    prefix              = "hello-world-lambda-west-dev"
    regions             = ["us-west-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

