# MetricType（指数種別）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `MetricType` |
| 論理テーブル名 | 指数種別 |
| 概要 | 指数種別のコード値を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | MetricTypeCode | 指数種別コード | VARCHAR(30) | NOT NULL | ○ |  |  |
| 2 | MetricTypeName | 指数種別名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | SortOrder | 表示順 | SMALLINT | NOT NULL |  |  |  |
| 4 | IsActive | 有効フラグ | BIT | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_MetricType PRIMARY KEY (MetricTypeCode)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 特記事項なし。
