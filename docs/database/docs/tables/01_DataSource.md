# DataSource（データ取得元）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `DataSource` |
| 論理テーブル名 | データ取得元 |
| 概要 | データ提供元・取得元と、確定値採用時の優先順位を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | DataSourceId | データ取得元ID | INT | NOT NULL | ○ |  |  |
| 2 | SourceName | 取得元名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | SourceTypeCode | 取得方式コード | VARCHAR(20) | NOT NULL |  |  | WEB/API/FILE等。CHECK制約で管理 |
| 4 | Priority | 採用優先順位 | SMALLINT | NOT NULL |  |  | 数値が小さいほど優先 |
| 5 | AuthorityLevelCode | 権威レベルコード | VARCHAR(20) | NOT NULL |  |  | OFFICIAL/OFFICIAL_PROVIDER/PAID/EXTERNAL等 |
| 6 | BaseUrl | 基準URL | NVARCHAR(500) | NULL |  |  |  |
| 7 | IsPaid | 有料フラグ | BIT | NOT NULL |  |  |  |
| 8 | Description | 説明 | NVARCHAR(500) | NULL |  |  |  |
| 9 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 10 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_DataSource PRIMARY KEY (DataSourceId)
```

### 固定コード制約

```sql
CONSTRAINT CK_DataSource_SourceType CHECK (SourceTypeCode IN ('WEB','API','FILE'))
CONSTRAINT CK_DataSource_Authority CHECK (AuthorityLevelCode IN ('OFFICIAL','OFFICIAL_PROVIDER','PAID','EXTERNAL'))
```

## 4. インデックス候補

```sql
CREATE UNIQUE INDEX UX_DataSource_SourceName ON DataSource(SourceName);
```

## 5. 設計上の補足

- 確定値が複数ソースで食い違う場合、PriorityとAuthorityLevelCodeを使って採用元を決定する。
