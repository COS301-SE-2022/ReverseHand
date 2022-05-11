const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "reversehand": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://6urvo6roqza3rbvzhm2aj7dhy4.appsync-api.eu-west-1.amazonaws.com/graphql",
                    "region": "eu-west-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-sj7can3rffch7p7a6yw2t5ohve"
                }
            }
        }
    }
}''';