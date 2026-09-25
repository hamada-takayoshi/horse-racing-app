# TrackCondition（馬場状態）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `TrackCondition` |
| 論理テーブル名 | 馬場状態 |
| 概要 | 馬場状態のコード値を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | TrackConditionCode | 馬場状態コード | VARCHAR(30) | NOT NULL | ○ |  |  |
| 2 | TrackConditionName | 馬場状態名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | SortOrder | 表示順 | SMALLINT | NOT NULL |  |  |  |
| 4 | IsActive | 有効フラグ | BIT | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_TrackCondition PRIMARY KEY (TrackConditionCode)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 特記事項なし。
