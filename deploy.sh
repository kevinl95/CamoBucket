#!/bin/bash
set -e

# Build the layer
./build-metadata-scrubber-layer.sh

# Package Lambda function
zip lambda-function.zip lambda_function.py

echo "✅ Ready to deploy!"
echo "📦 Layer: metadata-scrubber-layer.zip"
echo "📦 Function: lambda-function.zip"
echo ""
echo "Next steps:"
echo "1. Upload layer to AWS Lambda"
echo "2. Create Lambda function with the layer"
echo "3. Add S3 trigger for image uploads"