# Selection 格納ルール

RaceOdds / RacePayout の組合せ情報は、親テーブルの `SelectionKey` と子テーブルのSelection明細の両方で保持する。

## 1. 選択対象種別

選択対象が馬番か枠番かは、馬券種別マスタ `BetType.SelectionTypeCode` で一元管理する。

- `HORSE`: 馬番を選択する券種
- `FRAME`: 枠番を選択する券種

RaceOdds / RacePayout / Selection明細には SelectionTypeCode を重複保持しない。

## 2. 順不同券種

対象: 枠連、馬連、ワイド、三連複。

- SelectionNumber を昇順に正規化する。
- 正規化後の順に SelectionOrder=1,2,3... を付与する。
- SelectionKeyも昇順正規化後の番号から生成する。

例: 馬連 7-3 → 03-07

## 3. 順序あり券種

対象: 枠単、馬単、三連単。

- 指定順を維持する。
- SelectionOrderで順序を表現する。
- SelectionKeyも順序を維持して生成する。

例: 馬単 3→7 → 03>07

## 4. DB制約

RaceOddsSelection / RacePayoutSelection では以下を保証する。

- `(ParentId, SelectionOrder)` を一意にする。
- `(ParentId, SelectionNumber)` を一意にし、同一組合せ内の同一番号重複を禁止する。
- 親のBetTypeCodeからSelectionTypeCodeを決定するため、1組合せ内でHORSE/FRAMEが混在する余地を持たせない。

## 5. SelectionKey

SelectionKeyは重複防止・検索用の正規化キーであり、Selection明細が構造化された正本データである。SelectionKey生成ロジックは取込処理で一元化する。
