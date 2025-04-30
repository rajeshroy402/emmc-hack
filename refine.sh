#!/bin/bash
set -euo pipefail

# Script: cleanup_jetson.sh
# Created by: Rajesh Roy <rajesh.roy@example.com>
# Maintainer: Rajesh Roy <rajesh.roy@example.com>
# Date: $(date)

# Echo user details
echo "🧹 Starting system cleanup..."
echo "Author: Rajesh Roy <rajeshroy402@gmail.com>"
echo "Script: cleanup_jetson.sh"
echo "Started at: $(date)"

echo "\n# 1. Remove multimedia applications"
echo "Removing multimedia apps…"
sudo apt-get remove --purge -y \
    totem \
    rhythmbox \
    cheese \
    shotwell

echo "\n# 2. Remove browser modules"
echo "Removing Chromium codecs and scopes…"
sudo apt-get remove --purge -y \
    chromium-codecs-ffmpeg-extra \
    unity-scope-chromiumbookmarks

echo "\n# 3. Remove calculator utilities"
echo "Removing calculator apps…"
sudo apt-get remove --purge -y \
    gnome-calculator \
    unity-scope-calculator \
    bc

echo "\n# 4. Remove office/documentation packages"
echo "Removing LibreOffice and docs…"
sudo apt-get remove --purge -y \
    libreoffice* \
    ubuntu-docs

echo "\n# 5. Remove casual games and extra GNOME utilities"
echo "Removing games and extra GNOME apps…"
sudo apt-get remove --purge -y \
    gnome-mines \
    gnome-sudoku \
    gnome-mahjongg \
    gnome-calendar \
    gnome-contacts \
    gnome-weather

echo "\n# 6. (Optional) Remove full desktop environment for headless use"
# echo "Removing full GNOME desktop (commented out by default)…"
# sudo apt-get remove --purge -y \
#     ubuntu-desktop \
#     gdm3 \
#     gnome-shell \
#     gnome-control-center \
#     gnome-software

echo "\n# 7. Cleanup unused dependencies & caches"
echo "Autoremoving unused dependencies…"
sudo apt-get autoremove --purge -y

echo "Cleaning package cache…"
sudo apt-get clean
sudo rm -rf /var/cache/apt/archives/*

echo "\n# 8. Vacuum old logs"
echo "Vacuuming systemd journal to 100M…"
sudo journalctl --vacuum-size=100M

echo "\n# 9. Remove CUDA/NVIDIA samples (if present)"
echo "Removing CUDA samples…"
sudo rm -rf /usr/local/cuda-*/samples

echo "\n# 10. Remove CUDA docs and Nsight tools"
echo "Removing CUDA 10.2 documentation directory…"
if [ -d "/usr/local/cuda-10.2/doc" ]; then
    cd /usr/local/cuda-10.2/ && sudo rm -rf doc
else
    echo "Directory /usr/local/cuda-10.2/doc not found, skipping..."
fi

echo "Removing Nsight Systems and related tools…"
sudo apt-get remove --purge -y nsight-systems-2024.2.2 nvidia-nsight-sys
sudo apt-get remove --purge -y 'nsight*'

echo "\n# 11. Additional cleanup after Nsight removal"
echo "Running autoremove and autoclean…"
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "\n✅ Cleanup complete!"
echo "Completed at: $(date)"
echo "You can check free space with: df -h"
