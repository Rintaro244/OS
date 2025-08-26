# Chapter3
"chapter3"の最後に用いたファイルを一部変更してみた。
 
## Outline
・C言語ファイルのbootpack.cを様々な.exeファイルを用いて、機械語のファイルにする。C言語ではHLTが使えないので、別のファイルで代用されている。
 
## Features
・asmhead.nasの画面モード設定の内容を変更してみた。MOV  AL,0x13をMOV  AL,0x12に変え、それに伴いピクセル数なども調整した。結果は元の場合と一致したが、bootpack.cは何も変えていないのでこのままでは正しい実行結果にはならないと考えられる。
 
## SetUp
・Makefileを見ると、コマンドmake runだけで全てセットアップ可能だとわかる。
 
## Result
[実行結果](./screenshot_chap3.png)


# Chapter4
"chapter4"の最後に用いたファイルを一部変更してみた。

## Outline
・メモリに書き込む番地(アドレス)を変化させることで、さまざまな画面表示を実現している。最後にはタスクバーなどを追加してOSに少し近づいた。

## Features
・bootpack.cの一部を変更して、青色の四角形を左上に出力させた。

## Setup
・make runだけでセットアップ可能である。

## Result
[実行結果](./screenshot_chap4.png)


# Chapter5
"chapter5"の最後に用いたファイルを一部変更してみた。

## Outline
・画素を0(点を打たない場所)と1(点を打つ場所)に分類することで、文字列や変数の値、マウスカーソルを表示した。
・GDPとIDTについては次のチャプターで詳しくやるらしい。

## Features
・hankaku.txtを変更することで、私好みの文字フォントに変更した。
・画面表示する文字列に"Rintaro"を追加した。

## Setup
・make runだけでセットアップ可能である。

## Result
[実行結果](./screenshot_chap5.png)
