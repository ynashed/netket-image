# Use an official python runtime as a parent image
FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu18.04

MAINTAINER Youssef Nashed "ynashed@slac.stanford.edu"

ENV PYTHONUNBUFFERED=1

ARG SCRATCH_VOLUME=/scratch
ENV SCRATCH_VOLUME=/scratch
RUN echo creating ${SCRATCH_VOLUME} && mkdir -p ${SCRATCH_VOLUME}
VOLUME ${SCRATCH_VOLUME}

WORKDIR /work
ADD . /work
ADD requirements.txt /work/requirements.txt

RUN apt-get update && \
    apt-get install -y git g++ python3.8-dev python3-pip

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 2
RUN ln -s /usr/bin/python3 /usr/bin/python & \
    ln -s /usr/bin/pip3 /usr/bin/pip

RUN pip install --upgrade pip
RUN pip install numpy six wheel
RUN git clone https://github.com/google/jax && cd jax && \
    python build/build.py --enable_cuda && pip install dist/*.whl && \
    cd .. && rm -rf jax

#RUN pip install jax[cuda11] -f https://storage.googleapis.com/jax-releases/jax_releases.html
RUN pip install -r requirements.txt
