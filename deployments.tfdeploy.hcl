identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
}

deployment "west-coast-dev" {
  inputs = {
    prefix              = "west-coast-development"
    regions             = ["us-west-1"]
    role_arn            = local.role_arn
    identity_token      = identity_token.aws.jwt
  }
}

deployment "west2-coast-dev" {
  inputs = {
    prefix              = "west-coast-development"
    regions             = ["us-west-2"]
    role_arn            = local.role_arn
    identity_token      = identity_token.aws.jwt
  }
}

deployment "east-coast-dev" {
  inputs = {
    prefix              = "east-coast-dev"
    regions             = ["us-east-1"]
    role_arn            = local.role_arn
    identity_token      = identity_token.aws.jwt
  }
}

deployment "east2-coast-dev" {
  inputs = {
    prefix              = "east-coast-dev"
    regions             = ["us-east-2"]
    role_arn            = local.role_arn
    identity_token      = identity_token.aws.jwt
  }
}

deployment "east3-coast-dev" {
  inputs = {
    prefix              = "east-coast-dev"
    regions             = ["us-east-2"]
    role_arn            = local.role_arn
    identity_token      = identity_token.aws.jwt
  }
}

deployment "production" {
  inputs = {
    prefix              = "production"
    regions             = ["us-east-1", "us-west-1"]
    role_arn            = local.role_arn
    identity_token      = identity_token.aws.jwt
  }
}

deployment "disaster-recovery" {
  inputs = {
    prefix              = "disaster-recovery"
    regions             = ["us-east-1"]
    role_arn            = local.role_arn
    identity_token      = identity_token.aws.jwt
  }
}

#orchestrate "auto_approve" "safe_plans" {
#  # Ensure that no resources are being removed
#  check {
#    condition     = context.plan.changes.remove == 0
#    reason = "Plan has ${context.plan.changes.remove} resources to be destroyed."
#  }

#  # Ensure that the deployment is not production or disaster-recovery
#  check {
#    condition     = context.plan.deployment != deployment.production && context.plan.deployment != deployment.disaster-recovery
#    reason = "Production and Disaster Recovery plans are not eligible for auto_approve."
#  }
#}

