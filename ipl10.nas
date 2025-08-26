; haribote-ipl
; TAB=4

CYLS    EQU     10              ; どこまで読み込むか

        ORG     0x7c00          ; このプログラムをここから読み込む

; 以下は標準の FAT12 フォーマットディスクのための記述

        JMP     entry
        DB      0x90
        DB      "HARIBOTE"      ; ブートセクタの名前（8バイト）
        DW      512             ; 1 セクタの大きさ（512固定）
        DB      1               ; クラスタの大きさ（1 セクタ）
        DW      1               ; FATがどこから始まるか（通常1セクタ目）
        DB      2               ; FATの個数（2）
        DW      224             ; ルートディレクトリの項目数（通常224エントリ）
        DW      2880            ; このドライブのサイズ（2880セクタ）
        DB      0xf0            ; メディアのタイプ（0xf0）
        DW      9               ; FATの長さ（9セクタ）
        DW      18              ; 1トラックに含まれるセクタ数（18）
        DW      2               ; ヘッドの数（2）
        DD      0               ; パーティション未使用なので通常は0
        DD      2880            ; このドライブ容量の再掲
        DB      0,0,0x29        ; 気にしなくてよい値
        DD      0xffffffff      ; 適当なボリュームシリアル番号
        DB      "HARIBOTEOS "   ; ディスクの名前（11バイト）
        DB      "FAT12   "      ; フォーマット名（8バイト）
        RESB    18              ; とりあえず18バイト埋める

; プログラム本体

entry:
        MOV     AX,0            ; レジスタ初期化
        MOV     SS,AX
        MOV     SP,0x7c00
        MOV     DS,AX

; ディスク読み込みループ

        MOV     AX,0x0820
        MOV     ES,AX
        MOV     CH,0            ; シリンダ0
        MOV     DH,0            ; ヘッド0
        MOV     CL,2            ; セクタ2（セクタ1は自身：ブートセクタ）

readloop:
        MOV     SI,0            ; 試行回数カウンタ

retry:
        MOV     AH,0x02         ; AH=0x02 : ディスク読み込み
        MOV     AL,1            ; 1セクタ
        MOV     BX,0
        MOV     DL,0x00         ; Aドライブ
        INT     0x13            ; ディスクBIOS呼び出し
        JNC     next            ; エラーなしなら next
        ADD     SI,1
        CMP     SI,5
        JAE     error           ; 5回失敗で error
        MOV     AH,0x00
        MOV     DL,0x00
        INT     0x13            ; ドライブリセット
        JMP     retry

next:
        MOV     AX,ES           ; 読み込み先を 0x200 バイト進める (0x200 = 512 = 0x20 paragraphs)
        ADD     AX,0x0020
        MOV     ES,AX
        ADD     CL,1
        CMP     CL,18
        JBE     readloop
        MOV     CL,1
        ADD     DH,1
        CMP     DH,2
        JB      readloop
        MOV     DH,0
        ADD     CH,1
        CMP     CH,CYLS
        JB      readloop

; 読み終わったら haribote.sys を実行（ロード先 0x08200 相当を想定して JMP 0xc200）

        MOV     [0x0ff0],CH     ; 何シリンダまで読んだか記録
        JMP     0xc200

error:
        MOV     SI,msg

putloop:
        MOV     AL,[SI]
        ADD     SI,1
        CMP     AL,0
        JE      fin
        MOV     AH,0x0e
        MOV     BX,15
        INT     0x10
        JMP     putloop

fin:
        HLT                     ; CPU停止
        JMP     fin

msg:
        DB      0x0a, 0x0a
        DB      "load error"
        DB      0x0a
        DB      0

        RESB    0x7dfe-$        ; 0x7dfe まで 0x00 埋め
        DB      0x55, 0xaa