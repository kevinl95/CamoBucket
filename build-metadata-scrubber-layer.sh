#!/bin/bash
set -e

LAYER_NAME="metadata-scrubber-layer"
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
  pip install Pillow numpy -t /var/task/${BUILD_DIR} --no-cache-dir --no-compile
  
  # Remove unnecessary files to reduce size
  cd /var/task/${BUILD_DIR}
  find . -type d -name '__pycache__' -exec rm -rf {} + 2>/dev/null || true
  find . -name '*.pyc' -delete
  find . -name '*.pyo' -delete
  find . -name '*.dist-info' -exec rm -rf {} + 2>/dev/null || true
  find . -name '*.egg-info' -exec rm -rf {} + 2>/dev/null || true
  find . -name 'tests' -type d -exec rm -rf {} + 2>/dev/null || true
  find . -name 'test' -type d -exec rm -rf {} + 2>/dev/null || true
"

# Zip the layer with compression
zip -r9 ${ZIP_FILE} ${BUILD_DIR}

echo "✅ Layer built: ${ZIP_FILE}"
echo "📏 Size: $(du -h ${ZIP_FILE} | cut -f1)"