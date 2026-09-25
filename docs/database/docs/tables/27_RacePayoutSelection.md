# RacePayoutSelection（払戻選択明細）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RacePayoutSelection` |
| 論理テーブル名 | 払戻選択明細 |
| 概要 | RacePayoutの組合せを構造化して保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RacePayoutId | 払戻ID | BIGINT | NOT NULL | ○ | RacePayout |  |
| 2 | SelectionOrder | 選択順 | TINYINT | NOT NULL | ○ |  |  |
| 3 | SelectionNumber | 選択番号 | TINYINT | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RacePayoutSelection PRIMARY KEY (RacePayoutId, SelectionOrder)
```

### 番号重複禁止

```sql
CONSTRAINT UQ_RacePayoutSelection_Number UNIQUE (RacePayoutId, SelectionNumber)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 格納ルールはRaceOddsSelectionと同じ。
