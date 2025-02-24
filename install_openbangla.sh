#!/bin/bash
set -e

# Change directory to /tmp
cd /tmp

# Remove any existing repository directory
echo "Removing any existing /tmp/OpenBangla-Keyboard directory..."
rm -rf OpenBangla-Keyboard

# Clone the OpenBangla-Keyboard repository
echo "Cloning OpenBangla-Keyboard repository..."
git clone https://github.com/OpenBangla/OpenBangla-Keyboard.git

# Change directory to the cloned repository
cd OpenBangla-Keyboard

# Checkout the develop branch and update submodules
echo "Checking out the develop branch..."
git checkout develop
echo "Updating submodules..."
git submodule update --init --recursive

# Create a build directory and configure the project with Fcitx5 support
echo "Creating build directory..."
mkdir -p build
cd build
echo "Configuring the project with Fcitx5 support..."
cmake .. -DENABLE_FCITX=On -DCMAKE_INSTALL_PREFIX=/usr

# Build the project using all available CPU cores
echo "Building the project..."
make -j12

# Install the project (requires sudo)
echo "Installing the project..."
sudo make install

# Set up OpenBangla configuration for Fcitx5
CONFIG_DIR="$HOME/.config/OpenBangla"
CONFIG_FILE="$CONFIG_DIR/Keyboard.conf"

echo "Configuring OpenBangla Keyboard..."
mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_FILE" <<'EOF'
[layout]
name=Avro Phonetic
path=avro_phonetic

[window]
positions\LayoutViewer=@Point(0 0)
positions\TopBar=@Point(703 419)
visibility\TopBar=true
EOF

echo "Installation and configuration complete!"
