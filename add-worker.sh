#!/bin/bash
echo "Worker IP: "
read WORKER_IP

echo "Applying config to worker node: $WORKER_IP"
talosctl apply-config --insecure --nodes "$WORKER_IP" --file worker.yaml

echo "Added worker node"
