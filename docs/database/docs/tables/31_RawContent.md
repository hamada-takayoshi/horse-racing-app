# RawContent（取得原本内容）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RawContent` |
| 論理テーブル名 | 取得原本内容 |
| 概要 | 取得した原本バイト列を内容単位で重複排除して保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RawContentId | 原本内容ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | ContentHash | 内容ハッシュ | CHAR(64) | NOT NULL |  |  |  |
| 3 | StorageTypeCode | 保存方式コード | VARCHAR(20) | NOT NULL |  |  |  |
| 4 | RawBinary | 原本バイト列 | VARBINARY(MAX) | NULL |  |  |  |
| 5 | StoragePath | 外部保存パス | NVARCHAR(1000) | NULL |  |  |  |
| 6 | ContentEncoding | 文字エンコーディング | VARCHAR(50) | NULL |  |  |  |
| 7 | ContentLength | バイト長 | BIGINT | NOT NULL |  |  |  |
| 8 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 9 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RawContent PRIMARY KEY (RawContentId)
```

### ハッシュ一意

```sql
CONSTRAINT UQ_RawContent_Hash UNIQUE (ContentHash)
```

### 保存方式制約

```sql
CONSTRAINT CK_RawContent_StorageType CHECK (StorageTypeCode IN ('DATABASE','FILE','COMPRESSED_FILE'))
```

### 保存先整合

```sql
CONSTRAINT CK_RawContent_Storage CHECK ((StorageTypeCode='DATABASE' AND RawBinary IS NOT NULL) OR (StorageTypeCode IN ('FILE','COMPRESSED_FILE') AND StoragePath IS NOT NULL))
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- ContentHashはデコード前の取得バイト列に対するSHA-256を想定。
