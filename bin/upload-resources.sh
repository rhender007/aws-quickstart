#!/usr/bin/env bash

set -o xtrace
set -o errexit
set -o nounset


# TODO(chuckha) if the bucket doesn't exist, create it. Also probably delete it at the end?

# The bucket must exist.
# Can create a bucket with something like:
# aws s3api create-bucket --bucket heptio-hello-world-idjfuiewhj --create-bucket-configuration LocationConstraint=us-west-2
S3_BUCKET="${S3_BUCKET:-quickstart-heptio-com}"

# Will error if the bucket doesn't exist or you don't have permission to it.
aws s3api head-bucket --bucket "${S3_BUCKET}"

# Where "path/to/your/files" is the directory in S3 under which the templates and scripts directories will be placed
S3_PREFIX="${S3_PREFIX:-test-local/}"

# Copy the files from your local directory into your S3 bucket
aws s3 sync --acl=public-read ./templates "s3://${S3_BUCKET}/${S3_PREFIX}templates/"
aws s3 sync --acl=public-read ./scripts "s3://${S3_BUCKET}/${S3_PREFIX}scripts/"
