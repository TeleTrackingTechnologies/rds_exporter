#!/usr/bin/env bash

set -euo pipefail
IMAGE="teletracking/rds_exporter"
docker build -t "${IMAGE}:latest" .