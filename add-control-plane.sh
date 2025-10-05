#!/bin/bash
echo "Control Plane IP: "
read CONTROL_PLANE_IP

echo "Applying config to control plane node"
talosctl apply-config --insecure --nodes $CONTROL_PLANE_IP --file controlplane.yaml

echo "Added control plane node"
