# Jockey（騎手）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `Jockey` |
| 論理テーブル名 | 騎手 |
| 概要 | 騎手の現在情報を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | JockeyId | 騎手ID | INT | NOT NULL | ○ |  |  |
| 2 | JockeyName | 騎手名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | BirthDate | 生年月日 | DATE | NULL |  |  |  |
| 4 | CurrentAffiliation | 現在所属 | NVARCHAR(100) | NULL |  |  |  |
| 5 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 6 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_Jockey PRIMARY KEY (JockeyId)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 所属履歴テーブルは初期スコープ外。レース時点の所属はRaceEntryにスナップショット保存する。
