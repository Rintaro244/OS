; haribote-os boot asm
; TAB=4

BOTPAK	EQU		0x00280000		; bootpack のロード先
DSKCAC	EQU		0x00100000		; ディスクキャッシュの場所
DSKCAC0	EQU		0x00008000		; ディスクキャッシュの場所（読み込み元）

; BOOT_INFO の割り当て
CYLS	EQU		0x0ff0			; ブートセクタで設定される
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; カラーモード管理値
SCRNX	EQU		0x0ff4			; 解像度 X
SCRNY	EQU		0x0ff6			; 解像度 Y
VRAM	EQU		0x0ff8			; グラフィックVRAMの開始番地

		ORG		0xc200			; このプログラムをここから読み込む

; 画面モード設定

		MOV		AL,0x13			; VGA グラフィックス 320x200x8bit
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; 画面モード管理値（後で参照）
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; キーボードのLED状態をBIOSから取得

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

; PIC からの割り込みを受けないようにする
; 	AT 互換機の事情では、PIC の初期化が済んでいないと
; 	CLI 前に割り込みが入るとハングアップする
; 	そのため PIC を全マスクする

		MOV		AL,0xff
		OUT		0x21,AL
		NOP					; OUT 直後のウェイト（安定化のため）
		OUT		0xa1,AL

		CLI					; ここから CPU レベルで割り込み禁止

; CPU が 1MB 超のメモリにアクセスできるよう A20GATE を設定

		CALL	waitkbdout
		MOV		AL,0xd1
		OUT		0x64,AL
		CALL	waitkbdout
		MOV		AL,0xdf			; enable A20
		OUT		0x60,AL
		CALL	waitkbdout

; プロテクトモード移行

[INSTRSET "i486p"]				; 486 以降で使用可能という宣言

		LGDT	[GDTR0]			; グローバルGDTを設定
		MOV		EAX,CR0
		AND		EAX,0x7fffffff	; bit31 を 0（ページング無効）
		OR		EAX,0x00000001	; bit0 を 1（プロテクトモード有効）
		MOV		CR0,EAX
		JMP		pipelineflush
pipelineflush:
		MOV		AX,1*8			; データ/コードセグメント 32bit
		MOV		DS,AX
		MOV		ES,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		SS,AX

; bootpack の展開

		MOV		ESI,bootpack	; コピー元
		MOV		EDI,BOTPAK		; コピー先
		MOV		ECX,512*1024/4
		CALL	memcpy

; すでにディスクデータをバッファ位置へコピー

; まずはブートセクタから

		MOV		ESI,0x7c00		; コピー元
		MOV		EDI,DSKCAC		; コピー先
		MOV		ECX,512/4
		CALL	memcpy

; 残り全て

		MOV		ESI,DSKCAC0+512	; コピー元
		MOV		EDI,DSKCAC+512	; コピー先
		MOV		ECX,0
		MOV		CL,BYTE [CYLS]
		IMUL	ECX,512*18*2/4	; シリンダ全体のバイト数/4
		SUB		ECX,512/4		; IPL の分を差し引く
		CALL	memcpy

; asmhead でやらない方がよい処理はすべて中止。
; 	続きは bootpack で実施

; bootpack の起動

		MOV		EBX,BOTPAK
		MOV		ECX,[EBX+16]
		ADD		ECX,3			; ECX += 3;
		SHR		ECX,2			; ECX /= 4;
		JZ		skip			;]ׂ̂Ȃ
		MOV		ESI,[EBX+20]	;]
		ADD		ESI,EBX
		MOV		EDI,[EBX+12]	;]
		CALL	memcpy
skip:
		MOV		ESP,[EBX+12]	;X^bNl
		JMP		DWORD 2*8:0x0000001b

waitkbdout:
		IN		 AL,0x64
		AND		 AL,0x02
		JNZ		waitkbdout		; AND の結果が 0 でないなら waitkbdout
		RET

memcpy:
		MOV		EAX,[ESI]
		ADD		ESI,4
		MOV		[EDI],EAX
		ADD		EDI,4
		SUB		ECX,1
		JNZ		memcpy			; ループの結果が 0 でないなら memcpy
		RET
; memcpy はアドレスサイズ・プラットフィックスを意識しない実装のため、ストールが起きうる

		ALIGNB	16
GDT0:
		RESB	8				; ヌルセレクタ
		DW		0xffff,0x0000,0x9200,0x00cf	; データ用セグメント 32bit
		DW		0xffff,0x0000,0x9a28,0x0047	; コード用セグメント 32bit（bootpack 用）

		DW		0
GDTR0:
		DW		8*3-1
		DD		GDT0

		ALIGNB	16
bootpack:
