# RaceLap（レースラップ）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceLap` |
| 論理テーブル名 | レースラップ |
| 概要 | レースの区間ラップを保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceLapId | レースラップID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceId | レースID | BIGINT | NOT NULL |  | Race |  |
| 3 | SectionNumber | 区間番号 | TINYINT | NOT NULL |  |  |  |
| 4 | DistanceFrom | 区間開始距離 | INT | NULL |  |  |  |
| 5 | DistanceTo | 区間終了距離 | INT | NULL |  |  |  |
| 6 | LapTime | ラップ秒 | DECIMAL(5,2) | NOT NULL |  |  |  |
| 7 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 8 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceLap PRIMARY KEY (RaceLapId)
```

### 一意制約

```sql
CONSTRAINT UQ_RaceLap UNIQUE (RaceId, SectionNumber)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 特記事項なし。
