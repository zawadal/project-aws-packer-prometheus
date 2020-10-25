#!/bin/bash
cd prometheus-2.22.0.linux-amd64
echo "Launching user-data" >> userdata.log
sudo ./prometheus --config.file prometheus.yml&