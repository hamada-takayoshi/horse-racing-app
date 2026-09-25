# RaceEntryEvaluation（出走馬評価）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceEntryEvaluation` |
| 論理テーブル名 | 出走馬評価 |
| 概要 | 分類・評価型の独自情報を提供元別・時点別に保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceEntryEvaluationId | 出走馬評価ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceEntryId | レース出走馬ID | BIGINT | NOT NULL |  | RaceEntry |  |
| 3 | EvaluationTypeCode | 評価種別コード | VARCHAR(30) | NOT NULL |  | EvaluationType |  |
| 4 | EvaluationValue | 評価値 | NVARCHAR(100) | NOT NULL |  |  |  |
| 5 | DataSourceId | 提供元ID | INT | NOT NULL |  | DataSource |  |
| 6 | EvaluatedAt | 評価日時 | DATETIME2 | NOT NULL |  |  |  |
| 7 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 8 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceEntryEvaluation PRIMARY KEY (RaceEntryEvaluationId)
```

### 一意制約

```sql
CONSTRAINT UQ_RaceEntryEvaluation UNIQUE (RaceEntryId, EvaluationTypeCode, DataSourceId, EvaluatedAt)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 脚質・調教評価・展開評価・適性評価・不利情報・予想印等を想定。
