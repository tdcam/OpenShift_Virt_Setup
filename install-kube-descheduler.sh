#!/bin/bash

set -e

NAMESPACE="openshift-kube-descheduler-operator"
DESCHEDULER_CR_FILE="/tmp/kube-descheduler-gold-standard.yaml"

echo "⏳ Waiting for Kube Descheduler Operator to install..."

# Wait until the descheduler-operator pod exists and is running
until oc get pods -n $NAMESPACE | grep descheduler-operator | grep Running; do
  echo "Waiting for descheduler-operator pod to be running..."
  sleep 5
done

echo "✅ Descheduler operator pod is running."

# Create the tuned Descheduler custom resource
echo "🛠 Creating tuned KubeDescheduler configuration..."

cat <<EOF > $DESCHEDULER_CR_FILE
apiVersion: operator.openshift.io/v1
kind: KubeDescheduler
metadata:
  name: cluster
  namespace: $NAMESPACE
spec:
  managementState: Managed
  mode: Predictive
  deschedulingIntervalSeconds: 900
  profiles:
    - AffinityAndTaints
    - TopologyAndDuplicates
    - LifecycleAndUtilization
  profileCustomizations:
    devEnableEvictionsInBackground: true
EOF

oc apply -f $DESCHEDULER_CR_FILE

echo "✅ KubeDescheduler CR applied."

# Wait for descheduler pod to be running
until oc get pods -n $NAMESPACE | grep descheduler | grep 1/1 | grep Running; do
  echo "Waiting for descheduler pod to be ready..."
  sleep 5
done

echo "✅ Descheduler pod is up and running!"

echo "🚀 Kube Descheduler is fully installed and configured!"

