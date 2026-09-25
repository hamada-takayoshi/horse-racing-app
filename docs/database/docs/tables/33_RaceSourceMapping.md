# RaceSourceMapping（Race外部ID対応）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceSourceMapping` |
| 論理テーブル名 | Race外部ID対応 |
| 概要 | Raceの内部IDとデータソース固有IDの対応を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceId | RaceID | BIGINT | NOT NULL | ○ | Race |  |
| 2 | DataSourceId | データ取得元ID | INT | NOT NULL | ○ | DataSource |  |
| 3 | ExternalId | 外部ID | NVARCHAR(200) | NOT NULL |  |  |  |
| 4 | ExternalUrl | 外部URL | NVARCHAR(1000) | NULL |  |  |  |
| 5 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 6 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceSourceMapping PRIMARY KEY (RaceId, DataSourceId)
```

### 外部ID一意

```sql
CONSTRAINT UQ_RaceSourceMapping_External UNIQUE (DataSourceId, ExternalId)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 同一データソース内のExternalIdは原則不変と仮定。ID変更履歴は初期スコープ外。
