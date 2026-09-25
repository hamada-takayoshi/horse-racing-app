# RaceOddsSelection（オッズ選択明細）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceOddsSelection` |
| 論理テーブル名 | オッズ選択明細 |
| 概要 | RaceOddsの組合せを構造化して保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceOddsId | オッズID | BIGINT | NOT NULL | ○ | RaceOdds |  |
| 2 | SelectionOrder | 選択順 | TINYINT | NOT NULL | ○ |  |  |
| 3 | SelectionNumber | 選択番号 | TINYINT | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceOddsSelection PRIMARY KEY (RaceOddsId, SelectionOrder)
```

### 番号重複禁止

```sql
CONSTRAINT UQ_RaceOddsSelection_Number UNIQUE (RaceOddsId, SelectionNumber)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- SelectionTypeCodeは保持せず、親RaceOdds.BetTypeCodeからBetType.SelectionTypeCodeを参照して判断する。
- 順不同券種は番号昇順に正規化してSelectionOrderを採番。順序あり券種は指定順を維持する。
