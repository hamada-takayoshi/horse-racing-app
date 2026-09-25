# Horse（馬）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `Horse` |
| 論理テーブル名 | 馬 |
| 概要 | 出走馬に限らず、種牡馬・繁殖牝馬・外国馬を含む馬全般の共通マスタ。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | HorseId | 馬ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | HorseName | 馬名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | BirthDate | 生年月日 | DATE | NULL |  |  |  |
| 4 | BirthYear | 生年 | SMALLINT | NULL |  |  |  |
| 5 | SexCode | 性別コード | VARCHAR(10) | NULL |  |  | MALE / FEMALE / GELDING |
| 6 | CountryCode | 国コード | CHAR(2) | NULL |  |  |  |
| 7 | SireHorseId | 父馬ID | BIGINT | NULL |  | Horse |  |
| 8 | DamHorseId | 母馬ID | BIGINT | NULL |  | Horse |  |
| 9 | Breeder | 生産者 | NVARCHAR(200) | NULL |  |  |  |
| 10 | CurrentOwner | 現在馬主 | NVARCHAR(200) | NULL |  |  |  |
| 11 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 12 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_Horse PRIMARY KEY (HorseId)
```

### 生年整合制約

```sql
CONSTRAINT CK_Horse_BirthYear
CHECK (BirthDate IS NULL OR BirthYear = YEAR(BirthDate))
```

### 性別コード制約

```sql
CONSTRAINT CK_Horse_SexCode
CHECK (SexCode IS NULL OR SexCode IN ('MALE','FEMALE','GELDING'))
```

## 4. インデックス候補

```sql
CREATE INDEX IX_Horse_NameBirthYear ON Horse(HorseName, BirthYear);
```

## 5. 設計上の補足

- HorseIdが正式な識別子。HorseName等は外部ID未登録時の照合補助属性であり、一意制約は付けない。
- DamSireHorseIdは物理保持せず、母馬のSireHorseIdから導出する。
