#!/bin/bash
set -e

REPO_URL="https://github.com/moheladwy/OCR4Linux.git"
TMP_DIR="/tmp/OCR4Linux"
EXEC_NAME="ocr4linux"

echo "[+] Cloning OCR4Linux into /tmp..."
rm -rf "$TMP_DIR"
git clone "$REPO_URL" "$TMP_DIR"

cd "$TMP_DIR"

echo "[+] Replacing yay with paru in setup.sh..."
sed -i 's/\byay\b/paru/g' setup.sh

echo "[+] Making setup.sh executable..."
chmod +x setup.sh

echo "[+] Running setup.sh..."
./setup.sh

echo "[+] Moving OCR4Linux.sh to /usr/local/bin..."
sudo mv "$TMP_DIR/OCR4Linux.sh" /usr/local/bin/$EXEC_NAME
sudo chmod +x /usr/local/bin/$EXEC_NAME

echo "[+] Cleaning up temporary files..."
rm -rf "$TMP_DIR"

echo "[✓] OCR4Linux installed. You can run it with: $EXEC_NAME"
