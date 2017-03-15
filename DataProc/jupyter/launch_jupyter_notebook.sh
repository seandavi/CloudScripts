#!/usr/bin/env bash
# to be run locally

set -e

DATAPROC_CLUSTER_NAME=juypter-dataproc
JUPYTER_PORT=8124

# 0. Set default path to Chrome application (by operating system type).
# OS X
CHROME_APP_PATH="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
# Linux
#CHROME_APP_PATH="/usr/bin/google-chrome"
# Windows
#CHROME_APP_PATH="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

# Following configuration at:
# https://cloud.google.com/dataproc/cluster-web-interfaces
# 1. Setup ssh tunnel and socks proxy
ZONE_FLAG=""
[[ -v ZONE ]] && ZONE_FLAG="--zone=$ZONE"
gcloud compute ssh --zone=us-central1-c --ssh-flag="-D 10000" --ssh-flag="-N" --ssh-flag="-n" "jupyter-dataproc-m" &
sleep 5 # Wait for tunnel to be ready before opening browser...

# 2.Launch Chrome instance, referencing the proxy server.
# TODO: Parameterize the chrome app path
# eval $CHROME_APP_PATH \
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
    "http://$DATAPROC_CLUSTER_NAME-m:$JUPYTER_PORT" \
    --proxy-server="socks5://localhost:10000" \
    --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost" \
    --user-data-dir=/tmp/
