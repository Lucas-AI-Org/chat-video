#!/bin/sh
set -eu
version=0.2.1
repo=Lucas-AI-Org/chat-video
case "$(uname -s)-$(uname -m)" in
  Darwin-arm64) platform=darwin-arm64 ;;
  Linux-x86_64) platform=linux-x64 ;;
  Linux-aarch64|Linux-arm64) platform=linux-arm64 ;;
  *) echo "Supported platforms: Apple Silicon macOS, Linux x64, Linux arm64." >&2; exit 1 ;;
esac
if ! command -v gh >/dev/null 2>&1; then
  echo "The repository is private. Install the GitHub CLI and run gh auth login first." >&2
  exit 1
fi
asset="chat-video-${version}-${platform}.tar.gz"
download_dir=$(mktemp -d)
trap 'rm -rf "$download_dir"' EXIT
trap 'exit 1' HUP INT TERM
gh release download "chat-video-v${version}" --repo "$repo" --pattern "$asset" --pattern SHA256SUMS --dir "$download_dir"
(
  cd "$download_dir"
  awk -v asset="$asset" '$2 == asset { print; found=1 } END { if (!found) exit 1 }' SHA256SUMS > selected.sha256
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum -c selected.sha256
  else
    shasum -a 256 -c selected.sha256
  fi
)
tar -xzf "$download_dir/$asset" -C "$download_dir"
sh "$download_dir/chat-video-${version}-${platform}/install.sh"
