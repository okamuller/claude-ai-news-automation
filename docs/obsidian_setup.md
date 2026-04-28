# Obsidian セットアップ

## 目的
生成された日次ニュースを Obsidian で読みやすく管理します。

## 手順
1. Obsidian で既存 Vault を開く（または新規作成）。
2. `OUTPUT_DIR` を Vault 配下に設定（例: `Vault/AI_News`）。
3. `.env` に以下を設定。

```bash
OUTPUT_DIR=/home/pi/vault/AI_News
PROMPT_FILE=prompts/ai_news_prompt.txt
```

4. `bash scripts/run_ai_news.sh` を実行し、`YYYY-MM-DD.md` が作成されることを確認。

## 運用Tips
- Daily Notes プラグインと併用すると一覧しやすい。
- タグや Frontmatter を追加したい場合は、`prompts/ai_news_prompt.txt` の出力形式を拡張。
