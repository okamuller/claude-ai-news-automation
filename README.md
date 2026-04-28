# Claude AI News Automation

Raspberry Pi 4 上で Claude Code CLI を cron 実行し、AIプログラミング関連ニュースを Markdown として生成します。生成結果は GitHub に push し、LINE Messaging API で通知します。

## Architecture

```text
Raspberry Pi 4
  -> cron
  -> Claude Code CLI
  -> Markdown file
  -> GitHub push
  -> LINE Messaging API push message
  -> iPhone
```

## Requirements

- Raspberry Pi 4 or later
- Raspberry Pi OS / Debian-based Linux
- Node.js 20+
- Claude Code CLI
- GitHub repository for generated news logs
- LINE Messaging API channel access token
- LINE user ID, group ID, or room ID as the destination

## Quick start

```bash
bash setup/install_node.sh
bash setup/install_claude.sh
cp .env.example .env
```

Edit `.env`:

```bash
CLAUDE_BIN=/usr/local/bin/claude
PROMPT_FILE=prompts/ai_news_prompt.txt
OUTPUT_DIR=/home/ryuta/ai-news-log/AI_News
GIT_REPO_DIR=/home/ryuta/ai-news-log
GITHUB_NEWS_BASE_URL=https://github.com/okamuller/ai-news-log/blob/main/AI_News
LINE_CHANNEL_ACCESS_TOKEN=your_channel_access_token
LINE_TO_ID=Uxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Run manually:

```bash
bash scripts/run_ai_news.sh
```

## GitHub log repository

Create or choose a GitHub repository to store generated Markdown files.

Example local setup on Raspberry Pi:

```bash
git clone git@github.com:okamuller/ai-news-log.git /home/ryuta/ai-news-log
mkdir -p /home/ryuta/ai-news-log/AI_News
```

`OUTPUT_DIR` should point to a directory inside this Git repository.

## LINE Messaging API setup

This project uses LINE Messaging API Push Message, not LINE Notify.

1. Create a provider in LINE Developers.
2. Create a Messaging API channel.
3. Issue a channel access token.
4. Add the bot as a friend or invite it to a group.
5. Get the destination ID: `userId`, `groupId`, or `roomId`.
6. Set `LINE_CHANNEL_ACCESS_TOKEN` and `LINE_TO_ID` in `.env`.

Test push message:

```bash
curl -X POST https://api.line.me/v2/bot/message/push \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $LINE_CHANNEL_ACCESS_TOKEN" \
  -d '{
    "to": "'"$LINE_TO_ID"'",
    "messages": [
      {
        "type": "text",
        "text": "AI news notification test"
      }
    ]
  }'
```

## .env / Path management

- `.env` がリポジトリルートに存在する場合、自動で読み込みます。
- `OUTPUT_DIR`, `PROMPT_FILE`, `GIT_REPO_DIR` は絶対パスまたはリポジトリルートからの相対パスを指定できます。
- `.env` は shell script として読み込まれます。信頼できない `.env` は使用しないでください。

Defaults:

- `OUTPUT_DIR=$HOME/ai-news-log/AI_News`
- `PROMPT_FILE=prompts/ai_news_prompt.txt`
- `GIT_REPO_DIR` is inferred from `OUTPUT_DIR` by searching upward for `.git`.

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

Then it is committed and pushed to GitHub.

The LINE message contains:

- Date
- First lines of the generated digest
- GitHub URL of the generated Markdown file, if `GITHUB_NEWS_BASE_URL` is set

## Notes

- This project does not use the Anthropic API directly.
- It assumes Claude Code CLI is already authenticated on the Raspberry Pi.
- Non-interactive execution uses `claude -p`.
- Web search availability and permissions depend on your Claude Code environment.
