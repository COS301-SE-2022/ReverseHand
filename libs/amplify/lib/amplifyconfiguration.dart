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
                    "ClientId-WebApp": "70583037389-472jm80uv70h30he9c6inukiisbkciem.apps.googleusercontent.com"
                },
                "FacebookSignIn": {
                    "AppId": "459283716090620",
                    "Permissions": "public_profile"
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "reversehand2ce3b132-2ce3b132-staging.auth.eu-west-1.amazoncognito.com",
                            "AppClientId": "5sjgir76gfiuar2iu2t6v4ml5a",
                            "SignInRedirectURI": "reversehandapp://",
                            "SignOutRedirectURI": "reversehandapp://",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [
                            "FACEBOOK",
                            "GOOGLE"
                        ],
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
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "fe811469c6cb4fd6bbfa4886a0c4c906",
                        "Region": "eu-west-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "eu-west-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsDynamoDbStoragePlugin": {
                "name": "ArchivedReverseHand",
                "region": "eu-west-1",
                "arn": "arn:aws:dynamodb:eu-west-1:727515863527:table/ArchivedReverseHand",
                "partitionKeyName": "part_key",
                "partitionKeyType": "S",
                "sortKeyName": "sort_key",
                "sortKeyType": "S"
            },
            "awsS3StoragePlugin": {
                "bucket": "reversehandbucket100406-staging",
                "region": "eu-west-1",
                "defaultAccessLevel": "guest"
            }
        }
    },
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "fe811469c6cb4fd6bbfa4886a0c4c906",
                    "region": "eu-west-1"
                },
                "pinpointTargeting": {
                    "region": "eu-west-1"
                }
            }
        }
    }
}''';