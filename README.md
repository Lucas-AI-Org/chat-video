# chat-video

Render scripted iMessage and WhatsApp conversations with Sones defaults.

Download the portable packages from the public releases page.
No API key, repository checkout, Bun, Node, or Xcode is needed.
Videos are synthetic. The tool does not send messages or perform payments.

## Install

Run the installer for this release.

```sh
installer=$(mktemp)
curl -fsSL https://github.com/Lucas-AI-Org/chat-video/releases/download/chat-video-v0.2.2/install.sh -o "$installer" && sh "$installer"
rm -f "$installer"
```

The installer detects your platform, downloads the archive, checks its SHA-256 digest, and installs the complete package.
It links `~/.local/bin/chat-video`. Add that directory to `PATH`.
Set `CHAT_VIDEO_INSTALL_DIR` and `CHAT_VIDEO_DATA_DIR` to choose other locations.

Chromium, ffmpeg, ffprobe, SF Pro, Apple emoji, and Linux browser libraries are included.
No Homebrew, setup downloads, or administrator package installation is needed.
Rendering works offline after installation.

## Direct downloads

Download your archive, extract the whole folder, and run `./chat-video`.
You can also run `sh ./install.sh` inside that folder.
Keep `runtime` beside the executable.

```sh
gh release download chat-video-v0.2.2 --repo Lucas-AI-Org/chat-video --pattern 'chat-video-0.2.2-linux-x64.tar.gz' --pattern SHA256SUMS
```

Use `darwin-arm64`, `linux-x64`, or `linux-arm64` in the pattern.
[Release and checksums](https://github.com/Lucas-AI-Org/chat-video/releases/tag/chat-video-v0.2.2)

## Render a conversation

```sh
chat-video init --app imessage chat.json
chat-video check chat.json
chat-video still chat.json --out ./preview
chat-video render chat.json --out ./video
```

Use `--app whatsapp` when creating a WhatsApp script.
Edit the JSON before rendering:

```json
{
  "channel": "imessage",
  "contact": { "name": "Sones" },
  "time": "18:12",
  "hold": 2500,
  "messages": [
    { "from": "me", "text": "dinner for two tonight?" },
    { "from": "agent", "text": "Found a table at 7:30.", "reaction": "heart" }
  ]
}
```

`me` draws on the right; `agent` draws on the left.
The source uses 24-hour input to format the opening header. It adds that header automatically.
Use local file paths for images and avatars. Relative paths resolve against the script's directory.
Run `chat-video schema` for the complete input format and `chat-video --help` for commands.

Videos export at 60 fps with screen and framed MP4s, a poster, and review images.
Supported formats are `9:16`, `4:5`, `1:1`, and `16:9`.
Inspect the contact sheet and report before sharing a video.

SF Pro is bundled. Use `--fonts <directory>` to override it.

## About this repository

This repository distributes release binaries, the installer, and usage instructions.

Version 0.2.2 targets Apple Silicon macOS, Linux x64, and Linux arm64.
The renderer sizes capture workers and encoding threads to the available CPU and memory.
