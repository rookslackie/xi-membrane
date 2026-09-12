#!/bin/bash
# Xi.Drive — Termux setup (served from the membrane). Safe to re-run.
pkg install -y rclone >/dev/null 2>&1 || pkg install -y rclone
rclone config create xidrive webdav url=https://drive.xi-field.com vendor=other user=hunter pass=6c6c788c51e82b7576f12d37 >/dev/null
echo "=== verifying connection ==="
if rclone lsf xidrive: 2>&1; then
  echo ""
  echo "drive connected. examples:"
  echo "  rclone copy ~/storage/shared/DCIM/photo.jpg xidrive:inbox"
  echo "  (run: termux-setup-storage  if ~/storage is empty)"
else
  echo ""
  echo "drive hostname not answering yet (tunnel ingress needs the box-side fix)."
  echo "the config is saved; once drive.xi-field.com is live, just re-run: rclone lsf xidrive:"
fi
