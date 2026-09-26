# horse-racing-app

競馬の過去レースデータを収集・保存・分析し、将来的には現時点の情報を使ったレース予想にも利用するためのアプリケーションです。

## 現在の開発方針

- まずローカルPCで動作する環境を構築する
- DBは SQL Server を使用する
- SQL Server はWindowsへ直接インストールせず、Dockerコンテナで実行する
- SQL Serverコンテナは Developer Edition を使用する
- DBデータはDocker named volumeに永続化する
- アプリケーションは専用DBユーザーで接続し、saは管理・初期化用途のみに使用する
- 将来的なAzure移行を考慮し、Azure SQL Databaseとの互換性を意識する
- DB設計の正本はMarkdownのテーブル定義とMermaidのER図とする
- Gitのcommitメッセージは日本語で記載する

## 現在の構成

```text
horse-racing-app/
├─ database/
│  ├─ ddl/
│  │  ├─ 001_create_database.sql
│  │  ├─ 005_create_app_user.sql
│  │  ├─ 010_create_tables.sql
│  │  ├─ 020_create_constraints.sql
│  │  ├─ 030_create_indexes.sql
│  │  ├─ 040_create_views.sql
│  │  └─ 900_verify_schema.sql
│  ├─ seed/
│  │  └─ 100_seed_master_data.sql
│  └─ scripts/
│     ├─ start-db.ps1
│     ├─ stop-db.ps1
│     ├─ initialize-db.ps1
│     ├─ verify-db.ps1
│     └─ reset-db.ps1
├─ docs/
│  └─ database/
│     ├─ README.md
│     ├─ CHANGELOG.md
│     ├─ docs/
│     ├─ diagram/
│     └─ image/
├─ docker/
│  └─ compose.yml
├─ .env.example
├─ .gitignore
└─ README.md
```

`src/`、`tests/` はアプリケーション方式を確定しながら追加します。

## ローカル開発環境

### 必要なもの

- Git
- Docker Desktop
- WSL2
- PowerShell 7 推奨

SQL Server本体をWindowsへ直接インストールする必要はありません。

## 初回セットアップ

Repositoryをcloneします。

```powershell
git clone https://github.com/hamada-takayoshi/horse-racing-app.git
cd horse-racing-app
```

環境変数ファイルを作成します。

```powershell
Copy-Item .env.example .env
```

`.env` を編集し、少なくとも以下のパスワードを強い値へ変更してください。

```text
MSSQL_SA_PASSWORD=...
MSSQL_APP_PASSWORD=...
```

`.env` はGit管理対象外です。

## SQL Server起動

```powershell
./database/scripts/start-db.ps1
```

Dockerコンテナ `horse-racing-sqlserver` が起動し、SQL Serverのデータはnamed volume `horse-racing-sql-data` に保存されます。

## DB初期化

```powershell
./database/scripts/initialize-db.ps1
```

現在の初期化処理は以下を実行します。

1. SQL Serverコンテナを起動
2. SQL Serverの起動完了を待機
3. `HorseRacing` DBを作成
4. アプリ用ログイン・DBユーザーを作成
5. スキーマDDLを実行
6. コードマスタ初期データを投入
7. 39テーブル、制約、Index、View、初期データを検証

初期データとして、競馬区分2件と馬券種別9件を投入します。設計資料に具体値がないコードマスタは空の状態で作成します。

## DB接続確認

```powershell
./database/scripts/verify-db.ps1
```

アプリ用ユーザーで `HorseRacing` DBへ接続し、スキーマと初期データを確認します。

## SQL Server停止

```powershell
./database/scripts/stop-db.ps1
```

コンテナを停止してもDBデータは削除されません。

## DB完全リセット

```powershell
./database/scripts/reset-db.ps1
```

この処理はコンテナとDBデータVolumeを削除します。誤実行防止のため、実行時に `RESET` の入力を要求します。

## 環境変数

| 変数 | 用途 |
|---|---|
| `MSSQL_SA_PASSWORD` | SQL Server管理者パスワード |
| `MSSQL_APP_PASSWORD` | アプリ用DBユーザーパスワード |
| `MSSQL_PORT` | ホスト側公開ポート。既定値1433 |
| `MSSQL_DATABASE` | DB名。既定値HorseRacing |
| `MSSQL_APP_LOGIN` | アプリ用ログイン名 |

## Git運用

commitメッセージは日本語で記載します。

例：

```text
SQL Server開発環境を追加
DB初期化スクリプトを追加
競馬DBテーブルDDLを追加
```

秘密情報を含む `.env` はcommitしません。

## 次の作業

次の段階では、アプリケーション本体を追加します。

1. アプリケーション方式・技術構成の決定
2. アプリケーションプロジェクト
3. レース・出走馬の登録と検索
4. 自動テスト
