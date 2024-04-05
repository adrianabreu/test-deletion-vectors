# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

USER root

RUN apt-get install -y curl

RUN curl -O https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz \
    && tar zxvf spark-3.5.1-bin-hadoop3.tgz \
    && rm -rf spark-3.5.1-bin-hadoop3.tgz 

RUN mv spark-3.5.1-bin-hadoop3/ /usr/local/ \
    && rm -rf /usr/local/spark \
    && rm -rf /usr/local/spark-3.5.0-bin-hadoop3 \
    && ln -s /usr/local/spark-3.5.1-bin-hadoop3 /usr/local/spark

# Spylon-kernel
RUN conda install --quiet --yes 'spylon-kernel=0.4*' && \
    conda clean --all -f -y && \
    python -m spylon_kernel install --sys-prefix && \
    rm -rf "/home/${NB_USER}/.local" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN curl https://repo1.maven.org/maven2/io/delta/delta-spark_2.12/3.1.0/delta-spark_2.12-3.1.0.jar --output /usr/local/spark/jars/delta-spark_2.12-3.1.0.jar \ 
    && curl https://repo1.maven.org/maven2/io/delta/delta-storage/3.1.0/delta-storage-3.1.0.jar --output /usr/local/spark/jars/delta-storage-3.1.0.jar
