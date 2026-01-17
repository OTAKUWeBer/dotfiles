#!/bin/bash

MOUNT_POINT="/mnt/windows"
DEVICE="/dev/nvme0n1p5"

function mount_win() {
  sudo mkdir -p "$MOUNT_POINT"
  sudo mount -t ntfs-3g "$DEVICE" "$MOUNT_POINT"
  echo "Mounted: $DEVICE → $MOUNT_POINT"
}

function unmount_win() {
  sudo umount "$MOUNT_POINT" 2>/dev/null || sudo umount -l "$MOUNT_POINT"
  echo "Unmounted: $MOUNT_POINT"
}

case "$1" in
  mount)
    mount_win
    ;;
  umount|unmount)
    unmount_win
    ;;
  status)
    mount | grep "$DEVICE" >/dev/null && echo "Mounted" || echo "Not mounted"
    ;;
  *)
    echo "Usage: $0 {mount|unmount|status}"
    ;;
esac
