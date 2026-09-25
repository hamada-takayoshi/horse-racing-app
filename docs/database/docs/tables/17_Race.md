# Race（レース）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `Race` |
| 論理テーブル名 | レース |
| 概要 | 開催日・競馬場・競走条件等のレース基本情報を保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceId | レースID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceDate | 開催日 | DATE | NOT NULL |  |  |  |
| 3 | RacecourseId | 競馬場ID | INT | NOT NULL |  | Racecourse |  |
| 4 | RaceNumber | レース番号 | TINYINT | NOT NULL |  |  |  |
| 5 | RaceName | レース名 | NVARCHAR(200) | NOT NULL |  |  |  |
| 6 | StartTime | 発走時刻 | TIME | NULL |  |  |  |
| 7 | MeetingNumber | 開催回 | TINYINT | NULL |  |  |  |
| 8 | MeetingDay | 開催日次 | TINYINT | NULL |  |  |  |
| 9 | MeetingLabel | 開催表示 | NVARCHAR(50) | NULL |  |  |  |
| 10 | RaceTypeCode | 競走形式コード | VARCHAR(10) | NOT NULL |  |  | FLAT/JUMP |
| 11 | SurfaceTypeCode | 馬場種別コード | VARCHAR(10) | NOT NULL |  |  | TURF/DIRT |
| 12 | Distance | 距離m | INT | NOT NULL |  |  |  |
| 13 | CourseDirectionCode | 回り方向コード | VARCHAR(10) | NULL |  |  |  |
| 14 | CourseDetail | コース詳細 | NVARCHAR(50) | NULL |  |  |  |
| 15 | WeatherCode | 天候コード | VARCHAR(30) | NULL |  | Weather |  |
| 16 | WeatherText | 天候原文 | NVARCHAR(50) | NULL |  |  |  |
| 17 | TrackConditionCode | 馬場状態コード | VARCHAR(30) | NULL |  | TrackCondition |  |
| 18 | TrackConditionText | 馬場状態原文 | NVARCHAR(50) | NULL |  |  |  |
| 19 | RaceClassCode | 競走クラスコード | VARCHAR(30) | NULL |  | RaceClass |  |
| 20 | RaceClassText | 競走クラス原文 | NVARCHAR(100) | NULL |  |  |  |
| 21 | RaceGradeCode | グレードコード | VARCHAR(30) | NULL |  | RaceGrade |  |
| 22 | AgeConditionCode | 年齢条件コード | VARCHAR(30) | NULL |  | AgeCondition |  |
| 23 | AgeConditionText | 年齢条件原文 | NVARCHAR(100) | NULL |  |  |  |
| 24 | SexConditionCode | 性別条件コード | VARCHAR(30) | NULL |  | SexCondition |  |
| 25 | SexConditionText | 性別条件原文 | NVARCHAR(100) | NULL |  |  |  |
| 26 | WeightConditionCode | 負担重量条件コード | VARCHAR(30) | NULL |  | WeightCondition |  |
| 27 | WeightConditionText | 負担重量条件原文 | NVARCHAR(100) | NULL |  |  |  |
| 28 | NumberOfEntries | 登録頭数 | TINYINT | NULL |  |  |  |
| 29 | NumberOfStarters | 公式出走頭数 | TINYINT | NULL |  |  |  |
| 30 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 31 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_Race PRIMARY KEY (RaceId)
```

### 一意制約

```sql
CONSTRAINT UQ_Race_DateCourseNumber UNIQUE (RaceDate, RacecourseId, RaceNumber)
```

### 固定コード制約

```sql
CONSTRAINT CK_Race_RaceType CHECK (RaceTypeCode IN ('FLAT','JUMP'))
CONSTRAINT CK_Race_SurfaceType CHECK (SurfaceTypeCode IN ('TURF','DIRT'))
CONSTRAINT CK_Race_CourseDirection CHECK (CourseDirectionCode IS NULL OR CourseDirectionCode IN ('LEFT','RIGHT','STRAIGHT'))
```

## 4. インデックス候補

```sql
CREATE INDEX IX_Race_Date ON Race(RaceDate);
```

```sql
CREATE INDEX IX_Race_CourseDate ON Race(RacecourseId, RaceDate);
```

## 5. 設計上の補足

- NumberOfStartersは取得元の公式値。RaceEntry件数との差異は取込品質チェックに利用する。
- 公式確定値は採用ルールに基づく1値だけを保持する。
