# RaceEntryRawFetchLink（出走馬取得リネージ）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceEntryRawFetchLink` |
| 論理テーブル名 | 出走馬取得リネージ |
| 概要 | RaceEntryとRawFetchの対応を管理する。初期リネージ対象。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceEntryId | レース出走馬ID | BIGINT | NOT NULL | ○ | RaceEntry |  |
| 2 | RawFetchId | 取得イベントID | BIGINT | NOT NULL | ○ | RawFetch |  |
| 3 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceEntryRawFetchLink PRIMARY KEY (RaceEntryId, RawFetchId)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- その他エンティティのリネージは必要時に個別リンクテーブルを追加し、過去分はRawFetchから再解析して補完可能とする。
