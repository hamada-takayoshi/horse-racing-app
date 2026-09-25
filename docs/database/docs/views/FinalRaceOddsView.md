# FinalRaceOddsView（最終確定オッズ）

`IsFinal=1` の最終確定オッズを取得する分析・参照用ビュー。選択対象種別は `BetType.SelectionTypeCode` から取得する。

## 定義

```sql
CREATE OR ALTER VIEW dbo.FinalRaceOddsView
AS
SELECT
    ro.RaceOddsId,
    ro.RaceId,
    ro.BetTypeCode,
    bt.SelectionTypeCode,
    ro.SelectionKey,
    ro.OddsMin,
    ro.OddsMax,
    ro.Popularity,
    ro.RecordedAt,
    ro.DataSourceId
FROM dbo.RaceOdds AS ro
INNER JOIN dbo.BetType AS bt
    ON bt.BetTypeCode = ro.BetTypeCode
WHERE ro.IsFinal = 1;
```

`RaceOdds` にはフィルター付き一意インデックス `UX_RaceOdds_Final` を設定し、同一レース・券種・組合せ・取得元に複数の最終オッズが登録されないようDB側で保証する。
