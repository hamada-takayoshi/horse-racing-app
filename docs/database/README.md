# 競馬データベース設計資料 v3.1

過去10年程度の国内競馬データを収集・保存・分析し、将来的には出走前情報を利用したレース予想にも拡張できるようにするための論理データベース設計資料です。

## 1. この資料の目的

- 過去レースの公式確定情報を正規化して保存する。
- オッズ・人気などの時点依存データを取得元・取得時点ごとに保存する。
- 指数・評価値など提供元独自データを複数ソースで並存できるようにする。
- HTML / JSON / CSV 等の取得原本を保存し、再解析可能にする。
- 将来、地方競馬・有料データ・出走前予想へ拡張できる構造を維持する。

## 2. 正本

内容に差異がある場合は、以下を正本として扱います。

- テーブル・カラム・型・制約: `docs/tables/*.md`
- テーブル関連・カーディナリティ: `diagram/*.mmd`
- コード値・コード管理方針: `docs/03_code_definitions.md`
- Selection正規化規則: `docs/04_selection_rules.md`
- RawData保存方針: `docs/05_rawdata_policy.md`
- ビュー定義: `docs/sql/*.sql`

PNG / DOT / `image/design_package_overview.png` は閲覧用の派生資料です。

## 3. 現行設計の主要方針

### 3.1 確定値と提供元別データ

着順、馬体重、払戻、賞金、ラップ等の公式確定値は、データソース優先順位に基づいて正規値を1つ採用します。オッズ・人気・指数・評価値は時点や提供元によって値が異なること自体に意味があるため、`DataSourceId` ごとに並存可能です。

### 3.2 RaceEntry のライフサイクル

`RaceEntry` は登録段階から結果確定まで同じレコードを使用します。出走前状態は `EntryStatusCode`、レース結果状態は `ResultStatusCode` に分離します。枠番・馬番・騎手は未確定時にNULLを許容します。

### 3.3 オッズ・払戻

馬券種別は `BetType` マスタで管理し、馬券種別ごとの選択対象（馬番 / 枠番）は `BetType.SelectionTypeCode` で一元管理します。`RaceOdds` / `RacePayout` は `SelectionKey` とSelection明細を併用し、DB側の一意制約で重複を抑止します。最終オッズは `IsFinal=1` とフィルター付き一意インデックスで保証します。

### 3.4 RawData

取得原本は `RawContent`、取得イベントは `RawFetch` に分離します。原本はDB内バイナリ・外部ファイル・圧縮ファイルのいずれでも保存可能とし、`ContentHash` はデコード前の取得バイト列に対して計算します。

### 3.5 コード値

- 業務上追加・名称変更があり得るコード: コードマスタ + FK
- システム仕様として固定的なコード: CHECK制約
- 性別は `MALE` / `FEMALE` / `GELDING` の英数字コードを使用

### 3.6 リネージ

初期は `Race` / `RaceEntry` と `RawFetch` のリンクを保持します。取得原本は全件保存し、必要になった他テーブルについて後からリネージを追加できる設計とします。

## 4. 資料構成

```text
horse_racing_db_design_v3_1/
├─ README.md
├─ CHANGELOG.md
├─ docs/
│  ├─ 00_design_decisions.md
│  ├─ 01_database_overview.md
│  ├─ 02_er_diagram.md
│  ├─ 03_code_definitions.md
│  ├─ 04_selection_rules.md
│  ├─ 05_rawdata_policy.md
│  ├─ 99_validation_report.md
│  ├─ tables/            # テーブル定義
│  ├─ views/             # ビュー説明
│  └─ sql/               # ビューSQL定義
├─ diagram/
│  ├─ er_all.mmd / .dot / .png
│  ├─ er_race.mmd / .dot / .png
│  ├─ er_betting.mmd / .dot / .png
│  ├─ er_master.mmd / .dot / .png
│  └─ er_rawdata.mmd / .dot / .png
└─ image/
   └─ design_package_overview.png
```

## 5. 推奨参照順

1. `README.md`
2. `docs/00_design_decisions.md`
3. `docs/01_database_overview.md`
4. `docs/02_er_diagram.md`
5. 必要な `docs/tables/*.md`
6. `docs/03_code_definitions.md` / `docs/04_selection_rules.md` / `docs/05_rawdata_policy.md`

変更履歴は `CHANGELOG.md` に分離しており、現行仕様を理解するために過去版を読む必要はありません。
