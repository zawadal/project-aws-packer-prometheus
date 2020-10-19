#!/bin/bash

wget https://github.com/prometheus/prometheus/releases/download/v2.22.0/prometheus-2.22.0.linux-amd64.tar.gz
tar xvfz prometheus-2.22.0.linux-amd64.tar.gz
cd prometheus-2.22.0.linux-amd64
cp ../prometheus.yml .