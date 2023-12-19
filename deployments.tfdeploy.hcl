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

orchestrate "auto_approve" "safe_plans" {
  check {
    condition     = context.plan.changes.remove == 0
    error_message = "Plan has ${plan.changes.remove} resources to be destroyed."
  }

  check {
     condition     = context.plan.deployment.name != "production"
     error_message = "Production plans are not eligible for auto_approve."
   }
}
