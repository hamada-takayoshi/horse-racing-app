# horse-racing-app 引き継ぎ資料

最終更新日: 2026-09-27（JST）  
引き継ぎ先: GitHub Copilot  
Repository: https://github.com/hamada-takayoshi/horse-racing-app.git

## 1. このプロジェクトの目的

過去10年程度の国内競馬データを収集・保存・分析し、将来的には出走前情報を利用したレース予想へ拡張するためのアプリケーションを構築する。

現在は、ローカル開発用のSQL Server環境と競馬DB v3.1の物理スキーマまで完成している。アプリケーション本体は未着手で、次の工程はアプリ方式・技術構成の決定である。

## 2. 現在のGit状態

- ブランチ: `main`
- 最新コミット: `cf9eb6b 競馬DB v3.1の実テーブルを実装`
- `origin/main`へpush済み
- 最終確認時点でローカルとGitHubは同期済み
- 本ファイル追加前は未コミット変更なし

直近の主要コミット:

```text
cf9eb6b 競馬DB v3.1の実テーブルを実装
9cc2ebd 競馬DB設計資料を追加
2fc7bbd DB初期化SQLの変数処理を修正
52af895 PowerShellスクリプトをUTF-8 BOM付きに統一
4908b6b PowerShellスクリプトの文字コード問題を回避
```

## 3. 完了している工程

1. GitHub Repositoryの構築
2. WSL2とDocker Desktopの導入・動作確認
3. SQL Server 2025 Developerコンテナの構築
4. DB、アプリ専用ログイン、DBユーザーの自動作成
5. 競馬DB設計資料v3.1のRepository格納
6. 39テーブルの物理DDL実装
7. PK、FK、UNIQUE、CHECK制約の実装
8. 通常・一意・フィルター付きIndexの実装
9. 2つのViewの実装
10. 設計で具体値が定義されているコードマスタの初期投入
11. DB初期化の再実行対応
12. DBスキーマの自動検証
13. アプリ専用ユーザーによる接続・読書き検証

## 4. 現在のDB実装

検証済みのオブジェクト数:

| 種別 | 件数 |
|---|---:|
| テーブル | 39 |
| View | 2 |
| 主キー | 39 |
| 一意制約 | 19 |
| 外部キー | 52 |
| CHECK制約 | 14 |
| 設計資料で定義されたIndex | 9 |
| `RacingCategory`初期値 | 2 |
| `BetType`初期値 | 9 |

実装済みView:

- `dbo.FinalRaceOddsView`
- `dbo.HorseAnalysisView`

`HorseAnalysisView`は旧カラム名`Sex`ではなく、v3.1の正式な`SexCode`を参照するよう修正済み。

## 5. 初期データ

設計資料で具体値が定義されている以下の11件だけを投入している。

### RacingCategory

- `CENTRAL`: 中央競馬
- `LOCAL`: 地方競馬

### BetType

- `WIN`: 単勝
- `PLACE`: 複勝
- `BRACKET_QUINELLA`: 枠連
- `BRACKET_EXACTA`: 枠単
- `QUINELLA`: 馬連
- `WIDE`: ワイド
- `EXACTA`: 馬単
- `TRIO`: 三連複
- `TRIFECTA`: 三連単

以下のマスターはテーブルのみ作成済みで、具体的なコード値が設計資料にないため空のままにしている。根拠なく値を追加しないこと。

- `RaceGrade`
- `Weather`
- `TrackCondition`
- `RaceClass`
- `AgeCondition`
- `SexCondition`
- `WeightCondition`
- `MetricType`
- `EvaluationType`
- `Unit`
- `DataType`

## 6. 重要なファイル

### プロジェクト概要

- `README.md`
- `HANDOFF.md`（本ファイル）

### DB設計の正本

- `docs/database/README.md`
- `docs/database/docs/00_design_decisions.md`
- `docs/database/docs/tables/*.md`
- `docs/database/diagram/*.mmd`
- `docs/database/docs/03_code_definitions.md`
- `docs/database/docs/04_selection_rules.md`
- `docs/database/docs/05_rawdata_policy.md`
- `docs/database/docs/sql/*.sql`

資料間に差異がある場合の優先順位は`docs/database/README.md`を参照すること。PNGとDOTは閲覧用の派生資料であり、正本ではない。

### 実行用SQL

- `database/ddl/001_create_database.sql`
- `database/ddl/005_create_app_user.sql`
- `database/ddl/010_create_tables.sql`
- `database/ddl/020_create_constraints.sql`
- `database/ddl/030_create_indexes.sql`
- `database/ddl/040_create_views.sql`
- `database/seed/100_seed_master_data.sql`
- `database/ddl/900_verify_schema.sql`

### PowerShellスクリプト

- `database/scripts/start-db.ps1`
- `database/scripts/initialize-db.ps1`
- `database/scripts/verify-db.ps1`
- `database/scripts/stop-db.ps1`
- `database/scripts/reset-db.ps1`

すべてUTF-8 BOM付きで保存している。Windows PowerShellで日本語が文字化けしないよう、今後もPowerShellスクリプトはUTF-8 BOM付きに統一すること。

## 7. ローカル環境

前回検証時の構成:

- Windows
- WSL2
- Docker Desktop
- Docker Engine 29.8.0
- Docker Compose v5.5.1
- SQL Server 2025 Developer
- コンテナ名: `horse-racing-sqlserver`
- 接続先: `localhost:1433`
- DB名: `HorseRacing`
- アプリ用ログイン: `HorseRacingAppUser`
- DBデータVolume: `horse-racing-sql-data`

SQL ServerはWindowsへ直接インストールせず、Dockerコンテナで稼働させる。

## 8. 環境変数と秘密情報

初回のみ`.env.example`をコピーする。

```powershell
Copy-Item .env.example .env
```

`.env`の設定項目:

```text
MSSQL_SA_PASSWORD
MSSQL_APP_PASSWORD
MSSQL_PORT
MSSQL_DATABASE
MSSQL_APP_LOGIN
```

注意事項:

- `.env`はGit管理対象外
- パスワードをREADME、ログ、コミット、Issueへ記載しない
- アプリは`HorseRacingAppUser`で接続する
- `sa`はDB初期化・管理用途だけに使用する

## 9. 起動・初期化・検証手順

Repositoryルートから実行する。

### SQL Server起動

```powershell
./database/scripts/start-db.ps1
```

### DB初期化

```powershell
./database/scripts/initialize-db.ps1
```

この処理は以下を順番に実行する。

1. SQL Serverコンテナ起動
2. SQL Server起動待ち
3. DB作成
4. アプリ用ログイン・ユーザー作成
5. 39テーブル作成
6. 制約作成
7. Index作成
8. View作成
9. 初期データ投入
10. スキーマ検証

DDL、Index、View、初期データ投入は再実行可能。実際に連続実行して成功することを確認済み。

### アプリ用ユーザーによる検証

```powershell
./database/scripts/verify-db.ps1
```

接続、スキーマ、初期データ、読書き権限を確認する。書込み確認はトランザクション内で実行し、ロールバックするため検証データは残らない。

### SQL Server停止

```powershell
./database/scripts/stop-db.ps1
```

通常の停止ではDBデータVolumeは保持される。

### DB完全リセット

```powershell
./database/scripts/reset-db.ps1
```

この操作はコンテナとDBデータVolumeを削除する。実行時に`RESET`の入力を要求するが、既存データを失うため、必要性を確認してから実行すること。

## 10. 確定している設計方針

- ローカルで動作する環境を先に完成させる
- DBはSQL Serverを使用する
- 将来的なAzure移行を考慮する
- DB設計の正本はMarkdownテーブル定義とMermaid ER図
- 単一の数値サロゲート主キーは`IDENTITY(1,1)`
- `CreatedAt`、`UpdatedAt`の初期値は`SYSUTCDATETIME()`
- FKの削除・更新動作は個別指定がない限り`NO ACTION`
- 業務コードはコードマスタとFKで管理する
- 固定システムコードはCHECK制約で管理する
- 日本語、人名、馬名などは`NVARCHAR`/`NCHAR`
- 内部英数字コードは`VARCHAR`/`CHAR`
- 性別は`MALE`、`FEMALE`、`GELDING`
- 出走前状態とレース結果状態は別カラム
- オッズの選択対象種別は`BetType.SelectionTypeCode`で一元管理
- 最終オッズはフィルター付き一意Indexで重複を防止
- Raw原本と取得イベントを`RawContent`/`RawFetch`へ分離
- WIN5は初期スコープ外

## 11. 未着手の工程

1. アプリ方式・技術構成の決定
2. `src/`のアプリケーションプロジェクト作成
3. `tests/`の作成
4. レース、馬、出走馬の登録・編集・検索
5. 馬の過去出走履歴表示
6. 外部データ取得処理
7. RawData保存と正規化処理
8. 実データ取込試験
9. 分析機能・予想機能
10. Azure環境の設計・移行

## 12. 次に行う作業

次の工程は「アプリ方式・技術構成の決定」。以下の順序で進める。

### 12.1 MVPの確定

最初のアプリに含める候補:

- レースの登録・編集・一覧・詳細
- 馬の登録・編集・一覧・詳細
- レースへの出走馬登録・編集
- 馬の過去出走履歴表示

予想、外部データ取得、高度な分析は最初のMVPへ含めない。

### 12.2 利用形態の確定

以下をユーザーへ確認する。

- 自分だけが使うか、複数ユーザーか
- PCブラウザ中心か、スマートフォン対応も必要か
- オフライン動作が必要か
- 初期段階からログイン機能が必要か

現時点の提案は「単一ユーザー、ローカルPCのブラウザ、ログインなし」だが、未確定である。

### 12.3 アプリ形式の決定

比較対象:

- Webアプリ
- Windowsデスクトップアプリ
- APIのみ

将来Azureへ移す前提ではWebアプリを第一候補としているが、まだユーザー承認前。

### 12.4 システム構成の決定

比較対象:

- 画面・サーバー・DBアクセスを1プロジェクトにまとめる一体型
- フロントエンドとバックエンドAPIの分離型

初期は一体型を候補とし、外部データ取得処理を後から分離できる構成を推奨している。

### 12.5 技術スタックの比較

決める項目:

- バックエンド言語・Webフレームワーク
- 画面技術
- DBアクセスライブラリ
- テストフレームワーク
- ローカル起動方式
- Azure上の配置候補

評価基準:

- SQL Serverとの相性
- Azureへの移行しやすさ
- データ取得・HTML解析のしやすさ
- テストと保守のしやすさ
- 学習コスト

技術スタックはまだ決定していない。ユーザー確認なしに特定技術を既定路線として実装しないこと。

### 12.6 設計資料の作成

アプリ方式決定後、次を追加する予定。

```text
docs/application/
├─ README.md
├─ 00_mvp_scope.md
├─ 01_architecture.md
├─ 02_technology_stack.md
├─ 03_screen_list.md
├─ 04_use_cases.md
└─ 05_test_policy.md
```

## 13. アプリ実装時の推奨境界

アプリ本体は次の責務を分ける。

```text
画面・API
    ↓
ユースケース
    ↓
DBアクセス
    ↓
SQL Server
```

外部データ取得は画面処理へ直接混ぜず、後から独立した処理として追加する。

```text
外部データ取得
    ↓
RawData保存
    ↓
解析・正規化
    ↓
競馬DB
```

既存のSQL DDLをDBスキーマの正本として扱い、アプリ側の自動マイグレーションを採用する場合は、二重管理にならない運用方針を先に決めること。

## 14. 開発・Git運用ルール

- commitメッセージは日本語で記載する
- commit前に関連する検証を実行する
- pushはユーザー確認後に行う
- `.env`やパスワードをcommitしない
- 既存DBやDocker Volumeを削除する前にユーザーへ確認する
- 設計資料にない業務値を推測で追加しない
- READMEと主要設計資料は差分説明ではなく、現時点の正しい全体像を記載する
- 変更履歴は`CHANGELOG.md`へ分離する
- ユーザーの既存変更を無断で破棄しない

## 15. 既知の制約・注意事項

- アプリ本体の言語・フレームワークは未決定
- `src/`、`tests/`はまだ存在しない
- 実データ取込は未実施
- 具体値未定のコードマスタが11種類ある
- Azure構成は未設計
- 認証・認可方式は未決定
- ローカルDBは開発用であり、本番データを格納していない
- Docker Desktop停止中は各PowerShellスクリプトを実行できない
- `reset-db.ps1`はDBデータを削除するため注意する

## 16. 引き継ぎ後の推奨開始手順

1. `README.md`を読む
2. 本ファイルを読む
3. `docs/database/README.md`を読む
4. `docs/database/docs/00_design_decisions.md`を読む
5. `git status`で作業ツリーを確認する
6. Docker Desktopを起動する
7. `./database/scripts/verify-db.ps1`を実行する
8. ユーザーとMVP・利用形態を確定する
9. 技術候補を比較し、決定内容を`docs/application/`へ記録する
10. ユーザー承認後にアプリケーションの雛形を作成する
