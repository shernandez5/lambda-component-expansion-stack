identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "east-coast-dev" {
  variables = {
    prefix              = "east-coast-dev"
    regions             = ["us-east-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

deployment "west-coast-dev" {
  variables = {
    prefix              = "west-coast-dev"
    regions             = ["us-west-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

deployment "production" {
  variables = {
    prefix              = "production"
    regions             = ["us-east-1", "us-west-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}

deployment "disaster-recovery" {
  variables = {
    prefix              = "disaster-recovery"
    regions             = ["us-east-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
}
