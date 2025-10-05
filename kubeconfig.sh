#!/bin/bash
CONTROL_PLANE_IP=$(cat controlplane.yaml| grep '# Endpoint is the canonical' | awk '{print $2}' | cut -c9- | rev | cut -c6- | rev)

echo "Outputting Kubernetes config alternative-kubeconfig"
talosctl kubeconfig alternative-kubeconfig --nodes $CONTROL_PLANE_IP --talosconfig=./talosconfig
