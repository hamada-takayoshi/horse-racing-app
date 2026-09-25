# RawFetch（取得イベント）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RawFetch` |
| 論理テーブル名 | 取得イベント |
| 概要 | 原本をいつ・どこから・どの取得元として取得したかを記録する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RawFetchId | 取得イベントID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RawContentId | 原本内容ID | BIGINT | NOT NULL |  | RawContent |  |
| 3 | DataSourceId | データ取得元ID | INT | NOT NULL |  | DataSource |  |
| 4 | DataTypeCode | 生データ種別コード | VARCHAR(30) | NOT NULL |  | DataType |  |
| 5 | SourceUrl | 取得URL | NVARCHAR(1000) | NULL |  |  |  |
| 6 | ExternalId | 取得元外部ID | NVARCHAR(200) | NULL |  |  |  |
| 7 | RetrievedAt | 取得日時 | DATETIME2 | NOT NULL |  |  |  |
| 8 | HttpStatusCode | HTTPステータス | SMALLINT | NULL |  |  |  |
| 9 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 10 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RawFetch PRIMARY KEY (RawFetchId)
```

## 4. インデックス候補

```sql
CREATE INDEX IX_RawFetch_SourceTime ON RawFetch(DataSourceId, RetrievedAt);
```

## 5. 設計上の補足

- 同一内容を複数回取得してもRawContentは共通化し、RawFetchだけ追加する。
