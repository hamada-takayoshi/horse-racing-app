# RaceOdds（オッズ）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceOdds` |
| 論理テーブル名 | オッズ |
| 概要 | 券種・組合せ・取得時点・取得元ごとのオッズと人気を保持する。選択対象種別はBetTypeから決定する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceOddsId | オッズID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceId | レースID | BIGINT | NOT NULL |  | Race |  |
| 3 | BetTypeCode | 馬券種別コード | VARCHAR(30) | NOT NULL |  | BetType | BetType.SelectionTypeCodeから選択対象種別を判断 |
| 4 | SelectionKey | 正規化組合せキー | VARCHAR(50) | NOT NULL |  |  |  |
| 5 | OddsMin | オッズ最小値 | DECIMAL(12,4) | NOT NULL |  |  |  |
| 6 | OddsMax | オッズ最大値 | DECIMAL(12,4) | NOT NULL |  |  |  |
| 7 | Popularity | 人気順位 | TINYINT | NULL |  |  |  |
| 8 | RecordedAt | 観測日時 | DATETIME2 | NOT NULL |  |  |  |
| 9 | IsFinal | 最終確定フラグ | BIT | NOT NULL |  |  |  |
| 10 | DataSourceId | データ取得元ID | INT | NOT NULL |  | DataSource |  |
| 11 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 12 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceOdds PRIMARY KEY (RaceOddsId)
```

### 時点別一意制約

```sql
CONSTRAINT UQ_RaceOdds
UNIQUE (RaceId, BetTypeCode, SelectionKey, RecordedAt, DataSourceId)
```

### 最終確定オッズ一意

```sql
CREATE UNIQUE INDEX UX_RaceOdds_Final
ON RaceOdds(RaceId, BetTypeCode, SelectionKey, DataSourceId)
WHERE IsFinal = 1;
```

### 範囲整合

```sql
CONSTRAINT CK_RaceOdds_Range CHECK (OddsMin <= OddsMax)
```

## 4. インデックス候補

```sql
CREATE INDEX IX_RaceOdds_FinalLookup
ON RaceOdds(RaceId, BetTypeCode, IsFinal)
INCLUDE (SelectionKey, OddsMin, OddsMax, Popularity, DataSourceId);
```

## 5. 設計上の補足

- 単一値オッズはOddsMin=OddsMax。複勝・ワイド等の幅はMin/Maxで保持する。
- 選択対象種別は `BetType.SelectionTypeCode` を参照し、RaceOddsには重複保持しない。
- 単勝・複勝は時系列保存。中間券種は必要に応じて時系列。三連複・三連単は初期は最終オッズのみ。
- `IsFinal=1` はフィルター付き一意インデックスでDB側から重複を防止する。
