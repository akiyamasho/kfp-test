#!/usr/bin/env bash

SRC_FOLDER=src

if [ "$1" == "--rebuild" ]
  then
  	TAG_NAME=asia.gcr.io/smartcart-productionization/ape-affogato/output-train:staging
	docker build -t $TAG_NAME $SRC_FOLDER/output/s02_training --no-cache
	docker push $TAG_NAME
fi

OUTPUT_FILENAME=$SRC_FOLDER/output.tar.gz
dsl-compile --py $SRC_FOLDER/pipeline.py --output $OUTPUT_FILENAME

# Clear current and upload
ENDPOINT=$1
PIPELINE_NAME="Sho Dev Test"
PIPELINE_DESC="Test description"

# Delete pipeline if missing
PIPELINE_LIST="$(kfp --endpoint $ENDPOINT pipeline list)"
PIPELINE_ID=$(echo "$PIPELINE_LIST" | grep "$PIPELINE_NAME" | grep -o "[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*")

if [ -z "$PIPELINE_ID" ]
  then
	echo "$PIPELINE_NAME can be created from scratch."
  else
    echo "Deleting existing [$PIPELINE_NAME] with ID [$PIPELINE_ID] first..."
    kfp --endpoint $ENDPOINT \
		pipeline \
		delete "$PIPELINE_ID"
	echo "Deleted existing [$PIPELINE_NAME]"
fi

echo "Uploading pipeline..."
kfp --endpoint $ENDPOINT \
	pipeline \
	upload $OUTPUT_FILENAME \
	-p "$PIPELINE_NAME" \
	-d "$PIPELINE_DESC"
echo "Pipeline successfully uploaded"
