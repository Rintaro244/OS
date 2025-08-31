# Outline
・30日間かけて自作�?�OSを作ると�?�?プロジェクに取り�?んだ。私が�?30日で出来�?! OS自作�?�門」に沿って編�?したプログラ�?を、TAさんに毎回チェ�?クしてもら�?と�?�?プロセスで行った�?

# SetUp(Usage)
1. �?30日で出来�?! OS自作�?�門」に付属されて�?るtolsetをローカルに落とす�?
2. tolsetの階層で git clone https://github.com/Rintaro244/OS を実行する�?
3. OS�?ィレクトリ�?にあるバッチファイル!cons_9x.bat !cons_nt.bat のどちらかを開く�?
4. 開かれたコマンド�?�ロンプト�?でmake runと入力し実行する�?
5. 無事実行されたらOK�?
[実行例](./img/screenshot_README.png)

# Features
## Chapter3
・asmhead.nasの画面モード設定�?��?容を変更してみた�?MOV  AL,0x13をMOV  AL,0x12に変え、それに伴�?ピクセル数なども調整した。結果は�?の場合と一致したが、bootpack.cは何も変えて�?な�?のでこ�?�ままでは正しい実行結果にはならな�?と�?えられる�?
## Chapter4
・bootpack.cの一部を変更して�?青色の四角形を左上に出力させた�?
## Chapter5
・hankaku.txtを変更することで、私好みの�?字フォントに変更した�?
・画面表示する�?字�?�に"Rintaro"を追�?した�?
## Chapter6~8
・マウスカーソルを動かすことに成功した。
・マウスカーソルが動いた軌跡に赤色が残るように変更してみた。

# Reauirement
[CD-ROMの�?容と同様�?�ISOイメージ](https://book.mynavi.jp/supportsite/detail/4839919844.html)