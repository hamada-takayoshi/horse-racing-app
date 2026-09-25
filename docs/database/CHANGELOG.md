# 変更履歴

## v3.1

- `BetType.SelectionTypeCode` を正式定義し、RaceOdds / RacePayout から同列を削除。
- 最終オッズの重複をDBで防止するフィルター付き一意インデックスを追加。
- RaceEntry の状態を `EntryStatusCode` と `ResultStatusCode` に分離し、各コードの意味を明文化。
- Horse / RaceEntry の性別を日本語文字列から英数字コードへ変更。
- `99_validation_report.md` に検証項目と結果を明記。
- overview画像を日本語表記へ統一。
- README / 設計方針資料を差分中心ではなく現行仕様中心に再構成。

## v3

v3以前の履歴は旧版資料を参照。
