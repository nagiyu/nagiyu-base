#!/bin/bash

# DynamoDB テーブル「Auth」を作成
awslocal dynamodb create-table \
  --table-name Auth \
  --attribute-definitions \
    AttributeName=UserId,AttributeType=S \
    AttributeName=GoogleUserId,AttributeType=S \
  --key-schema \
    AttributeName=UserId,KeyType=HASH \
  --global-secondary-indexes \
    '[
      {
        "IndexName": "GoogleUserId-index-20241215",
        "KeySchema": [
          { "AttributeName": "GoogleUserId", "KeyType": "HASH" }
        ],
        "Projection": {
          "ProjectionType": "INCLUDE",
          "NonKeyAttributes": ["UserId", "UserName"]
        }
      }
    ]' \
  --billing-mode PAY_PER_REQUEST \
  --table-class STANDARD \
  --sse-specification Enabled=true,SSEType=AES256
