#!/bin/bash

#echo "Select Control Plane: "
#CONTROL_PLANE_IP=$(kubectl get nodes --kubeconfig=alternative-kubeconfig -o wide | sed 1d | fzf -q 'talos' | awk '{print $6}')
CONTROL_PLANE_IP=$(kubectl get nodes --kubeconfig=alternative-kubeconfig -o wide | sed 1d | grep 'control-plane' | awk '{print $6}')

echo "Select Node's Dashboard: "
NODE_IP=$(kubectl get nodes --kubeconfig=alternative-kubeconfig -o wide | sed 1d | fzf -q 'talos' | awk '{print $6}')

talosctl dashboard -e $CONTROL_PLANE_IP --talosconfig talosconfig -n $NODE_IP
