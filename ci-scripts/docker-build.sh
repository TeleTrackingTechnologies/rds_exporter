#!/usr/bin/env bash

set -euo pipefail
IMAGE="teletracking/rds_exporter"
VERSION=$(semversioner current-version)

docker build -t "${IMAGE}:${VERSION}" .
