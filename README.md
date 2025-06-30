# CamoBucket
[![Lint CloudFormation Template](https://github.com/kevinl95/CamoBucket/actions/workflows/main.yml/badge.svg)](https://github.com/kevinl95/CamoBucket/actions/workflows/main.yml)

## Quick Deploy

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=CamoBucket&templateURL=https://camobucket.s3.amazonaws.com/cloudformation.yml)

## Manual Deployment Steps

1. **Deploy via AWS Console** or CLI:
   ```bash
   aws cloudformation create-stack \
     --stack-name CamoBucket \
     --template-url https://camobucket.s3.amazonaws.com/cloudformation.yml \
     --parameters ParameterKey=BucketName,ParameterValue=my-camo-bucket \
     --capabilities CAPABILITY_IAM
   ```

where the BucketName is the bucket where your input/output directories for your photos will go.

## How It Works

CamoBucket uses adversarial noise to protect privacy by confusing facial recognition systems while keeping images visually normal to humans.

### The Lambda Function
- **Triggers automatically** when images are uploaded to the `input/` folder
- **Adds targeted noise** using Gaussian perturbations focused on face-likely regions (upper 60% of image)
- **Preserves image quality** by using minimal noise intensity and high JPEG quality (95%)
- **Outputs cloaked images** to the `output/` folder with "cloaked_" prefix

### Adversarial Noise Technique
- **Gaussian noise** is added with higher intensity in the upper portion of images where faces typically appear
- **Imperceptible to humans** but causes neural networks to misclassify or fail to detect faces
- **Transferable across models** - noise that fools one facial recognition system often works on others
- **Lightweight approach** that doesn't require training or face detection, making it fast and scalable

## Usage

1. Upload images to the `input/` folder
2. Processed images appear in `output/` with adversarial noise added
3. The noise is designed to confuse facial recognition while remaining visually subtle

## Launch Stack URL Template

```
https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=CamoBucket&templateURL=https://camobucket.s3.amazonaws.com/cloudformation.yml
```