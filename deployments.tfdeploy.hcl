identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "east-coast-dev" {
  inputs = {
    prefix              = "east-coast-dev"
    regions             = ["us-east-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

deployment "production" {
  inputs = {
    prefix              = "production"
    regions             = ["us-east-1", "us-west-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

deployment "disaster-recovery" {
  inputs = {
    prefix              = "disaster-recovery"
    regions             = ["us-east-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

orchestrate "auto_approve" "safe_plans" {
 # Ensure that no resources are being removed
 check {
   condition     = context.plan.changes.remove == 0
   error_message = "Plan has ${context.plan.changes.remove} resources to be destroyed."
 }

 # Ensure that the deployment is not production or disaster-recovery
 check {
    condition     = context.plan.deployment.name != "production" && context.plan.deployment.name != "disaster-recovery"
    error_message = "Production and Disaster Recovery plans are not eligible for auto_approve."
  }
}

