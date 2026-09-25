# RaceCorner（コーナー通過順位）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceCorner` |
| 論理テーブル名 | コーナー通過順位 |
| 概要 | 出走馬の各コーナー通過順位を保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceCornerId | コーナー通過ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceEntryId | レース出走馬ID | BIGINT | NOT NULL |  | RaceEntry |  |
| 3 | CornerNumber | コーナー番号 | TINYINT | NOT NULL |  |  |  |
| 4 | Position | 通過順位 | TINYINT | NULL |  |  |  |
| 5 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 6 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceCorner PRIMARY KEY (RaceCornerId)
```

### 一意制約

```sql
CONSTRAINT UQ_RaceCorner UNIQUE (RaceEntryId, CornerNumber)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 特記事項なし。
