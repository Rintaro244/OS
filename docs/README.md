# Outline
・30日間かけて自作OSを作るというプロジェクトに取り組んだ。私が「30日で出来る?! OS自作入門」に沿って編集したプログラムを、TAさんに毎回チェックしてもらうというプロセスで行った。

# SetUp(Usage)
1. 「30日で出来る?! OS自作入門」に付属されているtolsetをローカルに落とす。
2. tolsetの階層で git clone https://github.com/Rintaro244/OS を実行する。
3. OSのディレクトリにあるバッチファイル!cons_9x.bat !cons_nt.bat のどちらかを開く。
4. 開かれたコマンドプロンプトでmake runと入力し実行する。
5. 無事実行されたらOK。
[実行例](./img/screenshot_README.png)

# Features
## Chapter3
・asmhead.nasの画面モード設定内容を変更してみた。MOV  AL,0x13をMOV  AL,0x12に変え、それに伴いピクセル数なども調整した。結果は元々の場合と一致したが、bootpack.cは何も変えていないのでこのままでは正しい実行結果にはならないと考えられる。
## Chapter4
・bootpack.cの一部を変更して青色の四角形を左上に出力させた。
## Chapter5
・hankaku.txtを変更することで、私好みの文字フォントに変更した。
・画面表示する文字列に"Rintaro"を追加した。
## Chapter6~8
・マウスカーソルを動かすことに成功した。
・マウスカーソルが動いた軌跡に赤色が残るように変更してみた。
## Chapter9
・メモリを管理構造体のメモリ領域をオリジナルとは異なる領域で確保してみた。
・実行結果は変わらなかった。

# Reauirement
[CD-ROMの内容と同様のISOイメージ](https://book.mynavi.jp/supportsite/detail/4839919844.html)
