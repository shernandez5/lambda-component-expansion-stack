identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "west-coast-dev" {
  inputs = {
    prefix              = "west-coast-dev"
    regions             = ["us-west-1"]
    role_arn            = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token_file = identity_token.aws.jwt_filename
  }
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
