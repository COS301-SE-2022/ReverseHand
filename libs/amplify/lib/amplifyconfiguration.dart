const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "reversehandapi": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://olype7mopba2talc333b7k46jy.appsync-api.eu-west-1.amazonaws.com/graphql",
                    "region": "eu-west-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "DynamoDBObjectMapper": {
                    "Default": {
                        "Region": "eu-west-1"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "reversehandbucket100406-staging",
                        "Region": "eu-west-1"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-west-1:7ea0bd4f-75ce-4ba6-9a44-010030401fa6",
                            "Region": "eu-west-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-west-1_QpsSD87RL",
                        "AppClientId": "5sjgir76gfiuar2iu2t6v4ml5a",
                        "Region": "eu-west-1"
                    }
                },
                "GoogleSignIn": {
                    "Permissions": "email,profile,openid",
                    "ClientId-WebApp": "70583037389-7mu5170jddsv3q019u34v882pn2n51mb.apps.googleusercontent.com"
                },
                "FacebookSignIn": {
                    "AppId": "1269894613781517",
                    "Permissions": "public_profile"
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OPTIONAL",
                        "mfaTypes": [
                            "TOTP"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://olype7mopba2talc333b7k46jy.appsync-api.eu-west-1.amazonaws.com/graphql",
                        "Region": "eu-west-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "reversehandapi_AMAZON_COGNITO_USER_POOLS"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsDynamoDbStoragePlugin": {
                "name": "User",
                "region": "eu-west-1",
                "arn": "arn:aws:dynamodb:eu-west-1:727515863527:table/User",
                "partitionKeyName": "user_id",
                "partitionKeyType": "S"
            },
            "awsS3StoragePlugin": {
                "bucket": "reversehandbucket100406-staging",
                "region": "eu-west-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';