#!/bin/bash

ENDPOINT=$1
PIPELINE_ID=$2
RUN_ID="Sample"
VERSION_ID=$1
EXPERIMENT_NAME="Default"

kfp --endpoint "$ENDPOINT" run submit \
-e $EXPERIMENT_NAME \
-r "$RUN_ID" \
-p "$PIPELINE_ID" \
-v "$VERSION_ID"