#!/bin/bash
echo "Control Plane IP: "
read CONTROL_PLANE_IP

DISK_NAME=$(talosctl get disks --insecure --nodes $CONTROL_PLANE_IP | fzf | awk '{print $3}' | sed)

echo "$DISK_NAME Selected"

echo "What is the cluster name?"
read CLUSTER_NAME

echo "Generating config for $CLUSTER_NAME using control plane https://$CONTROL_PLANE_IP:6443 installing on disk of /dev/$DISK_NAME"
talosctl gen config $CLUSTER_NAME https://$CONTROL_PLANE_IP:6443 --install-disk /dev/$DISK_NAME

sleep 5

echo "Applying config to control plane node"
talosctl apply-config --insecure --nodes $CONTROL_PLANE_IP --file controlplane.yaml

sleep 5

echo "Configuring control plane endpoints"
talosctl --talosconfig=./talosconfig config endpoints $CONTROL_PLANE_IP

sleep 5

echo "Bootstrapping cluster"
talosctl bootstrap --nodes $CONTROL_PLANE_IP --talosconfig=./talosconfig

sleep 5

echo "Outputting Kubernetes config alternative-kubeconfig"
talosctl kubeconfig alternative-kubeconfig --nodes $CONTROL_PLANE_IP --talosconfig=./talosconfig

sleep 5

echo "Checking health of the cluster"
talosctl --nodes $CONTROL_PLANE_IP --talosconfig=./talosconfig health

sleep 5

echo "Get nodes on cluster"
kubectl get nodes --kubeconfig=alternative-kubeconfig
