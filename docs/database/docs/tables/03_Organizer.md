# Organizer（主催者）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `Organizer` |
| 論理テーブル名 | 主催者 |
| 概要 | 実際の競馬主催者を管理する。NARを主催者としては扱わない。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | OrganizerId | 主催者ID | INT | NOT NULL | ○ |  |  |
| 2 | OrganizerCode | 主催者コード | VARCHAR(30) | NOT NULL |  |  |  |
| 3 | OrganizerName | 主催者名 | NVARCHAR(100) | NOT NULL |  |  |  |
| 4 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 5 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_Organizer PRIMARY KEY (OrganizerId)
```

### 一意制約

```sql
CONSTRAINT UQ_Organizer_Code UNIQUE (OrganizerCode)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 例：日本中央競馬会、東京都特別区競馬組合、岩手県競馬組合。
