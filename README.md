# CamoBucket
[![Lint CloudFormation Template](https://github.com/kevinl95/CamoBucket/actions/workflows/main.yml/badge.svg)](https://github.com/kevinl95/CamoBucket/actions/workflows/main.yml)

## Quick Deploy

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=CamoBucket&templateURL=https://your-public-bucket.s3.amazonaws.com/cloudformation.yml)

## Manual Deployment Steps

1. **Upload the CloudFormation template** to your public S3 bucket
2. **Create and upload the Pillow layer**:
   ```bash
   mkdir python
   pip install Pillow numpy -t python/
   zip -r pillow-numpy-layer.zip python/
   aws s3 cp pillow-numpy-layer.zip s3://your-public-layer-bucket/
   ```
3. **Deploy via AWS Console** or CLI:
   ```bash
   aws cloudformation create-stack \
     --stack-name CamoBucket \
     --template-url https://your-public-bucket.s3.amazonaws.com/cloudformation.yml \
     --parameters ParameterKey=BucketName,ParameterValue=my-camo-bucket \
                  ParameterKey=LayerBucketName,ParameterValue=your-public-layer-bucket \
     --capabilities CAPABILITY_IAM
   ```

## Usage

1. Upload images to the `input/` folder
2. Processed images appear in `output/` with adversarial noise added
3. The noise is designed to confuse facial recognition while remaining visually subtle

## Launch Stack URL Template

Replace `your-public-bucket` with your actual bucket name:
```
https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=CamoBucket&templateURL=https://your-public-bucket.s3.amazonaws.com/cloudformation.yml
```