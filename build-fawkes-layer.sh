#!/bin/bash
set -e

LAYER_NAME="fawkes-layer"
PYTHON_VERSION="3.10"
BUILD_DIR="python"
ZIP_FILE="${LAYER_NAME}.zip"
DOCKER_IMAGE="public.ecr.aws/lambda/python:${PYTHON_VERSION}"

# Clean previous builds
rm -rf ${BUILD_DIR} ${ZIP_FILE}

# Create Docker build environment
docker run --rm --entrypoint "" -v "$PWD":/var/task "${DOCKER_IMAGE}" /bin/bash -c "
  mkdir -p /var/task/${BUILD_DIR}
  pip install --upgrade pip
  pip install fawkes -t /var/task/${BUILD_DIR}
"

# Zip the layer
zip -r ${ZIP_FILE} ${BUILD_DIR}

echo "✅ Layer built: ${ZIP_FILE}"
