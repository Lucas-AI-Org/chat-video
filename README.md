# chat-video

Render scripted iMessage and WhatsApp conversations with Sones defaults, using Onkeiki's message-demo renderer.

Download and run it without an account, API key, repository checkout, Bun, Node, or Xcode.
Videos are synthetic. The tool does not send messages or perform payments.

## Install

Download the versioned installer and run it:

```sh
curl -fsSL https://github.com/Lucas-AI-Org/chat-video/releases/download/chat-video-v0.2.0/install.sh -o /tmp/chat-video-install.sh
sh /tmp/chat-video-install.sh
```

The installer detects your platform, verifies the archive, and installs the complete package.
It links `~/.local/bin/chat-video`. Add that directory to `PATH`.
Set `CHAT_VIDEO_INSTALL_DIR` and `CHAT_VIDEO_DATA_DIR` to choose other locations.

Chromium, ffmpeg, ffprobe, SF Pro, Apple emoji, and Linux browser libraries are included.
No Homebrew, setup downloads, GitHub account, or administrator package installation is needed.
Rendering works offline after installation.

## Direct downloads

Download your archive, extract the whole folder, and run `./chat-video`.
You can also run `sh ./install.sh` inside that folder.
Keep `runtime` beside the executable.

| Platform | Archive |
| --- | --- |
| Apple Silicon macOS | [darwin-arm64](https://github.com/Lucas-AI-Org/chat-video/releases/download/chat-video-v0.2.0/chat-video-0.2.0-darwin-arm64.tar.gz) |
| Linux x64 | [linux-x64](https://github.com/Lucas-AI-Org/chat-video/releases/download/chat-video-v0.2.0/chat-video-0.2.0-linux-x64.tar.gz) |
| Linux arm64 | [linux-arm64](https://github.com/Lucas-AI-Org/chat-video/releases/download/chat-video-v0.2.0/chat-video-0.2.0-linux-arm64.tar.gz) |

[Release and checksums](https://github.com/Lucas-AI-Org/chat-video/releases/tag/chat-video-v0.2.0)

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
The rendering implementation and visual assets originate from [Onkeiki's message demo](https://onkeiki.com/message-demo).
The binaries use React and the Bun runtime.

Version 0.2.0 targets Apple Silicon macOS, Linux x64, and Linux arm64.
Offline rendering checks passed on macOS and Debian Linux containers. Linux x64 checks used emulation.
Other Linux distributions remain unverified.
