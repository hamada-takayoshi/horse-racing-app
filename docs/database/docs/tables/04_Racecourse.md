# Racecourse（競馬場）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `Racecourse` |
| 論理テーブル名 | 競馬場 |
| 概要 | 競馬場を管理する。競馬区分と実主催者を参照する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RacecourseId | 競馬場ID | INT | NOT NULL | ○ |  |  |
| 2 | RacingCategoryCode | 競馬区分コード | VARCHAR(20) | NOT NULL |  | RacingCategory |  |
| 3 | OrganizerId | 主催者ID | INT | NOT NULL |  | Organizer |  |
| 4 | RacecourseCode | 競馬場コード | VARCHAR(20) | NOT NULL |  |  |  |
| 5 | RacecourseName | 競馬場名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 6 | CountryCode | 国コード | CHAR(2) | NOT NULL |  |  |  |
| 7 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 8 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_Racecourse PRIMARY KEY (RacecourseId)
```

### 一意制約

```sql
CONSTRAINT UQ_Racecourse_Code UNIQUE (RacingCategoryCode, RacecourseCode)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- CountryCodeはRacecourse側だけに保持し、Organizerには重複保持しない。
