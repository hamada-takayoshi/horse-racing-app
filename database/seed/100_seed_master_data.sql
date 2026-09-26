USE [$(DatabaseName)];
GO

MERGE dbo.RacingCategory AS target
USING (VALUES
    ('CENTRAL', N'中央競馬', 1, CAST(1 AS BIT)),
    ('LOCAL', N'地方競馬', 2, CAST(1 AS BIT))
) AS source (RacingCategoryCode, RacingCategoryName, SortOrder, IsActive)
ON target.RacingCategoryCode = source.RacingCategoryCode
WHEN MATCHED THEN
    UPDATE SET
        RacingCategoryName = source.RacingCategoryName,
        SortOrder = source.SortOrder,
        IsActive = source.IsActive
WHEN NOT MATCHED THEN
    INSERT (RacingCategoryCode, RacingCategoryName, SortOrder, IsActive)
    VALUES (source.RacingCategoryCode, source.RacingCategoryName, source.SortOrder, source.IsActive);
GO

MERGE dbo.BetType AS target
USING (VALUES
    ('WIN', N'単勝', 'HORSE', 1, CAST(1 AS BIT)),
    ('PLACE', N'複勝', 'HORSE', 2, CAST(1 AS BIT)),
    ('BRACKET_QUINELLA', N'枠連', 'FRAME', 3, CAST(1 AS BIT)),
    ('BRACKET_EXACTA', N'枠単', 'FRAME', 4, CAST(1 AS BIT)),
    ('QUINELLA', N'馬連', 'HORSE', 5, CAST(1 AS BIT)),
    ('WIDE', N'ワイド', 'HORSE', 6, CAST(1 AS BIT)),
    ('EXACTA', N'馬単', 'HORSE', 7, CAST(1 AS BIT)),
    ('TRIO', N'三連複', 'HORSE', 8, CAST(1 AS BIT)),
    ('TRIFECTA', N'三連単', 'HORSE', 9, CAST(1 AS BIT))
) AS source (BetTypeCode, BetTypeName, SelectionTypeCode, SortOrder, IsActive)
ON target.BetTypeCode = source.BetTypeCode
WHEN MATCHED THEN
    UPDATE SET
        BetTypeName = source.BetTypeName,
        SelectionTypeCode = source.SelectionTypeCode,
        SortOrder = source.SortOrder,
        IsActive = source.IsActive
WHEN NOT MATCHED THEN
    INSERT (BetTypeCode, BetTypeName, SelectionTypeCode, SortOrder, IsActive)
    VALUES (source.BetTypeCode, source.BetTypeName, source.SelectionTypeCode, source.SortOrder, source.IsActive);
GO
