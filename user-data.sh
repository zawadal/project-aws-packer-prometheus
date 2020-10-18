#!/bin/bash

wget https://github.com/prometheus/prometheus/releases/download/v2.22.0/prometheus-2.22.0.linux-amd64.tar.gz
tar xvfz prometheus-*.tar.gz
cd prometheus-*
cp ../prometheus.yml .
./prometheus --config.file=prometheus.yml