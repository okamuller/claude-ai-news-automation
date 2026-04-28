#!/bin/bash

DATE=$(date +%F)
OUTPUT_DIR=${OUTPUT_DIR:-~/vault/AI_News}
PROMPT_FILE=${PROMPT_FILE:-./prompts/ai_news_prompt.txt}
OUTPUT="$OUTPUT_DIR/$DATE.md"

mkdir -p "$OUTPUT_DIR"

claude run "$PROMPT_FILE" > "$OUTPUT"

if [ ! -s "$OUTPUT" ]; then
  echo "# $DATE AI News" > "$OUTPUT"
  echo "Generation failed" >> "$OUTPUT"
fi
