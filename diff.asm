
; ------ DATA ----

 dtextcolor: db 0xF0
; Text strings
txt1: db 'EASY (E)'
txt1length: dw 8
txt1row: dw 6
txt1col: dw 30

txt2: db 'MEDIUM (M)'
txt2length: dw 10
txt2row: dw 11
txt2col: dw 30

txt3: db 'HARD (H)'
txt3length: dw 8
txt3row: dw 16
txt3col: dw 30



; White box (menu background) data
dboxchar: db 0x20          ; Space character
dboxcolor: db 0xFB         ; White on Cyan
dboxstartcol: dw 25        ; Box starting column
dboxstartrow: dw 4         ; Box starting row
dboxwidth: dw 30           ; Box width (30 columns)
dboxheight: dw 19          ; Box height (19 rows)

; Border data
dborderchar: db 0x20       ; Space character
dbordercolor: db 0x7B      ; Light Grey on Cyan
dborderleftcol: dw 24      ; Left border column
dborderupcol: dw 24        ; Top border column
dborderuprow: dw 3         ; Top border row
dborderrightcol: dw 55     ; Right border column
dborderdownrow: dw 22      ; Bottom border row
dbordertopwidth: dw 32     ; Top/bottom border width
dbordersideheight: dw 19   ; Left/right border height

; --- BALLOON 1 DATA (Left balloon) ---
bl1col: dw 9              ; Balloon left 1 base column
bl1row: dw 9              ; Balloon left 1 base row
bl1w1len: dw 5            ; Balloon width 1
bl1w2len: dw 7            ; Balloon width 2
bl1w3len: dw 3            ; Balloon width 3
bl1threadlen: dw 2        ; Thread length
bl1char: db 0x20          ; Balloon character (Space)
bl1color: db 0xDD         ; Balloon color (Light Magenta)
bl1threadcol: dw 11       ; Thread column
bl1threadrow: dw 15       ; Thread row

; --- BALLOON 2 DATA (Right balloon) ---
bl2col: dw 65             ; Balloon right base column
bl2row: dw 9              ; Balloon right base row
bl2char: db 0x20          ; Balloon character (Space)
bl2color: db 0x99         ; Balloon color (Light Blue)
bl2threadcol: dw 67       ; Thread column
bl2threadrow: dw 15       ; Thread row

; ; Thread attributes (shared)
; threadchar: db 0x7C       ; Thread character ('|')
; threadcolor: db 0x77      ; Thread color (Light Grey on Cyan)

; ;---------  CLOUD-------------
; cloudchar: db 0x20    
; cloudcolor: db 0xFF       ; White on Cyan 

; ; Cloud 1 (top left)
; cloud1col: dw 3
; cloud1row: dw 3

; ; Cloud 2 (top right)
; cloud2col: dw 58
; cloud2row: dw 1

; ; Cloud 3 (middle left)
; cloud3col: dw 3
; cloud3row: dw 16

; ; Cloud 4 (middle right)
; cloud4col: dw 69
; cloud4row: dw 20

; ;subroutines
; ;-------- DRAW CLOUD -----
; draw_clouds:
    ; push ax
    ; push bx
    ; push cx
    
  
    ; mov bl, [cloudchar]
    ; mov bh, [cloudcolor]
    
    ; ;            CLOUD 1 
   ; ; Row 1 , top
    ; mov ax, [cloud1col]
    ; add ax, 4          
    ; push ax
    ; mov ax, [cloud1row]
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 6        
    ; call print
    
    ; ; Row 2 , upper middle 
    ; mov ax, [cloud1col]
    ; add ax, 2         
    ; push ax
    ; mov ax, [cloud1row]
    ; add ax, 1           ; Row + 1
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 10          ;Length 10
    ; call print
    
    ; ; Row 3 (middle )
    ; mov ax, [cloud1col] 
    ; push ax             
    ; mov ax, [cloud1row]
    ; add ax, 2        
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 14       
    ; call print
    
    ; ; Row 4 
    ; mov ax, [cloud1col]
    ; add ax, 3        
    ; push ax
    ; mov ax, [cloud1row]
    ; add ax, 3         
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 8          
    ; call print
    
    ; ;CLOUD 2
	
	    ; mov ax, [cloud2col]
    ; add ax, 5
    ; push ax
    ; mov ax, [cloud2row]
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 7
    ; call print
    
    ; ; Row 2
    ; mov ax, [cloud2col]
    ; add ax, 2
    ; push ax
    ; mov ax, [cloud2row]
    ; add ax, 1
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 13
    ; call print
    
    ; ; Row 3
    ; mov ax, [cloud2col]
    ; push ax
    ; mov ax, [cloud2row]
    ; add ax, 2
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 17
    ; call print
    
    ; ; Row 4
    ; mov ax, [cloud2col]
    ; add ax, 4
    ; push ax
    ; mov ax, [cloud2row]
    ; add ax, 3
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 9
    ; call print
    
    ; ; CLOUD 3
    ; ; Row 1
    ; mov ax, [cloud3col]
    ; add ax, 2
    ; push ax
    ; mov ax, [cloud3row]
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 3
    ; call print
    
    ; ; Row 2
    ; mov ax, [cloud3col]
    ; push ax
    ; mov ax, [cloud3row]
    ; add ax, 1
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 7
    ; call print
    
    ; ; Row 3
    ; mov ax, [cloud3col]
    ; add ax, 1
    ; push ax
    ; mov ax, [cloud3row]
    ; add ax, 2
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 5
    ; call print
    
    ; ; CLOUD 4
    ; ; Row 1
    ; mov ax, [cloud4col]
    ; add ax, 2
    ; push ax
    ; mov ax, [cloud4row]
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 5
    ; call print
    
    ; ; Row 2
    ; mov ax, [cloud4col]
    ; push ax
    ; mov ax, [cloud4row]
    ; add ax, 1
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 9
    ; call print
    
    ; ; Row 3
    ; mov ax, [cloud4col]
    ; add ax, 2
    ; push ax
    ; mov ax, [cloud4row]
    ; add ax, 2
    ; push ax
    ; call position
    ; mov ax, bx
    ; mov cx, 5
    ; call print
    
    ; pop cx
    ; pop bx
    ; pop ax
    ; ret


; clrscr:
    ; mov ax, 0xb800
    ; mov es, ax
    ; mov di, 0
    ; mov al, ' '
    ; mov ah, 0x07
; clearing:
    ; mov word[es:di], ax
    ; add di, 2
    ; cmp di, 4000
    ; jne clearing
    ; ret
    
; position:
    ; push bp
    ; mov bp, sp
    ; push ax
    
    ; mov ax, [videomembase]
    ; mov es, ax              
    ; mov al, [screencols]
    ; mul byte [bp+4]
    ; add ax, [bp+6]       
    ; shl ax, 1             
    ; mov si, ax    
    
    ; pop ax
    ; pop bp
    ; ret 4

; balloon:
    ; push cx
; printballoon:
    ; mov [es:di], ax
    ; add di,2
    ; loop printballoon
    ; pop cx
    ; ret

; thread:
    ; push cx            
; threadloop:
    ; mov [es:di], ax    
    ; add di, 160     
    ; loop threadloop
    ; pop cx
    ; ret

; print:
    ; push bp
    ; mov bp,sp
    ; push ax
    ; push di
    ; push es
    ; mov di,si
    ; call balloon 
    ; pop es
    ; pop di
    ; pop ax
    ; pop bp
    ; ret

dprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [videomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, [dtextcolor]

dnextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop dnextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

; rectangle:
    ; push cx 
; rec:
    ; mov [es:di], ax
    ; add di,2
    ; loop rec
    ; pop cx
    ; ret

; printrec:
    ; push bp
    ; mov bp,sp
    ; push ax
    ; push di
    ; push es
    ; mov di,si
    ; call rectangle 
    ; pop es
    ; pop di
    ; pop ax
    ; pop bp
    ; ret

; vertline:
    ; push cx 
; verticalline:
    ; mov [es:di], ax
    ; add di,160
    ; loop verticalline
    ; pop cx
    ; ret

; printvert:
    ; push bp
    ; mov bp,sp
    ; push ax
    ; push di
    ; push es
    ; mov di,si
    ; call vertline 
    ; pop es
    ; pop di
    ; pop ax
    ; pop bp
    ; ret

; fillbackground:
    ; mov ax, [videomembase]
    ; mov es, ax
    ; mov di, 0          
    ; mov cx, [screensize]
    ; mov al, [spacechar]      
    ; mov ah, [bgcolorbyte]
; fillloop:
    ; mov [es:di], ax
    ; add di, 2   
    ; loop fillloop
    ; ret 

draw_difficulty_screen:
    ; ; Disable blinking
    ; mov ax, 1003h
    ; mov bl, [cursoroff]
    ; int 10h
    call clrscr
    call fillbackground    
    call draw_clouds
    ; Load box color into BX
    mov bl, [dboxchar]
    mov bh, [dboxcolor]
    
    ; Draw white box (menu background) - 19 rows
    mov dx, [dboxstartrow]    ; Start at row 4
    mov cx, [dboxheight]      ; 19 rows total
    
ddrawboxloop:
    mov ax, [dboxstartcol]
    push ax
    push dx
    call position
    mov ax, bx
    push cx
    mov cx, [dboxwidth]
    call printrec
    pop cx
    inc dx
    loop ddrawboxloop
    
; Load border color into BX
    mov bl, [dborderchar]
    mov bh, [dbordercolor]
    
    ; Border left
    mov ax, [dborderleftcol]
    push ax
    mov ax, [dboxstartrow]
    push ax
    call position
    mov ax, bx
    mov cx, [dbordersideheight]
    call printvert
    
    ; Border top
    mov ax, [dborderupcol]
    push ax
    mov ax, [dborderuprow]
    push ax
    call position
    mov ax, bx
    mov cx, [dbordertopwidth]
    call printrec
    
    ; Border right
    mov ax, [dborderrightcol]
    push ax
    mov ax, [dboxstartrow]
    push ax
    call position
    mov ax, bx
    mov cx, [dbordersideheight]
    call printvert
    
    ; Border bottom
    mov ax, [dborderupcol]
    push ax
    mov ax, [dborderdownrow]
    push ax
    call position
    mov ax, bx
    mov cx, [dbordertopwidth]
    call printrec
    
    ; --- BALLOON 1 (Left) ---
    mov bl, [bl1char]
    mov bh, [bl1color]
    
    ; Row 1
    mov ax, [bl1col]
    push ax
    mov ax, [bl1row]
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w1len]
    call print
    
    ; Row 2
    mov ax, [bl1col]
    sub ax, 1
    push ax
    mov ax, [bl1row]
    add ax, 1
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w2len]
    call print
    
    ; Row 3
    mov ax, [bl1col]
    sub ax, 1
    push ax
    mov ax, [bl1row]
    add ax, 2
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w2len]
    call print
    
    ; Row 4
    mov ax, [bl1col]
    sub ax, 1
    push ax
    mov ax, [bl1row]
    add ax, 3
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w2len]
    call print
    
    ; Row 5
    mov ax, [bl1col]
    push ax
    mov ax, [bl1row]
    add ax, 4
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w1len]
    call print
    
    ; Row 6
    mov ax, [bl1col]
    add ax, 1
    push ax
    mov ax, [bl1row]
    add ax, 5
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w3len]
    call print
    
    ; Thread
    mov bl, [threadchar]
    mov bh, [threadcolor]
    
    mov ax, [bl1threadcol]
    push ax
    mov ax, [bl1threadrow]
    push ax
    call position 
    mov di, si    
    mov ax, bx
    mov cx, [bl1threadlen]
    call thread
    
    ; --- BALLOON 2 (Right) ---
    mov bl, [bl2char]
    mov bh, [bl2color]
    
    ; Row 1
    mov ax, [bl2col]
    push ax
    mov ax, [bl2row]
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w1len]
    call print
    
    ; Row 2
    mov ax, [bl2col]
    sub ax, 1
    push ax
    mov ax, [bl2row]
    add ax, 1
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w2len]
    call print
    
    ; Row 3
    mov ax, [bl2col]
    sub ax, 1
    push ax
    mov ax, [bl2row]
    add ax, 2
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w2len]
    call print
    
    ; Row 4
    mov ax, [bl2col]
    sub ax, 1
    push ax
    mov ax, [bl2row]
    add ax, 3
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w2len]
    call print
    
    ; Row 5
    mov ax, [bl2col]
    push ax
    mov ax, [bl2row]
    add ax, 4
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w1len]
    call print
    
    ; Row 6
    mov ax, [bl2col]
    add ax, 1
    push ax
    mov ax, [bl2row]
    add ax, 5
    push ax
    call position          
    mov ax, bx
    mov cx, [bl1w3len]
    call print
    
    ;thread
    mov bl, [threadchar]
    mov bh, [threadcolor]
    
    mov ax, [bl2threadcol]
    push ax
    mov ax, [bl2threadrow]
    push ax
    call position 
    mov di, si    
    mov ax, bx
    mov cx, [bl1threadlen]
    call thread
    
    ; --- TEXT 1
    mov ax, [txt1col]
    push ax
    mov ax, [txt1row]
    push ax
    call position
    
    push si
    mov ax, txt1
    push ax
    push word[txt1length]
    call dprinttext
    
    ; --- TEXT 2
    mov ax, [txt2col]
    push ax
    mov ax, [txt2row]
    push ax
    call position
    
    push si
    mov ax, txt2
    push ax
    push word[txt2length]
    call dprinttext
    
    ; --- TEXT 3
    mov ax, [txt3col]
    push ax
    mov ax, [txt3row]
    push ax
    call position
    
    push si
    mov ax, txt3
    push ax
    push word[txt3length]
    call dprinttext
    
	
	
  
    readkey_diff: ;reading e  key press 
    mov ah, 0
    int 16h
	
    cmp al, 'e'
    je go_easy
	cmp al,'m'
	je go_medium
	
	cmp al,'h'
	je go_hard
    jmp readkey_diff
	go_easy:
    mov byte [current_screen], 4
	; call clrscr
	; call fillbackground

    call draw_easy_screen
	
	go_medium:
    mov byte [current_screen], 5
    call draw_gameplay_screen
	
	
		
	go_hard:
    mov byte [current_screen], 6
    call draw_hard_screen
	
	  ; jmp eballoon_loop 

; ego_easy:

    ; call draw_easy_screen    ; or the label used in easy.asm
    ; ret

	
    mov ax, 0x4C00
    int 21h