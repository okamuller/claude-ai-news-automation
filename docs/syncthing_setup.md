# Syncthing セットアップ

## 目的
Raspberry Pi で生成した AI ニュース Markdown を、Mac / iPhone と自動同期します。

## 手順
1. Raspberry Pi に Syncthing をインストール。
2. Mac（必要なら iPhone クライアント）にも Syncthing を用意。
3. `OUTPUT_DIR`（例: `/home/pi/vault/AI_News`）を共有フォルダとして追加。
4. 受信側で Obsidian Vault 内の同期先フォルダを指定。
5. 同期完了後、Obsidian でノートが自動反映されることを確認。

## 推奨
- 同期専用フォルダを作り、Vault 側ではそのフォルダを参照。
- 競合を避けるため、同じファイルを複数端末で同時編集しない。
