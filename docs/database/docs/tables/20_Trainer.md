# Trainer（調教師）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `Trainer` |
| 論理テーブル名 | 調教師 |
| 概要 | 調教師の現在情報を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | TrainerId | 調教師ID | INT | NOT NULL | ○ |  |  |
| 2 | TrainerName | 調教師名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | CurrentAffiliation | 現在所属 | NVARCHAR(100) | NULL |  |  |  |
| 4 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 5 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_Trainer PRIMARY KEY (TrainerId)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 所属履歴テーブルは初期スコープ外。レース時点の所属はRaceEntryにスナップショット保存する。
