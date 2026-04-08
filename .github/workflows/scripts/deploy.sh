#!/bin/bash

set -e

VERSION=$1

echo "Starting deployment for version: $VERSION"

# Build project (Gradle)
echo "Building project..."
chmod +x gradlew
./gradlew clean build -x test

# Docker build
echo "Building Docker image..."
docker build -t $ACR_LOGIN_SERVER/$IMAGE_NAME:$VERSION .

# Tag latest
docker tag $ACR_LOGIN_SERVER/$IMAGE_NAME:$VERSION $ACR_LOGIN_SERVER/$IMAGE_NAME:latest

# Push images
echo "Pushing images to ACR..."
docker push $ACR_LOGIN_SERVER/$IMAGE_NAME:$VERSION
docker push $ACR_LOGIN_SERVER/$IMAGE_NAME:latest

# Deploy to Azure
echo "Deploying to Azure App Service..."
az webapp config container set \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --docker-custom-image-name $ACR_LOGIN_SERVER/$IMAGE_NAME:$VERSION \
  --docker-registry-server-url https://$ACR_LOGIN_SERVER

echo "Deployment completed successfully!"