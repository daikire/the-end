# Windows作業環境セットアップガイド

**作成日**: 2026-04-01
**対象**: WindowsでGitHub連携しながらthe-endを運用する手順

---

## 前提：Windowsで必要なもの

| ツール | 役割 | 入手先 |
|--------|------|--------|
| iCloud for Windows | the-endフォルダをWindowsに同期 | Microsoft Store |
| GitHub Desktop | push / pull をGUI操作 | desktop.github.com |
| Git for Windows | コマンドラインでgit操作する場合 | git-scm.com |

---

## 初回セットアップ手順

### ステップ1：iCloud for Windows をインストール

1. Microsoft Storeで「iCloud」を検索してインストール
2. AppleIDでサインイン
3. 「iCloud Drive」にチェックを入れて同期開始
4. エクスプローラーに「iCloud Drive」フォルダが現れたら完了
5. `iCloud Drive > the-end` フォルダが自動的に同期される

> ⚠️ 初回同期は数分〜数十分かかる場合があります

### ステップ2：GitHub Desktop をインストール

1. [desktop.github.com](https://desktop.github.com) からダウンロード
2. インストール後、GitHubアカウントでサインイン
3. 「Add Local Repository」→ `C:\Users\[ユーザー名]\iCloudDrive\the-end` を選択
4. 「Fetch origin」を押してリモートと同期確認

---

## 毎日の作業フロー（Windows）

### 作業開始時（必ず最初に）

```
GitHub Desktop を開く
→「Fetch origin」をクリック
→「Pull origin」が表示されたらクリック（最新を取得）
→ the-endフォルダで作業開始
```

### 作業終了時（必ず最後に）

```
GitHub Desktop を開く
→ 変更されたファイルが左側に表示されている
→ 左下の「Summary」欄に作業内容を一言入力
→「Commit to main」をクリック
→「Push origin」をクリック
```

---

## コマンドラインで操作したい場合（上級者向け）

Git for Windows インストール後、コマンドプロンプトまたはPowerShellで：

```bash
# iCloudのパス例（ユーザー名を自分のものに変更）
cd "C:\Users\Daiki\iCloudDrive\the-end"

# 最新を取得
git pull origin main

# 変更をコミット
git add -A
git commit -m "update: YYYY-MM-DD"

# GitHubへ送信
git push origin main
```

---

## トラブルシューティング

| 症状 | 原因 | 対処 |
|------|------|------|
| iCloud Driveが表示されない | iCloud for Windowsが未インストール | Microsoft Storeからインストール |
| Push originが押せない | 認証切れ | GitHub Desktopで再サインイン |
| ファイルが古い | Pullし忘れ | 作業前に必ずFetch→Pull |
| コンフリクトが起きた | Mac・Windowsで同じファイルを同時編集 | 片方での作業後にpushしてからもう片方で作業 |

---

## 注意事項

- **Mac作業後は必ずpushしてからWindowsで開く**（逆も同様）
- iCloudの自動同期はgit操作の代わりにはならない（git push は必須）
- 同じファイルをMac・Windowsで同時に開かない
