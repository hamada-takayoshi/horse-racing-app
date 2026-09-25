# horse-racing-app

競馬の過去レースデータを収集・保存・分析し、将来的にはレース予想にも利用するためのアプリケーションです。

## 現在の開発方針

- まずローカルPCで動作する開発環境を構築する
- DBは SQL Server を使用する
- SQL Server はWindowsへ直接インストールせず、Dockerコンテナで実行する
- DBデータはDocker named volumeに永続化する
- アプリケーションからは専用DBユーザーで接続し、saは管理・初期化用途のみに使用する
- 将来的なAzure移行を考慮し、Azure SQL Databaseとの互換性を意識する
- DB設計の正本はMarkdownのテーブル定義とMermaidのER図とする
- Gitのcommitメッセージは日本語で記載する

## ローカル開発環境

### 必要なもの

- Git
- Docker Desktop（WSL2 backend）
- PowerShell 7推奨
- .NET SDK（アプリケーション方式決定後にバージョンを固定）

SQL Server本体をWindowsへ直接インストールする必要はありません。

## Repository構成

```text
horse-racing-app/
├─ database/
│  ├─ ddl/                 # テーブル・制約・Index・View等のDDL
│  ├─ seed/                # コードマスタ等の初期データ
│  └─ scripts/             # DB起動・初期化・検証スクリプト
├─ docker/
│  └─ compose.yml          # SQL Serverローカル環境
├─ docs/                   # 設計資料
├─ src/                    # アプリケーション本体
├─ tests/                  # 自動テスト
├─ .env.example            # ローカル環境変数テンプレート
├─ .gitignore
└─ README.md
```

## 次の作業

Docker + SQL Server のローカル開発環境、DB初期化スクリプト、設計DDLを順次追加します。
