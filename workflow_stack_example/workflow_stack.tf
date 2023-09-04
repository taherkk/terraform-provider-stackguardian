terraform {
  required_providers {
    restapi = {
      source = "hashicorp.com/edu/restapi"
    }
  }
}

provider "restapi" {
  uri                  = "https://api.app.stackguardian.io/api/v1/orgs/fanda/"
  debug                = true
  write_returns_object = true
  headers = {
    "Authorization" = "apikey sgu_g5aHlvuHQvaarykFYHRG5"
  }
  id_attribute = "ResourceName"
}

resource "restapi_workflow_stack" "TestStack" {
  path         = "/wfgrps/Firstworkflow/stacks/example/wfs/"
  destroy_path = "/wfgrps/Firstworkflow/stacks/example/wfs/TestStack"
  data = jsonencode(
    {
      "ResourceName" : "TestStack",
      "wfgrpName" : "StackworkflowExample",
      "Description" : "test to send to Firas",
      "Tags" : [],
      "EnvironmentVariables" : [],
      "DeploymentPlatformConfig" : [{
        "kind" : "AZURE_STATIC",
        "config" : {
          "integrationId" : "/integrations/azure",
          "profileName" : "azure"
        }
      }],
      "RunnerConstraints" : {
        "type" : "shared"
      },
      "VCSConfig" : {
        "iacVCSConfig" : {
          "useMarketplaceTemplate" : true,
          "iacTemplate" : "/stackguardian/aws-s3-demo-website",
          "iacTemplateId" : "/stackguardian/aws-s3-demo-website:11"
        },
        "iacInputData" : {
          "schemaType" : "FORM_JSONSCHEMA",
          "data" : {
            "shop_name" : "StackGuardian",
            "bucket_region" : "eu-central-1",
            "s3_bucket_acl" : "public-read",
            "s3_bucket_force_destroy" : true,
            "s3_bucket_block_public_acls" : false,
            "s3_bucket_block_public_policy" : false,
            "s3_bucket_ignore_public_acls" : false,
            "s3_bucket_restrict_public_buckets" : false,
            "s3_bucket_tags" : {
              "Owner" : "stackguardian"
            },
            "s3_bucket_versioning" : {
              "enabled" : true,
              "mfa_delete" : false
            }
          }
        }
      },
      "MiniSteps" : {
        "wfChaining" : {
          "ERRORED" : [],
          "COMPLETED" : []
        },
        "notifications" : {
          "email" : {
            "ERRORED" : [],
            "COMPLETED" : [],
            "APPROVAL_REQUIRED" : [],
            "CANCELLED" : []
          }
        }
      },
      "Approvers" : [],
      "TerraformConfig" : {
        "managedTerraformState" : true,
        "terraformVersion" : "1.4.6"
      },
      "WfType" : "TERRAFORM",
      "GitHubComSync" : {
        "pull_request_opened" : {
          "createWfRun" : {
            "enabled" : false
          }
        }
      },
      "UserSchedules" : []
    }
  )
}

