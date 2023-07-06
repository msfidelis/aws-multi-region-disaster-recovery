resource "aws_api_gateway_rest_api" "main" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/sales" = {
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://sales-api.mycompany.internal.com/sales"
            connectionType       = "VPC_LINK",
            connectionId         = "${var.vpc_link}"
          }
        }
      }
      "/sales/{id}" = {
        get = {
          x-amazon-apigateway-any-method = {
            parameters = [
              {
                name : "id",
                in : "path",
                required : true,
                schema : {
                  type : "string"
                }
              }
            ],
          }
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://sales-api.mycompany.internal.com/sales/{id}"
            requestParameters = {
              "integration.request.path.id" = "method.request.path.id"
            },
            passthroughBehavior = "when_no_match",
            connectionType      = "VPC_LINK",
            connectionId        = "${var.vpc_link}",
          }
        }
      }
      "/healthcheck" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://sales-api.mycompany.internal.com/healthcheck"
            connectionType       = "VPC_LINK",
            connectionId         = "${var.vpc_link}"
          }
        }
      }
    }
  })

  name = var.gateway_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
