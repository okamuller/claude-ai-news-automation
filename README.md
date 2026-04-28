# Claude AI News Automation

Raspberry Pi 上で Claude CLI を cron 実行し、AI ニュースの要約を Markdown として Obsidian Vault に保存するための最小構成です。

## Architecture

```text
Raspberry Pi
  -> cron
  -> Claude CLI
  -> Markdown files
  -> Obsidian Vault
  -> Syncthing / Git sync
  -> iPhone / Mac
```

## Requirements

- Raspberry Pi 4 or later
- Raspberry Pi OS / Debian-based Linux
- Node.js 20+
- Claude Code CLI
- Obsidian Vault directory

## Quick start

```bash
bash setup/install_node.sh
bash setup/install_claude.sh
cp .env.example .env
```

Edit `.env`:

```bash
OUTPUT_DIR=/home/pi/vault/AI_News
PROMPT_FILE=/home/pi/claude-ai-news-automation/prompts/ai_news_prompt.txt
```

Run manually:

```bash
bash scripts/run_ai_news.sh
```

## Cron

Install the daily cron entry:

```bash
crontab cron/crontab.example
```

Default schedule: every day at 07:00.

## Output

The generated note is saved as:

```text
$OUTPUT_DIR/YYYY-MM-DD.md
```

## Sync

Recommended options:

1. Syncthing: Raspberry Pi <-> iPhone / Mac
2. Git: Raspberry Pi pushes generated Markdown to a private repository

See:

- `docs/syncthing_setup.md`
- `docs/obsidian_setup.md`

## Notes

- This project does not use the Anthropic API directly.
- It assumes Claude CLI is already authenticated on the Raspberry Pi.
- Web search availability depends on the Claude CLI / plan behavior in your environment.
