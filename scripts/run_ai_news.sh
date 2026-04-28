#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -f "$PROJECT_ROOT/.env" ]; then
  # shellcheck disable=SC1091
  source "$PROJECT_ROOT/.env"
fi

DATE="$(date +%F)"
DEFAULT_OUTPUT_DIR="$HOME/vault/AI_News"
DEFAULT_PROMPT_FILE="$PROJECT_ROOT/prompts/ai_news_prompt.txt"

OUTPUT_DIR="${OUTPUT_DIR:-$DEFAULT_OUTPUT_DIR}"
PROMPT_FILE="${PROMPT_FILE:-$DEFAULT_PROMPT_FILE}"
CLAUDE_BIN="${CLAUDE_BIN:-$(command -v claude || true)}"

if [[ "$PROMPT_FILE" != /* ]]; then
  PROMPT_FILE="$PROJECT_ROOT/$PROMPT_FILE"
fi

if [[ "$OUTPUT_DIR" != /* ]]; then
  OUTPUT_DIR="$PROJECT_ROOT/$OUTPUT_DIR"
fi

if [ -z "$CLAUDE_BIN" ]; then
  echo "Error: claude command not found. Set CLAUDE_BIN in .env." >&2
  exit 1
fi

if [ ! -f "$PROMPT_FILE" ]; then
  echo "Error: prompt file not found: $PROMPT_FILE" >&2
  exit 1
fi

OUTPUT="$OUTPUT_DIR/$DATE.md"

mkdir -p "$OUTPUT_DIR"

if ! "$CLAUDE_BIN" -p "$(cat "$PROMPT_FILE")" > "$OUTPUT"; then
  {
    echo "# $DATE AI News"
    echo ""
    echo "Generation failed"
  } > "$OUTPUT"
  exit 1
fi

if [ ! -s "$OUTPUT" ]; then
  {
    echo "# $DATE AI News"
    echo ""
    echo "Generation failed: empty output"
  } > "$OUTPUT"
  exit 1
fi
