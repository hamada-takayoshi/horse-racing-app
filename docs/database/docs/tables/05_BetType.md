# BetType（馬券種別）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `BetType` |
| 論理テーブル名 | 馬券種別 |
| 概要 | 馬券種別と、その券種が馬番・枠番のどちらを選択対象とするかを管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | BetTypeCode | 馬券種別コード | VARCHAR(30) | NOT NULL | ○ |  |  |
| 2 | BetTypeName | 馬券種別名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 3 | SelectionTypeCode | 選択対象種別 | VARCHAR(10) | NOT NULL |  |  | HORSE / FRAME |
| 4 | SortOrder | 表示順 | SMALLINT | NOT NULL |  |  |  |
| 5 | IsActive | 有効フラグ | BIT | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_BetType PRIMARY KEY (BetTypeCode)
```

### 選択対象種別

```sql
CONSTRAINT CK_BetType_SelectionType
CHECK (SelectionTypeCode IN ('HORSE','FRAME'))
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- SelectionTypeCodeは券種から一意に決まるため、RaceOdds / RacePayoutには重複保持しない。
- 初期コード: WIN=単勝, PLACE=複勝, BRACKET_QUINELLA=枠連, BRACKET_EXACTA=枠単, QUINELLA=馬連, WIDE=ワイド, EXACTA=馬単, TRIO=三連複, TRIFECTA=三連単。
- WIN5は初期スコープ外。複数レース型馬券として将来別モデルを設計する。
