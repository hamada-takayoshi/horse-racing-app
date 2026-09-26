# 現行設計方針

この文書は変更履歴ではなく、v3.1時点で設計・実装時に守る主要方針をまとめたものです。変更履歴はルートの `CHANGELOG.md` を参照してください。

## 1. 正本と資料体系

- テーブル定義は `docs/tables/*.md` を正本とする。
- ER関係は `diagram/*.mmd` を正本とする。
- PNG / DOT / overview画像は閲覧用派生資料とする。
- 主要ドキュメントは現行仕様だけで理解できる内容とし、差分は `CHANGELOG.md` に分離する。

## 2. 文字列・コード

- 日本語・人名・馬名等は `NVARCHAR` / `NCHAR` を使用する。
- システム内部の英数字コードは `VARCHAR` / `CHAR` を使用する。
- 業務コードはコードマスタ + FK、固定システムコードはCHECK制約で管理する。
- 性別は `MALE` / `FEMALE` / `GELDING` の英数字コードで保持する。

## 3. データソースと採用値

- 公式確定値はソース優先順位に従って正規値を1つ採用する。
- `RaceOdds` / `RaceEntryMetric` / `RaceEntryEvaluation` は提供元ごとの値を並存可能にする。
- 確定値側の `DataSourceId` は「採用値の取得元」、並存データ側では「その値を提示・算出した提供元」を意味する。

## 4. Race / RaceEntry

- Raceは平地/障害 (`RaceTypeCode`) と芝/ダート (`SurfaceTypeCode`) を別管理する。
- RaceEntryは登録段階から結果確定まで同一レコードを継続利用する。
- 出走前状態は `EntryStatusCode`、レース結果状態は `ResultStatusCode` に分ける。
- `FrameNumber` / `HorseNumber` / `JockeyId` は未確定時にNULLを許容する。
- レース時点の騎手所属・調教師所属・馬主はRaceEntryのスナップショットとして保持する。

## 5. EntryStatus / ResultStatus

`EntryStatusCode` は出走前～発走前の状態を表す。

| 値 | 意味 |
| --- | --- |
| REGISTERED | 登録馬として登録済み。出走馬確定前。 |
| EXPECTED | 出走予定馬として扱われているが、枠順・馬番等が未確定の段階を含む。 |
| CONFIRMED | 正式な出走馬として確定。枠順・馬番は確定後に設定する。 |
| SCRATCHED | 出走予定/確定後に出走取消となった。 |
| EXCLUDED | 主催者判断等により競走除外となった。 |

`ResultStatusCode` はレース結果状態を表し、結果未確定時はNULLとする。

| 値 | 意味 |
| --- | --- |
| FINISHED | 正常に競走を完了し、着順が確定した。 |
| DNF | 競走中止等により完走しなかった。 |
| DISQUALIFIED | 失格。 |
| DEMOTED | 降着。 |

## 6. オッズ・払戻・Selection

- `BetType.SelectionTypeCode` が馬券種別ごとの `HORSE` / `FRAME` を決定する。
- RaceOdds / RacePayout にはSelectionTypeCodeを重複保持しない。
- 順不同券種はSelection番号を昇順正規化する。
- 順序あり券種は指定順を維持する。
- `SelectionKey` を親に保持し、Selection明細を子テーブルに保持する。
- RaceOddsの最終オッズは `IsFinal=1` とフィルター付き一意インデックスでDB側から重複を防止する。

## 7. オッズ保存範囲

- 単勝・複勝: 時系列保存。
- 枠連・馬連・ワイド・馬単: 必要に応じて時系列保存。
- 三連複・三連単: 初期は最終オッズのみ。
- 複勝・ワイド等の幅オッズは `OddsMin` / `OddsMax` で保持する。

## 8. RawData・リネージ

- 原本内容はRawContent、取得イベントはRawFetchに分離する。
- ContentHashはデコード前バイト列に対して計算する。
- RawContentはDB内バイナリ/外部ファイル/圧縮ファイルに対応する。
- 初期リネージはRace / RaceEntryのみ。RawContent / RawFetchは全取得分を保存し、後から他テーブルのリンクを追加可能とする。

## 9. Horse

- HorseIdを正式な内部識別子とする。
- 外部IDはデータソース別Mappingで管理する。
- Horseは出走馬だけでなく種牡馬・繁殖牝馬・外国馬等も含む。
- BirthDate / BirthYearを両方保持し、BirthDateがある場合はDB制約で年の一致を保証する。
- DamSireHorseIdは保持せず、母馬のSireHorseIdから導出する。

## 10. 対象範囲

- 中央/地方はRacingCategoryで区分する。
- Organizerは実主催者を管理する。
- 枠単を馬券種別に含める。
- WIN5は初期スコープ外とする。

## 11. SQL Server物理実装

- 単一の数値サロゲート主キーは `IDENTITY(1,1)` で採番する。
- `CreatedAt` / `UpdatedAt` の初期値は `SYSUTCDATETIME()` とする。
- 外部キーの削除・更新動作は、個別指定がない限り `NO ACTION` とする。
- DDL、Index、View、初期データ投入は再実行可能にする。
- 設計資料に具体値がないコードマスタへ推測値を投入しない。
