# Rawデータ保存・リネージ方針

## 1. 原本の定義

HTTPレスポンス等を文字コード変換する前のバイト列を原本とする。`ContentHash` は原本バイト列に対する SHA-256 を使用する。

## 2. 保存方式

- `DATABASE`: `RawContent.RawBinary` に `VARBINARY(MAX)` で保存。
- `FILE`: 外部ファイルへ保存し `StoragePath` を保持。
- `COMPRESSED_FILE`: gzip等の圧縮ファイルとして外部保存。

## 3. RawContent / RawFetch

同じ原本内容はRawContentに1件だけ保持し、取得のたびにRawFetchを追加する。

## 4. リネージ

初期は `RaceRawFetchLink` / `RaceEntryRawFetchLink` のみ作成する。その他は必要になった時点から個別リンクテーブルを追加できる。RawFetchが保存されていれば、過去分を再解析して後付けすることも可能。
