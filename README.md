# SENKIN_PostScript_calculateEnthalpy
SENKINの結果からエンタルピーを計算するポスト処理スクリプト
### 何のために
ラジカルの繰り返し投入の計算を行う上で，同じ量のラジカルを投入してもタイミングによっては投入エンタルピーが異なる．投入エネルギーをそろえた比較を行うために，各条件で保存されるエンタルピーがどれだけ異なっているかを知っておきたかった．
## ファイル構成
### 入力ファイル
1. 計算結果ファイル (`input/datasheet`，t(sec), P, T, Xのスペース区切りテキスト)
2. 化学反応に関するバイナリファイル (`input/cklink`，CKinterpで作成されるもの，SENKINの計算で使用したものを引っ張ってくる)
### 計算コード
1. `cklib.f` (CHEMKINの便利なサブルーチン集，`cklink`を読み込み)
2. `calc_enthalpy.f` (メインのPROGRAM，`datasheet`読み込み，エンタルピーを計算)
### 出力ファイル
1. `enthalpy` (計算結果，モルベースと質量ベース)
2. `terminalout` (標準出力，特に使用していない)
## 使用方法
```
$ make
$ ./calc_enthalpye
```# ChemicalKinetics_Explicit_with_CKlib
