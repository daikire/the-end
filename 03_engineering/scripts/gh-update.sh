#!/bin/bash
# =============================================================
# gh-update.sh — the-end GitHub 一括更新スクリプト
# 使い方: bash ~/Library/Mobile\ Documents/com~apple~CloudDocs/the-end/03_engineering/scripts/gh-update.sh
# =============================================================

REPO_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/the-end"
TODAY=$(date "+%Y-%m-%d %H:%M")

echo "📁 リポジトリ: $REPO_DIR"
echo ""

cd "$REPO_DIR" || { echo "❌ フォルダが見つかりません: $REPO_DIR"; exit 1; }

# 変更確認
CHANGES=$(git status --porcelain)
if [ -z "$CHANGES" ]; then
  echo "✅ 変更なし。GitHubは最新の状態です。"
  git log --oneline -3
  exit 0
fi

echo "📝 変更ファイル:"
git status --short
echo ""

# ステージング
git add -A

# コミットメッセージ（引数があれば使用、なければ日時）
if [ -n "$1" ]; then
  MSG="$1"
else
  MSG="update: $TODAY"
fi

git commit -m "$MSG"
echo ""

# プッシュ
echo "🚀 GitHubにpush中..."
git push origin main

if [ $? -eq 0 ]; then
  echo ""
  echo "✅ GitHubへの更新完了！"
  echo "🔗 https://github.com/daikire/the-end"
else
  echo ""
  echo "❌ pushに失敗しました。GitHub Desktopで手動pushしてください。"
fi
