# EvaluationType（評価種別）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `EvaluationType` |
| 論理テーブル名 | 評価種別 |
| 概要 | 評価種別のコード値を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | EvaluationTypeCode | 評価種別コード | VARCHAR(30) | NOT NULL | ○ |  |  |
| 2 | EvaluationTypeName | 評価種別名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | SortOrder | 表示順 | SMALLINT | NOT NULL |  |  |  |
| 4 | IsActive | 有効フラグ | BIT | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_EvaluationType PRIMARY KEY (EvaluationTypeCode)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 特記事項なし。
