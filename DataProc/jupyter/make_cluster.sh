#!/bin/bash
gcloud dataproc clusters create jupyter-dataproc \
    --metadata "JUPYTER_PORT=8124,JUPYTER_CONDA_PACKAGES=numpy:pandas:scikit-learn:matplotlib:ggplot:plotly:bokeh" \
    --initialization-actions \
        gs://dataproc-initialization-actions/jupyter/jupyter.sh \
    --num-workers 2 \
    --worker-boot-disk-size 100 \
    --master-boot-disk-size 100 \
    --properties spark:spark.executorEnv.PYTHONHASHSEED=0,spark:spark.yarn.am.memory=1024m \
    --num-preemptible-workers 4 \
    --worker-machine-type=n1-standard-4 \
    --master-machine-type=n1-standard-4 \
    --zone us-central1-c \
    --project isb-cgc-04-0020
