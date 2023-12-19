identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "development" {
  variables = {
    prefix              = "hello-world-lambda-dev"
    regions             = ["us-east-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

deployment "production" {
  variables = {
    prefix              = "hello-world-lambda-prod"
    regions             = ["us-east-1", "us-west-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

orchestrate "auto_approve" "no_s3_changes" {
  check {
    condition = context.plan.component_changes["component.s3"].total == 0
    error_message = "Changes proposed to s3 component."
  }
}
