#!/usr/bin/env bash
set -euo pipefail

# **Author: Rajesh Roy**
# **Email: rajeshroy402@gmail.com**

# Echo author info
echo -e "\e[1mAuthor: Rajesh Roy\e[0m"
echo -e "\e[1mEmail: rajeshroy402@gmail.com\e[0m"

# Define the target directory
TARGET_DIR="/opt/nvidia/deepstream/deepstream"

# Verify it exists
if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Error: Directory '$TARGET_DIR' not found."
  exit 1
fi

# Change into the deepstream directory
cd "$TARGET_DIR"

# Remove unneeded directories
echo "Removing directories: samples/ doc/"
rm -rf samples/ doc/

# Remove unneeded files
echo "Removing files: install.sh uninstall.sh LICENSE.txt README"
rm -f install.sh uninstall.sh LICENSE.txt README

echo "Cleanup complete."
