# コード定義 v3.1

固定的なシステムコードは `CHECK` 制約、業務上の追加・名称変更があり得るコードはマスタテーブルで管理する。

## 1. CHECK制約で管理するコード

| コード | 値 | 説明 |
| --- | --- | --- |
| RaceTypeCode | FLAT / JUMP | 平地 / 障害 |
| SurfaceTypeCode | TURF / DIRT | 芝 / ダート |
| CourseDirectionCode | LEFT / RIGHT / STRAIGHT | 左 / 右 / 直線 |
| SelectionTypeCode | HORSE / FRAME | 馬番 / 枠番。BetTypeで券種ごとに定義する。 |
| StorageTypeCode | DATABASE / FILE / COMPRESSED_FILE | 原本保存方式 |
| SourceTypeCode | WEB / API / FILE | 取得方式 |
| AuthorityLevelCode | OFFICIAL / OFFICIAL_PROVIDER / PAID / EXTERNAL | 採用優先度の分類 |
| SexCode | MALE / FEMALE / GELDING | 牡 / 牝 / セン馬 |
| EntryStatusCode | REGISTERED / EXPECTED / CONFIRMED / SCRATCHED / EXCLUDED | 出走前～発走前状態 |
| ResultStatusCode | FINISHED / DNF / DISQUALIFIED / DEMOTED | レース結果状態 |

### EntryStatusCode 詳細

| 値 | 意味 |
| --- | --- |
| REGISTERED | 登録馬として登録済み。出走馬確定前。 |
| EXPECTED | 出走予定馬として扱われているが、枠順・馬番等が未確定の段階を含む。 |
| CONFIRMED | 正式な出走馬として確定。 |
| SCRATCHED | 出走予定/確定後に出走取消となった。 |
| EXCLUDED | 主催者判断等により競走除外となった。 |

### ResultStatusCode 詳細

| 値 | 意味 |
| --- | --- |
| FINISHED | 正常に競走を完了し、着順が確定した。 |
| DNF | 競走中止等により完走しなかった。 |
| DISQUALIFIED | 失格。 |
| DEMOTED | 降着。 |

## 2. マスタテーブルで管理するコード

| マスタ | 用途 |
| --- | --- |
| BetType | 馬券種別。SelectionTypeCodeも保持する。 |
| RaceGrade | 競走グレード |
| Weather | 天候 |
| TrackCondition | 馬場状態 |
| RaceClass | 競走クラス |
| AgeCondition | 年齢条件 |
| SexCondition | 性別条件 |
| WeightCondition | 負担重量条件 |
| MetricType | 指数種別 |
| EvaluationType | 評価種別 |
| Unit | 単位 |
| DataType | 生データ種別 |

## 3. BetType 初期値

| コード | 論理名 | SelectionTypeCode |
| --- | --- | --- |
| WIN | 単勝 | HORSE |
| PLACE | 複勝 | HORSE |
| BRACKET_QUINELLA | 枠連 | FRAME |
| BRACKET_EXACTA | 枠単 | FRAME |
| QUINELLA | 馬連 | HORSE |
| WIDE | ワイド | HORSE |
| EXACTA | 馬単 | HORSE |
| TRIO | 三連複 | HORSE |
| TRIFECTA | 三連単 | HORSE |

> WIN5は初期スコープ外。複数レース型馬券として将来別モデルを設計する。
