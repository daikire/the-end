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

# 未コミットの変更確認
CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ]; then
  echo "📝 未コミットの変更ファイル:"
  git status --short
  echo ""

  git add -A

  if [ -n "$1" ]; then
    MSG="$1"
  else
    MSG="update: $TODAY"
  fi

  git commit -m "$MSG"
  echo ""
fi

# 未プッシュのコミット確認
UNPUSHED=$(git log origin/main..HEAD --oneline 2>/dev/null)
if [ -z "$UNPUSHED" ]; then
  echo "✅ 変更なし。GitHubは最新の状態です。"
  exit 0
fi

echo "🚀 未プッシュのコミットをGitHubに送信中..."
echo "$UNPUSHED"
echo ""

git push origin main

if [ $? -eq 0 ]; then
  echo ""
  echo "✅ GitHubへの更新完了！"
  echo "🔗 https://github.com/daikire/the-end"
else
  echo ""
  echo "❌ pushに失敗しました。GitHub Desktopで手動pushしてください。"
fi
