# v3.1 資料検証結果

このファイルは「検出事項なし」という結論だけではなく、何を検証したかを明記する。

## 1. 検証対象

- README / 設計方針 / コード定義 / Selectionルール間の用語整合
- 全テーブル定義書の存在確認
- Markdown見出し番号の連続性
- FK欄に記載された参照先テーブルの存在確認
- BetType.SelectionTypeCode と RaceOdds / RacePayout の重複有無
- RaceEntryのEntryStatusCode / ResultStatusCode分離
- Horse / RaceEntry の性別コード統一
- RaceOdds最終値のフィルター付き一意インデックス定義
- FinalRaceOddsView とテーブル定義のカラム整合
- Mermaid ER図に旧 `RaceEntryStatusCode` / 旧 `Sex` 定義が残っていないこと
- Mermaid各図が「主要項目の抜粋」であることの注記
- README記載のフォルダ構成と実ファイルの一致
- overview画像が日本語表記であること

## 2. 自動チェック結果

自動チェックはZIP生成前に実施し、結果を本ファイルへ反映する。

- 旧 `RaceEntryStatusCode`: 0件
- RaceOdds / RacePayout 内の `SelectionTypeCode` カラム定義: 0件
- 旧 `Horse.Sex NCHAR(1)` / `RaceEntry.HorseSex NCHAR(1)`: 0件
- Markdown主要見出し欠落: 0件
- FinalRaceOddsView の旧RaceOdds.SelectionTypeCode参照: 0件
- HorseAnalysisView の旧Horse.Sex参照: 0件

## 3. SQL Server適用試験結果

SQL Server 2025 DeveloperコンテナへDDLを適用し、以下を確認した。

- テーブル: 39件
- View: 2件
- 主キー: 39件
- 一意制約: 19件
- 外部キー: 52件
- CHECK制約: 14件
- 設計資料で定義されたIndex: 9件
- RacingCategory初期値: 2件
- BetType初期値: 9件
- 初期化処理の再実行: 成功
- アプリ用ユーザーでの接続・スキーマ参照・書込み後ロールバック: 成功

## 4. 結論

上記検証項目について不整合を検出していない。実データ取込試験はアプリケーション実装後に行う。
