<<<<<<< HEAD
; haribote-ipl
; TAB=4

CYLS	EQU		10				; �ǂ��܂œǂݍ��ނ�

		ORG		0x7c00			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

; �ȉ��͕W���I��FAT12�t�H�[�}�b�g�t���b�s�[�f�B�X�N�̂��߂̋L�q

		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; �u�[�g�Z�N�^�̖��O�����R�ɏ����Ă悢�i8�o�C�g�j
		DW		512				; 1�Z�N�^�̑傫���i512�ɂ��Ȃ���΂����Ȃ��j
		DB		1				; �N���X�^�̑傫���i1�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		1				; FAT���ǂ�����n�܂邩�i���ʂ�1�Z�N�^�ڂ���ɂ���j
		DB		2				; FAT�̌��i2�ɂ��Ȃ���΂����Ȃ��j
		DW		224				; ���[�g�f�B���N�g���̈�̑傫���i���ʂ�224�G���g���ɂ���j
		DW		2880			; ���̃h���C�u�̑傫���i2880�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DB		0xf0			; ���f�B�A�̃^�C�v�i0xf0�ɂ��Ȃ���΂����Ȃ��j
		DW		9				; FAT�̈�̒����i9�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		18				; 1�g���b�N�ɂ����̃Z�N�^�����邩�i18�ɂ��Ȃ���΂����Ȃ��j
		DW		2				; �w�b�h�̐��i2�ɂ��Ȃ���΂����Ȃ��j
		DD		0				; �p�[�e�B�V�������g���ĂȂ��̂ł����͕K��0
		DD		2880			; ���̃h���C�u�傫����������x����
		DB		0,0,0x29		; �悭�킩��Ȃ����ǂ��̒l�ɂ��Ă����Ƃ����炵��
		DD		0xffffffff		; ���Ԃ�{�����[���V���A���ԍ�
		DB		"HARIBOTEOS "	; �f�B�X�N�̖��O�i11�o�C�g�j
		DB		"FAT12   "		; �t�H�[�}�b�g�̖��O�i8�o�C�g�j
		RESB	18				; �Ƃ肠����18�o�C�g�����Ă���

; �v���O�����{��

entry:
		MOV		AX,0			; ���W�X�^������
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; �f�B�X�N��ǂ�

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; �V�����_0
		MOV		DH,0			; �w�b�h0
		MOV		CL,2			; �Z�N�^2
readloop:
		MOV		SI,0			; ���s�񐔂𐔂��郌�W�X�^
retry:
		MOV		AH,0x02			; AH=0x02 : �f�B�X�N�ǂݍ���
		MOV		AL,1			; 1�Z�N�^
		MOV		BX,0
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �f�B�X�NBIOS�Ăяo��
		JNC		next			; �G���[�������Ȃ����next��
		ADD		SI,1			; SI��1�𑫂�
		CMP		SI,5			; SI��5���r
		JAE		error			; SI >= 5 ��������error��
		MOV		AH,0x00
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �h���C�u�̃��Z�b�g
		JMP		retry
next:
		MOV		AX,ES			; �A�h���X��0x200�i�߂�
		ADD		AX,0x0020
		MOV		ES,AX			; ADD ES,0x020 �Ƃ������߂��Ȃ��̂ł������Ă���
		ADD		CL,1			; CL��1�𑫂�
		CMP		CL,18			; CL��18���r
		JBE		readloop		; CL <= 18 ��������readloop��
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readloop		; DH < 2 ��������readloop��
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop		; CH < CYLS ��������readloop��

; �ǂݏI������̂�haribote.sys�����s���I

		MOV		[0x0ff0],CH		; IPL���ǂ��܂œǂ񂾂̂�������
		JMP		0xc200

error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI��1�𑫂�
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; �ꕶ���\���t�@���N�V����
		MOV		BX,15			; �J���[�R�[�h
		INT		0x10			; �r�f�IBIOS�Ăяo��
		JMP		putloop
fin:
		HLT						; ��������܂�CPU���~������
		JMP		fin				; �������[�v
msg:
		DB		0x0a, 0x0a		; ���s��2��
		DB		"load error"
		DB		0x0a			; ���s
		DB		0

		RESB	0x7dfe-$		; 0x7dfe�܂ł�0x00�Ŗ��߂閽��

		DB		0x55, 0xaa
=======
﻿; haribote-ipl
; TAB=4

CYLS	EQU		10				; どこまで読み込むか

		ORG		0x7c00			; このプログラムをここから読み込む

; 以下は標準の FAT12 フォーマットディスクのための記述

		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; ブートセクタの名前（8バイト）
		DW		512				; 1 セクタの大きさ（512固定）
		DB		1				; クラスタの大きさ（1 セクタ）
		DW		1				; FATがどこから始まるか（通常1セクタ目）
		DB		2				; FATの個数（2）
		DW		224				; ルートディレクトリの項目数（通常224エントリ）
		DW		2880			; このドライブのサイズ（2880セクタ）
		DB		0xf0			; メディアのタイプ（0xf0）
		DW		9				; FATの長さ（9セクタ）
		DW		18				; 1トラックに含まれるセクタ数（18）
		DW		2				; ヘッドの数（2）
		DD		0				; パーティションを使っていないので通常は0
		DD		2880			; このドライブ容量の再掲
		DB		0,0,0x29		; 意味は気にしないでよい値にしておく
		DD		0xffffffff		; 適当なボリュームシリアル番号
		DB		"HARIBOTEOS "	; ディスクの名前（11バイト）
		DB		"FAT12   "		; フォーマットの名前（8バイト）
		RESB	18				; とりあえず18バイト埋めておく

; プログラムの本体

entry:
		MOV		AX,0			; レジスタ初期化
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; ディスク読み

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; シリンダ0
		MOV		DH,0			; ヘッド0
		MOV		CL,2			; セクタ2
readloop:
		MOV		SI,0			; 試行回数カウンタ
retry:
		MOV		AH,0x02			; AH=0x02 : ディスク読み込み
		MOV		AL,1			; 1セクタ
		MOV		BX,0
		MOV		DL,0x00			; Aドライブ
		INT		0x13			; ディスクBIOS呼び出し
		JNC		next			; エラーがなければ next
		ADD		SI,1			; SI を 1 加算
		CMP		SI,5			; SI が 5 比較
		JAE		error			; SI >= 5 なら error
		MOV		AH,0x00
		MOV		DL,0x00			; Aドライブ
		INT		0x13			; ドライブのリセット
		JMP		retry
next:
		MOV		AX,ES			; アドレスに0x200足す
		ADD		AX,0x0020
		MOV		ES,AX			; ADD ES,0x020 と同じ（8086互換のため）
		ADD		CL,1			; CL を 1 加算
		CMP		CL,18			; CL と 18 を比較
		JBE		readloop		; CL <= 18 なら readloop
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readloop		; DH < 2 なら readloop
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop		; CH < CYLS なら readloop

; 読み終わったら haribote.sys を実行！

		MOV		[0x0ff0],CH		; IPL がどこまで読んだのかの記録
		JMP		0xc200

error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI を 1 加算
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 文字表示ファンクション
		MOV		BX,15			; カラーコード
		INT		0x10			; ビデオBIOS呼び出し
		JMP		putloop
fin:
		HLT					; 以後ずっとCPUを停止
		JMP		fin				; 無限ループ
msg:
		DB		0x0a, 0x0a		; 改行を2個
		DB		"load error"
		DB		0x0a			; 改行
		DB		0

		RESB	0x7dfe-$			; 0x7dfe まで 0x00 で埋める

		DB		0x55, 0xaa
>>>>>>> d5fb8cf3348dd802097309dfeeca7a68b3863406
