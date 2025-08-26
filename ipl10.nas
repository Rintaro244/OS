<<<<<<< HEAD
; haribote-ipl
; TAB=4

CYLS	EQU		10				; ‚Ç‚±‚Ü‚Å“Ç‚Ýž‚Þ‚©

		ORG		0x7c00			; ‚±‚ÌƒvƒƒOƒ‰ƒ€‚ª‚Ç‚±‚É“Ç‚Ýž‚Ü‚ê‚é‚Ì‚©

; ˆÈ‰º‚Í•W€“I‚ÈFAT12ƒtƒH[ƒ}ƒbƒgƒtƒƒbƒs[ƒfƒBƒXƒN‚Ì‚½‚ß‚Ì‹Lq

		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; ƒu[ƒgƒZƒNƒ^‚Ì–¼‘O‚ðŽ©—R‚É‘‚¢‚Ä‚æ‚¢i8ƒoƒCƒgj
		DW		512				; 1ƒZƒNƒ^‚Ì‘å‚«‚³i512‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DB		1				; ƒNƒ‰ƒXƒ^‚Ì‘å‚«‚³i1ƒZƒNƒ^‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DW		1				; FAT‚ª‚Ç‚±‚©‚çŽn‚Ü‚é‚©i•’Ê‚Í1ƒZƒNƒ^–Ú‚©‚ç‚É‚·‚éj
		DB		2				; FAT‚ÌŒÂ”i2‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DW		224				; ƒ‹[ƒgƒfƒBƒŒƒNƒgƒŠ—Ìˆæ‚Ì‘å‚«‚³i•’Ê‚Í224ƒGƒ“ƒgƒŠ‚É‚·‚éj
		DW		2880			; ‚±‚Ìƒhƒ‰ƒCƒu‚Ì‘å‚«‚³i2880ƒZƒNƒ^‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DB		0xf0			; ƒƒfƒBƒA‚Ìƒ^ƒCƒvi0xf0‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DW		9				; FAT—Ìˆæ‚Ì’·‚³i9ƒZƒNƒ^‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DW		18				; 1ƒgƒ‰ƒbƒN‚É‚¢‚­‚Â‚ÌƒZƒNƒ^‚ª‚ ‚é‚©i18‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DW		2				; ƒwƒbƒh‚Ì”i2‚É‚µ‚È‚¯‚ê‚Î‚¢‚¯‚È‚¢j
		DD		0				; ƒp[ƒeƒBƒVƒ‡ƒ“‚ðŽg‚Á‚Ä‚È‚¢‚Ì‚Å‚±‚±‚Í•K‚¸0
		DD		2880			; ‚±‚Ìƒhƒ‰ƒCƒu‘å‚«‚³‚ð‚à‚¤ˆê“x‘‚­
		DB		0,0,0x29		; ‚æ‚­‚í‚©‚ç‚È‚¢‚¯‚Ç‚±‚Ì’l‚É‚µ‚Ä‚¨‚­‚Æ‚¢‚¢‚ç‚µ‚¢
		DD		0xffffffff		; ‚½‚Ô‚ñƒ{ƒŠƒ…[ƒ€ƒVƒŠƒAƒ‹”Ô†
		DB		"HARIBOTEOS "	; ƒfƒBƒXƒN‚Ì–¼‘Oi11ƒoƒCƒgj
		DB		"FAT12   "		; ƒtƒH[ƒ}ƒbƒg‚Ì–¼‘Oi8ƒoƒCƒgj
		RESB	18				; ‚Æ‚è‚ ‚¦‚¸18ƒoƒCƒg‚ ‚¯‚Ä‚¨‚­

; ƒvƒƒOƒ‰ƒ€–{‘Ì

entry:
		MOV		AX,0			; ƒŒƒWƒXƒ^‰Šú‰»
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; ƒfƒBƒXƒN‚ð“Ç‚Þ

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; ƒVƒŠƒ“ƒ_0
		MOV		DH,0			; ƒwƒbƒh0
		MOV		CL,2			; ƒZƒNƒ^2
readloop:
		MOV		SI,0			; Ž¸”s‰ñ”‚ð”‚¦‚éƒŒƒWƒXƒ^
retry:
		MOV		AH,0x02			; AH=0x02 : ƒfƒBƒXƒN“Ç‚Ýž‚Ý
		MOV		AL,1			; 1ƒZƒNƒ^
		MOV		BX,0
		MOV		DL,0x00			; Aƒhƒ‰ƒCƒu
		INT		0x13			; ƒfƒBƒXƒNBIOSŒÄ‚Ño‚µ
		JNC		next			; ƒGƒ‰[‚ª‚¨‚«‚È‚¯‚ê‚Înext‚Ö
		ADD		SI,1			; SI‚É1‚ð‘«‚·
		CMP		SI,5			; SI‚Æ5‚ð”äŠr
		JAE		error			; SI >= 5 ‚¾‚Á‚½‚çerror‚Ö
		MOV		AH,0x00
		MOV		DL,0x00			; Aƒhƒ‰ƒCƒu
		INT		0x13			; ƒhƒ‰ƒCƒu‚ÌƒŠƒZƒbƒg
		JMP		retry
next:
		MOV		AX,ES			; ƒAƒhƒŒƒX‚ð0x200i‚ß‚é
		ADD		AX,0x0020
		MOV		ES,AX			; ADD ES,0x020 ‚Æ‚¢‚¤–½—ß‚ª‚È‚¢‚Ì‚Å‚±‚¤‚µ‚Ä‚¢‚é
		ADD		CL,1			; CL‚É1‚ð‘«‚·
		CMP		CL,18			; CL‚Æ18‚ð”äŠr
		JBE		readloop		; CL <= 18 ‚¾‚Á‚½‚çreadloop‚Ö
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readloop		; DH < 2 ‚¾‚Á‚½‚çreadloop‚Ö
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop		; CH < CYLS ‚¾‚Á‚½‚çreadloop‚Ö

; “Ç‚ÝI‚í‚Á‚½‚Ì‚Åharibote.sys‚ðŽÀs‚¾I

		MOV		[0x0ff0],CH		; IPL‚ª‚Ç‚±‚Ü‚Å“Ç‚ñ‚¾‚Ì‚©‚ðƒƒ‚
		JMP		0xc200

error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI‚É1‚ð‘«‚·
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; ˆê•¶Žš•\Ž¦ƒtƒ@ƒ“ƒNƒVƒ‡ƒ“
		MOV		BX,15			; ƒJƒ‰[ƒR[ƒh
		INT		0x10			; ƒrƒfƒIBIOSŒÄ‚Ño‚µ
		JMP		putloop
fin:
		HLT						; ‰½‚©‚ ‚é‚Ü‚ÅCPU‚ð’âŽ~‚³‚¹‚é
		JMP		fin				; –³ŒÀƒ‹[ƒv
msg:
		DB		0x0a, 0x0a		; ‰üs‚ð2‚Â
		DB		"load error"
		DB		0x0a			; ‰üs
		DB		0

		RESB	0x7dfe-$		; 0x7dfe‚Ü‚Å‚ð0x00‚Å–„‚ß‚é–½—ß

		DB		0x55, 0xaa
=======
ï»¿; haribote-ipl
; TAB=4

CYLS	EQU		10				; ã©ã“ã¾ã§èª­ã¿è¾¼ã‚€ã‹

		ORG		0x7c00			; ã“ã®ãƒ—ãƒ­ã‚°ãƒ©ãƒ ã‚’ã“ã“ã‹ã‚‰èª­ã¿è¾¼ã‚€

; ä»¥ä¸‹ã¯æ¨™æº–ã® FAT12 ãƒ•ã‚©ãƒ¼ãƒžãƒƒãƒˆãƒ‡ã‚£ã‚¹ã‚¯ã®ãŸã‚ã®è¨˜è¿°

		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; ãƒ–ãƒ¼ãƒˆã‚»ã‚¯ã‚¿ã®åå‰ï¼ˆ8ãƒã‚¤ãƒˆï¼‰
		DW		512				; 1 ã‚»ã‚¯ã‚¿ã®å¤§ãã•ï¼ˆ512å›ºå®šï¼‰
		DB		1				; ã‚¯ãƒ©ã‚¹ã‚¿ã®å¤§ãã•ï¼ˆ1 ã‚»ã‚¯ã‚¿ï¼‰
		DW		1				; FATãŒã©ã“ã‹ã‚‰å§‹ã¾ã‚‹ã‹ï¼ˆé€šå¸¸1ã‚»ã‚¯ã‚¿ç›®ï¼‰
		DB		2				; FATã®å€‹æ•°ï¼ˆ2ï¼‰
		DW		224				; ãƒ«ãƒ¼ãƒˆãƒ‡ã‚£ãƒ¬ã‚¯ãƒˆãƒªã®é …ç›®æ•°ï¼ˆé€šå¸¸224ã‚¨ãƒ³ãƒˆãƒªï¼‰
		DW		2880			; ã“ã®ãƒ‰ãƒ©ã‚¤ãƒ–ã®ã‚µã‚¤ã‚ºï¼ˆ2880ã‚»ã‚¯ã‚¿ï¼‰
		DB		0xf0			; ãƒ¡ãƒ‡ã‚£ã‚¢ã®ã‚¿ã‚¤ãƒ—ï¼ˆ0xf0ï¼‰
		DW		9				; FATã®é•·ã•ï¼ˆ9ã‚»ã‚¯ã‚¿ï¼‰
		DW		18				; 1ãƒˆãƒ©ãƒƒã‚¯ã«å«ã¾ã‚Œã‚‹ã‚»ã‚¯ã‚¿æ•°ï¼ˆ18ï¼‰
		DW		2				; ãƒ˜ãƒƒãƒ‰ã®æ•°ï¼ˆ2ï¼‰
		DD		0				; ãƒ‘ãƒ¼ãƒ†ã‚£ã‚·ãƒ§ãƒ³ã‚’ä½¿ã£ã¦ã„ãªã„ã®ã§é€šå¸¸ã¯0
		DD		2880			; ã“ã®ãƒ‰ãƒ©ã‚¤ãƒ–å®¹é‡ã®å†æŽ²
		DB		0,0,0x29		; æ„å‘³ã¯æ°—ã«ã—ãªã„ã§ã‚ˆã„å€¤ã«ã—ã¦ãŠã
		DD		0xffffffff		; é©å½“ãªãƒœãƒªãƒ¥ãƒ¼ãƒ ã‚·ãƒªã‚¢ãƒ«ç•ªå·
		DB		"HARIBOTEOS "	; ãƒ‡ã‚£ã‚¹ã‚¯ã®åå‰ï¼ˆ11ãƒã‚¤ãƒˆï¼‰
		DB		"FAT12   "		; ãƒ•ã‚©ãƒ¼ãƒžãƒƒãƒˆã®åå‰ï¼ˆ8ãƒã‚¤ãƒˆï¼‰
		RESB	18				; ã¨ã‚Šã‚ãˆãš18ãƒã‚¤ãƒˆåŸ‹ã‚ã¦ãŠã

; ãƒ—ãƒ­ã‚°ãƒ©ãƒ ã®æœ¬ä½“

entry:
		MOV		AX,0			; ãƒ¬ã‚¸ã‚¹ã‚¿åˆæœŸåŒ–
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; ãƒ‡ã‚£ã‚¹ã‚¯èª­ã¿

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; ã‚·ãƒªãƒ³ãƒ€0
		MOV		DH,0			; ãƒ˜ãƒƒãƒ‰0
		MOV		CL,2			; ã‚»ã‚¯ã‚¿2
readloop:
		MOV		SI,0			; è©¦è¡Œå›žæ•°ã‚«ã‚¦ãƒ³ã‚¿
retry:
		MOV		AH,0x02			; AH=0x02 : ãƒ‡ã‚£ã‚¹ã‚¯èª­ã¿è¾¼ã¿
		MOV		AL,1			; 1ã‚»ã‚¯ã‚¿
		MOV		BX,0
		MOV		DL,0x00			; Aãƒ‰ãƒ©ã‚¤ãƒ–
		INT		0x13			; ãƒ‡ã‚£ã‚¹ã‚¯BIOSå‘¼ã³å‡ºã—
		JNC		next			; ã‚¨ãƒ©ãƒ¼ãŒãªã‘ã‚Œã° next
		ADD		SI,1			; SI ã‚’ 1 åŠ ç®—
		CMP		SI,5			; SI ãŒ 5 æ¯”è¼ƒ
		JAE		error			; SI >= 5 ãªã‚‰ error
		MOV		AH,0x00
		MOV		DL,0x00			; Aãƒ‰ãƒ©ã‚¤ãƒ–
		INT		0x13			; ãƒ‰ãƒ©ã‚¤ãƒ–ã®ãƒªã‚»ãƒƒãƒˆ
		JMP		retry
next:
		MOV		AX,ES			; ã‚¢ãƒ‰ãƒ¬ã‚¹ã«0x200è¶³ã™
		ADD		AX,0x0020
		MOV		ES,AX			; ADD ES,0x020 ã¨åŒã˜ï¼ˆ8086äº’æ›ã®ãŸã‚ï¼‰
		ADD		CL,1			; CL ã‚’ 1 åŠ ç®—
		CMP		CL,18			; CL ã¨ 18 ã‚’æ¯”è¼ƒ
		JBE		readloop		; CL <= 18 ãªã‚‰ readloop
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readloop		; DH < 2 ãªã‚‰ readloop
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop		; CH < CYLS ãªã‚‰ readloop

; èª­ã¿çµ‚ã‚ã£ãŸã‚‰ haribote.sys ã‚’å®Ÿè¡Œï¼

		MOV		[0x0ff0],CH		; IPL ãŒã©ã“ã¾ã§èª­ã‚“ã ã®ã‹ã®è¨˜éŒ²
		JMP		0xc200

error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI ã‚’ 1 åŠ ç®—
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; æ–‡å­—è¡¨ç¤ºãƒ•ã‚¡ãƒ³ã‚¯ã‚·ãƒ§ãƒ³
		MOV		BX,15			; ã‚«ãƒ©ãƒ¼ã‚³ãƒ¼ãƒ‰
		INT		0x10			; ãƒ“ãƒ‡ã‚ªBIOSå‘¼ã³å‡ºã—
		JMP		putloop
fin:
		HLT					; ä»¥å¾Œãšã£ã¨CPUã‚’åœæ­¢
		JMP		fin				; ç„¡é™ãƒ«ãƒ¼ãƒ—
msg:
		DB		0x0a, 0x0a		; æ”¹è¡Œã‚’2å€‹
		DB		"load error"
		DB		0x0a			; æ”¹è¡Œ
		DB		0

		RESB	0x7dfe-$			; 0x7dfe ã¾ã§ 0x00 ã§åŸ‹ã‚ã‚‹

		DB		0x55, 0xaa
>>>>>>> d5fb8cf3348dd802097309dfeeca7a68b3863406
