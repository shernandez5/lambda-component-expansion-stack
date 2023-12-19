# lambda-component-expansion-stack

_This is an example stack configuration for the private preview of Terraform Stacks. Language
constructs and features are subject to change given feedback received during this preview. Do not
use Stacks for production workloads at this time._

![lambda-component-expansion-stack](https://github.com/hashicorp/lambda-component-expansion-stack/assets/2430490/4c4b9820-e84c-4966-bbe5-b86a7aff787b)

An example Terraform Stack that provisions an AWS S3 bucket, an AWS Lambda function served from that bucket,
and an AWS API Gateway to invoke that function at a URL, all across multiple AWS accounts with
varying regions which that account services.

This is the same system as in [hashicorp/lambda-multi-account-stack](https://github.com/hashicorp/lambda-multi-account-stack), but additionally demonstrates
a single deployment using component/provider configuration expansion with `for_each` to provision
modules in multiple AWS regions for a given environment.

Three components are used:

* `s3` uses a module to define the S3 bucket and necessary permissions for that bucket.
* `lambda` uses a module which contains a Ruby class, packaged and uploaded to the bucket defined by
  the `s3` component, and creates an AWS Lambda function with it.
* `api-gateway` uses a module which exposes an HTTP endpoint to invoke the function defined by the
  `lambda` component.

## Usage

_Prerequisites: You must have a Terraform Cloud account with access to the private preview of
Terraform Stacks, a GitHub account, and an AWS account with Terraform Cloud configured as an OIDC
identity provider. Details of all of this are found in the provided Stacks User Guide._

1. **Configure AWS authentication** by creating new IAM roles in the AWS web console (or with
   Terraform itself!) with proper permissions (S3, Lambda, and API Gateway) and a trust policies to
   allow the roles to be assumed by Terraform Cloud (the OIDC identity provider). More details on this
   step can be found in the Stacks User Guide.
2. **Fork this repository** to your own GitHub account, such that you can edit this stack configuration
   for your purposes.
3. **Edit your forked stack configuration** and change `deployments.tfdeploy.hcl` to use the ARNs of the
   IAM roles you created, as well as an audience value(s) for OpenID Connect.
4. **Create a new stack** in Terraform Cloud and connect it to your forked configuration repository.
5. **Provision away!** Once applied, look at the `invoke_url` attribute for the
   `aws_apigatewayv2_stage.lambda` resource in the API Gateway component for a given deployment; add `/hello?name=<Name>` to
   get a warm greeting! (e.g. `https://wbshl7x6wb.execute-api.us-east-1.amazonaws.com/serverless_lambda_stage/hello?name=Chris`)
