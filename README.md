# ChemicalKinetics_Explicit_with_CKlib
CHEMINパッケージを利用した陽解法による化学反応計算
## ファイル構成
### 入力ファイル
1. 計算結果ファイル (`input/datasheet`，t(sec), P, T, Xのスペース区切りテキスト)
2. 化学反応に関するバイナリファイル (`input/cklink`，CKinterpで作成されるもの，SENKINの計算で使用したものを引っ張ってくる)
### 計算コード
1. `cklib.f` (CHEMKINの便利なサブルーチン集，`cklink`を読み込み)
2. `ChemicalKinetics_ex.f` (メインのPROGRAM，`datasheet`読み込み，陽解法ループ)
### 出力ファイル
1. `ckex_out` (計算結果)
2. `terminal_out` (標準出力，特に使用していない)
## 使用方法
```
$ make
$ ./ChemicalKinetics_exe
```
