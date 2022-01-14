# Use an official pytorch runtime as a parent image
FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime

MAINTAINER Youssef Nashed "ynashed@slac.stanford.edu"

ENV PYTHONUNBUFFERED=1

ARG SCRATCH_VOLUME=/scratch
ENV SCRATCH_VOLUME=/scratch
RUN echo creating ${SCRATCH_VOLUME} && mkdir -p ${SCRATCH_VOLUME}
VOLUME ${SCRATCH_VOLUME}

WORKDIR /work
ADD requirements.txt /work/requirements.txt

RUN pip install --upgrade "jax[cuda]" -f https://storage.googleapis.com/jax-releases/jax_releases.html
RUN pip install -r requirements.txt

ADD . /work

