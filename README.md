# kfp-test

### Requirements

- You need a running KubeFlow pipelines server to run this example.
- Make sure you get the endpoint that looks like this:

https://5a123b4cd567ef8g-dot-us-central1.pipelines.googleusercontent.com/

You can use this `ENDPOINT` for the next sections.

### Setup

1. Create a `python3` virtual environment

```
python3 -m venv env
source env/bin/activate
```

2. Install the Requirements

```
pip install -r requirements.txt
```

##### Uploading the pipeline

```
./upload-pipeline-fm.sh <ENDPOINT>
```

NOTE: This will recreate your pipeline if it exists.

##### Running the pipeline

1. Get the pipeline ID
    - This shows up after running `./upload-pipeline-fm.sh`
    - Or you can run `kfp --endpoint <ENDPOINT> pipeline list`

2. Run

```
./run-pipeline-fm.sh <ENDPOINT> <PIPELINE_ID>
```