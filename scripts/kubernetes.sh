#!/bin/bash

set -e

USER_BIN_DIR=$HOME/.local/bin
KUBECTL_VERSION=v1.34.0

echo "Installing kubectl..."
curl -L -o /tmp/kubectl https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl

echo "Verifying the kubectl binary against the expected checksum..."
EXPECTED_KUBECTL_CHECKSUM=$(curl -L --no-progress-meter "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl.sha256")
echo "$EXPECTED_KUBECTL_CHECKSUM /tmp/kubectl" | sha256sum --check

echo "Moving the kubectl binary to the user bin directory..."
chmod u+x /tmp/kubectl
mv /tmp/kubectl $USER_BIN_DIR

echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 | HELM_INSTALL_DIR=$USER_BIN_DIR USE_SUDO="false" bash

# Unlike Helm, Radar doesn't support overriding the install directory in the script
# so we patch it on the fly before running it
echo "Installing Radar..."
curl -fsSL get.radarhq.io | sed 's|INSTALL_DIR="/usr/local/bin"|INSTALL_DIR="$HOME/.local/bin"|' | sh
