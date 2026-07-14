#!/bin/bash

# Stop the script if any command fails
set -e

echo "=> 1/4 Checking dependencies..."
if ! command -v fastfetch &> /dev/null; then
    echo "fastfetch not found. Installing via apt..."
    sudo apt update && sudo apt install -y fastfetch gcc make
else
    echo "Dependencies look good."
fi

echo "=> 2/4 Compiling myfetch-core..."
# Compiles the C code with optimization (-O3) and math libraries (-lm)
gcc -O3 myfetch-core.c -o myfetch-core -lm

echo "=> 3/4 Installing globally (requires sudo)..."
sudo cp myfetch-core /usr/local/bin/
sudo cp myfetch /usr/local/bin/
sudo chmod +x /usr/local/bin/myfetch
sudo chmod +x /usr/local/bin/myfetch-core

echo "=> 4/4 Setting up user config directories..."
mkdir -p ~/.config/myfetch

echo ""
echo "✅ Installation Complete! You can now run 'myfetch' from anywhere."
