# RaceEntry（レース出走馬）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceEntry` |
| 論理テーブル名 | レース出走馬 |
| 概要 | 登録段階からレース結果確定まで、レースと馬の関係を一貫して管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceEntryId | レース出走馬ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceId | レースID | BIGINT | NOT NULL |  | Race |  |
| 3 | HorseId | 馬ID | BIGINT | NOT NULL |  | Horse |  |
| 4 | FrameNumber | 枠番 | TINYINT | NULL |  |  |  |
| 5 | HorseNumber | 馬番 | TINYINT | NULL |  |  |  |
| 6 | JockeyId | 騎手ID | INT | NULL |  | Jockey |  |
| 7 | TrainerId | 調教師ID | INT | NULL |  | Trainer |  |
| 8 | HorseAge | 馬齢 | TINYINT | NULL |  |  |  |
| 9 | HorseSexCode | レース時性別コード | VARCHAR(10) | NULL |  |  | MALE / FEMALE / GELDING |
| 10 | AssignedWeight | 負担重量 | DECIMAL(4,1) | NULL |  |  |  |
| 11 | HorseWeight | 馬体重 | SMALLINT | NULL |  |  |  |
| 12 | HorseWeightChange | 馬体重増減 | SMALLINT | NULL |  |  |  |
| 13 | JockeyAllowanceMark | 見習減量記号 | NCHAR(1) | NULL |  |  |  |
| 14 | JockeyAllowanceWeight | 見習減量kg | DECIMAL(3,1) | NULL |  |  |  |
| 15 | JockeyAffiliationAtRace | レース時騎手所属 | NVARCHAR(100) | NULL |  |  |  |
| 16 | TrainerAffiliationAtRace | レース時調教師所属 | NVARCHAR(100) | NULL |  |  |  |
| 17 | OwnerAtRace | レース時馬主 | NVARCHAR(200) | NULL |  |  |  |
| 18 | FinishPosition | 着順 | TINYINT | NULL |  |  |  |
| 19 | FinishTimeText | 走破タイム原文 | NVARCHAR(20) | NULL |  |  |  |
| 20 | FinishTimeSeconds | 走破タイム秒 | DECIMAL(8,3) | NULL |  |  |  |
| 21 | FinishDifference | 着差 | NVARCHAR(30) | NULL |  |  |  |
| 22 | Final3F | 上がり3F | DECIMAL(5,2) | NULL |  |  |  |
| 23 | EntryStatusCode | 出走前状態コード | VARCHAR(20) | NOT NULL |  |  | REGISTERED / EXPECTED / CONFIRMED / SCRATCHED / EXCLUDED |
| 24 | EntryStatusDetail | 出走前状態詳細 | NVARCHAR(200) | NULL |  |  |  |
| 25 | ResultStatusCode | 結果状態コード | VARCHAR(20) | NULL |  |  | FINISHED / DNF / DISQUALIFIED / DEMOTED。結果未確定時はNULL |
| 26 | ResultStatusDetail | 結果状態詳細 | NVARCHAR(200) | NULL |  |  |  |
| 27 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 28 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceEntry PRIMARY KEY (RaceEntryId)
```

### 一意制約

```sql
CONSTRAINT UQ_RaceEntry_RaceHorse UNIQUE (RaceId, HorseId)
```

### 馬番一意（NULL除外）

```sql
CREATE UNIQUE INDEX UX_RaceEntry_RaceHorseNumber
ON RaceEntry(RaceId, HorseNumber)
WHERE HorseNumber IS NOT NULL;
```

### 性別コード制約

```sql
CONSTRAINT CK_RaceEntry_HorseSexCode
CHECK (HorseSexCode IS NULL OR HorseSexCode IN ('MALE','FEMALE','GELDING'))
```

### 出走前状態コード制約

```sql
CONSTRAINT CK_RaceEntry_EntryStatus
CHECK (EntryStatusCode IN ('REGISTERED','EXPECTED','CONFIRMED','SCRATCHED','EXCLUDED'))
```

### 結果状態コード制約

```sql
CONSTRAINT CK_RaceEntry_ResultStatus
CHECK (ResultStatusCode IS NULL OR ResultStatusCode IN ('FINISHED','DNF','DISQUALIFIED','DEMOTED'))
```

## 4. インデックス候補

```sql
CREATE INDEX IX_RaceEntry_Horse ON RaceEntry(HorseId, RaceId);
```

## 5. 設計上の補足

- HorseNumber / FrameNumber / JockeyIdは枠順・騎手未確定の登録段階を扱うためNULL可。
- `EntryStatusCode` は出走前～発走前の状態、`ResultStatusCode` は結果状態を表す別軸である。
- 結果未確定時は `ResultStatusCode` をNULLとする。
- 人気・オッズ・脚質は本テーブルに持たず、専用テーブルで管理する。
