#!/bin/bash
# Xi.Drive — Termux one-liner setup (served from the membrane)
set -e
pkg install -y rclone
rclone config create xidrive webdav url=https://drive.xi-field.com vendor=other user=hunter pass=6c6c788c51e82b7576f12d37
echo ""
echo "=== verifying connection ==="
rclone lsf xidrive:
echo ""
echo "drive connected. try:"
echo "  rclone copy ~/storage/shared/DCIM/whatever.jpg xidrive:inbox"
echo "(termux-setup-storage first if ~/storage is empty)"
