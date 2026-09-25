# RaceRawFetchLink（レース取得リネージ）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceRawFetchLink` |
| 論理テーブル名 | レース取得リネージ |
| 概要 | RaceとRawFetchの対応を管理する。初期リネージ対象。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceId | レースID | BIGINT | NOT NULL | ○ | Race |  |
| 2 | RawFetchId | 取得イベントID | BIGINT | NOT NULL | ○ | RawFetch |  |
| 3 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceRawFetchLink PRIMARY KEY (RaceId, RawFetchId)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- RawContent/RawFetchは全取得で保存する。
