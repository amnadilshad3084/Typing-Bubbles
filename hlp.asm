

; ------ DATA ----

; bgcolorbyte: db 0xBB      ; bgr color attribute (high byte)
; videomembase: dw 0xB800   ; base address for video memory, b800h
; screencols: db 80         ; total cols = 80
; screensize: dw 4000       ; total size 4000
; spacechar: db 0x20        ; space ascii
; cursoroff: db 0           ; value to disable the blinking cursor, 0

htextcolor: db 0xF0
; Text strings

play: db '    HOW TO PLAY : '
playlength: dw 18
playrow: dw 5
playcol: dw 32

htime:  db '-> You have a total time of 2 minutes'
htimelength: dw 37
htimerow: dw 7
htimecol: dw 22

text2: db '-> Balloons with letters will move up screen'
text2length: dw 44
text2row: dw 9
text2col: dw 22

text3: db '-> Type the letter shown on each balloon'
text3length: dw 40
text3row: dw 11
text3col: dw 22

text4: db '-> Correct letter: +10 points!'
text4length: dw 30
text4row: dw 13
text4col: dw 22

text6:     db '-> DIFFICULTY LEVELS:'
text6length: dw 21
text6row: dw 15
text6col: dw 22

text7:     db '- Easy:   Slow balloons'
text7length: dw 23
text7row: dw 16
text7col: dw 22

text8:     db '- Medium: Normal speed'
text8length: dw 22
text8row: dw 17
text8col: dw 22

text9:     db '- Hard:   Fast balloons'
text9length: dw 23
text9row: dw 18
text9col: dw 22

text10:     db '-> Press the letters next to each option'
text10length: dw 40
text10row: dw 20
text10col: dw 22

back: db '     Press B to go back'
backlength: dw 23
backrow: dw 21
backcol: dw 44
; Text color
textcolor: db 0xF0        ; White on Black

; White box (menu background) data
boxchar: db 0x20          ; Space character
boxcolor: db 0xFB         ; White on Cyan
boxstartcol: dw 18        ; Box starting column
boxstartrow: dw 4         ; Box starting row
boxwidth: dw 50          ; Box width (30 columns)
boxheight: dw 19          ; Box height (19 rows)

; Border data
borderchar: db 0x20       ; Space character
bordercolor: db 0x7B      ; Light Grey on Cyan
borderleftcol: dw 18      ; Left border column
borderupcol: dw 18       ; Top border column
borderuprow: dw 3         ; Top border row
borderrightcol: dw 68     ; Right border column
borderdownrow: dw 22      ; Bottom border row
bordertopwidth: dw 51    ; Top/bottom border width
bordersideheight: dw 19   ; Left/right border height

; --- BALLOON 1 DATA (Left)
hbl1col: dw 9 ; Balloon left 1 base column
hbl1row: dw 9 ; Balloon left 1 base row
hbl1w1len: dw 5 ; Balloon width 1
hbl1w2len: dw 7 ; Balloon width 2
hbl1w3len: dw 3 ; Balloon width 3
hbl1threadlen: dw 2 ; Thread length
hbl1char: db 0x20 ; Balloon character (Space)
hbl1color: db 0xDD ; Balloon color (Light Magenta)
hbl1threadcol: dw 11 ; Thread column
hbl1threadrow: dw 15 ; Thread row

; --- BALLOON 2 DATA, right
hbl2col: dw 72 ; Balloon right base column
hbl2row: dw 9 ; Balloon right base row
hbl2char: db 0x20 ; Balloon character (Space)
hbl2color: db 0x99 ; Balloon color (Light Blue)
hbl2threadcol: dw 74 ; Thread column
hbl2threadrow: dw 15 ; Thread row

; Thread attributes (shared)
hthreadchar: db 0x7C ; Thread character ('|')
hthreadcolor: db 0x77 ; Thread color (Light Grey on Cyan)

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

hprinttext:
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
    mov ah, [htextcolor]
	
hnextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop hnextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

rectangle:
    push cx 
rec:
    mov [es:di], ax
    add di,2
    loop rec
    pop cx
    ret

printrec:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call rectangle 
    pop es
    pop di
    pop ax
    pop bp
    ret

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
    ;ret
	
draw_help_screen:
    ; Disable blinking
    ; mov ax, 1003h
    ; mov bl, [cursoroff]
    ; int 10h
	; mov ax,0xBB
	; mov [bgcolorbyte],ax
	;mov ax,0x00
    call clrscr
    call fillbackground
	call draw_clouds
    
    ; Load box color into BX
    mov bl, [boxchar]
    mov bh, [boxcolor]
    
    ; Draw white box (menu background) - 19 rows
    mov dx, [boxstartrow]    ; Start at row 4
    mov cx, [boxheight]      ; 19 rows total
    
drawboxloop:
    mov ax, [boxstartcol]
    push ax
    push dx
    call position
    mov ax, bx
    push cx
    mov cx, [boxwidth]
    call printrec
    pop cx
    inc dx
    loop drawboxloop
    
    ; Load border color into BX
    mov bl, [borderchar]
    mov bh, [bordercolor]
    
    ; Border left
    mov ax, [borderleftcol]
    push ax
    mov ax, [boxstartrow]
    push ax
    call position
    mov ax, bx
    mov cx, [bordersideheight]
    call printvert
    
    ; Border top
    mov ax, [borderupcol]
    push ax
    mov ax, [borderuprow]
    push ax
    call position
    mov ax, bx
    mov cx, [bordertopwidth]
    call printrec
    
    ; Border right
    mov ax, [borderrightcol]
    push ax
    mov ax, [boxstartrow]
    push ax
    call position
    mov ax, bx
    mov cx, [bordersideheight]
    call printvert
    
    ; Border bottom
    mov ax, [borderupcol]
    push ax
    mov ax, [borderdownrow]
    push ax
    call position
    mov ax, bx
    mov cx, [bordertopwidth]
    call printrec

; --- BALLOON 1 (Left) ---
mov bl, [hbl1char]
mov bh, [hbl1color]

; Row 1
mov ax, [hbl1col]
push ax
mov ax, [hbl1row]
push ax
call position          
mov ax, bx
mov cx, [hbl1w1len]
call print

; Row 2
mov ax, [hbl1col]
sub ax, 1
push ax
mov ax, [hbl1row]
add ax, 1
push ax
call position          
mov ax, bx
mov cx, [hbl1w2len]
call print

; Row 3
mov ax, [hbl1col]
sub ax, 1
push ax
mov ax, [hbl1row]
add ax, 2
push ax
call position          
mov ax, bx
mov cx, [hbl1w2len]
call print

; Row 4
mov ax, [hbl1col]
sub ax, 1
push ax
mov ax, [hbl1row]
add ax, 3
push ax
call position          
mov ax, bx
mov cx, [hbl1w2len]
call print

; Row 5
mov ax, [hbl1col]
push ax
mov ax, [hbl1row]
add ax, 4
push ax
call position          
mov ax, bx
mov cx, [hbl1w1len]
call print

; Row 6
mov ax, [hbl1col]
add ax, 1
push ax
mov ax, [hbl1row]
add ax, 5
push ax
call position          
mov ax, bx
mov cx, [hbl1w3len]
call print

; Thread
mov bl, [hthreadchar]
mov bh, [hthreadcolor]

mov ax, [hbl1threadcol]
push ax
mov ax, [hbl1threadrow]
push ax
call position 
mov di, si    
mov ax, bx
mov cx, [hbl1threadlen]
call thread

; --- BALLOON 2 (Right) ---
mov bl, [hbl2char]
mov bh, [hbl2color]

; Row 1
mov ax, [hbl2col]
push ax
mov ax, [hbl2row]
push ax
call position          
mov ax, bx
mov cx, [hbl1w1len]
call print

; Row 2
mov ax, [hbl2col]
sub ax, 1
push ax
mov ax, [hbl2row]
add ax, 1
push ax
call position          
mov ax, bx
mov cx, [hbl1w2len]
call print

; Row 3
mov ax, [hbl2col]
sub ax, 1
push ax
mov ax, [hbl2row]
add ax, 2
push ax
call position          
mov ax, bx
mov cx, [hbl1w2len]
call print

; Row 4
mov ax, [hbl2col]
sub ax, 1
push ax
mov ax, [hbl2row]
add ax, 3
push ax
call position          
mov ax, bx
mov cx, [hbl1w2len]
call print

; Row 5
mov ax, [hbl2col]
push ax
mov ax, [hbl2row]
add ax, 4
push ax
call position          
mov ax, bx
mov cx, [hbl1w1len]
call print

; Row 6
mov ax, [hbl2col]
add ax, 1
push ax
mov ax, [hbl2row]
add ax, 5
push ax
call position          
mov ax, bx
mov cx, [hbl1w3len]
call print

;thread
mov bl, [hthreadchar]
mov bh, [hthreadcolor]

mov ax, [hbl2threadcol]
push ax
mov ax, [hbl2threadrow]
push ax
call position 
mov di, si    
mov ax, bx
mov cx, [hbl1threadlen]
call thread
	
    ; --- TEXT: howto play
    mov ax, [playcol]
    push ax
    mov ax, [playrow]
    push ax
    call position
    
    push si
    mov ax, play
    push ax
    push word[playlength]
    call hprinttext
    ;time Text
	   mov ax, [htimecol]
    push ax
    mov ax, [htimerow]
    push ax
    call position
    
    push si
    mov ax, htime
    push ax
    push word[htimelength]
    call hprinttext
	
    ; --- TEXT 2
    mov ax, [text2col]
    push ax
    mov ax, [text2row]
    push ax
    call position
    
    push si
    mov ax, text2
    push ax
    push word[text2length]
    call hprinttext
    
    ; --- TEXT 3
    mov ax, [text3col]
    push ax
    mov ax, [text3row]
    push ax
    call position
    
    push si
    mov ax, text3
    push ax
    push word[text3length]
    call hprinttext
    
    ; --- TEXT 4
    mov ax, [text4col]
    push ax
    mov ax, [text4row]
    push ax
    call position
    
    push si
    mov ax, text4
    push ax
    push word[text4length]
    call hprinttext
	
	;back
	   mov ax, [backcol]
    push ax
    mov ax, [backrow]
    push ax
    call position
    
    push si
    mov ax, back
    push ax
    push word[backlength]
    call hprinttext
	;difficulty
	mov ax, [text6col]
    push ax
    mov ax, [text6row]
    push ax
    call position
    
    push si
    mov ax, text6
    push ax
    push word[text6length]
    call hprinttext
	;easy
		mov ax, [text7col]
    push ax
    mov ax, [text7row]
    push ax
    call position
    
    push si
    mov ax, text7
    push ax
    push word[text7length]
    call hprinttext
	;med
		mov ax, [text8col]
    push ax
    mov ax, [text8row]
    push ax
    call position
    
    push si
    mov ax, text8
    push ax
    push word[text8length]
    call hprinttext
	;Hard
			mov ax, [text9col]
    push ax
    mov ax, [text9row]
    push ax
    call position
    
    push si
    mov ax, text9
    push ax
    push word[text9length]
    call hprinttext
	;press..
	mov ax, [text10col]
    push ax
    mov ax, [text10row]
    push ax
    call position
    
    push si
    mov ax, text10
    push ax
    push word[text10length]
    call hprinttext
	
	readb: ;reading b  key press 
    mov ah, 0
    int 16h
	
    cmp al, 'b'
    je hgoback
    jmp readb
	hgoback:

     call start
	;ret
	; pop es
    ; pop di
    ; pop dx
    ; pop cx
    ; pop bx
    ; pop ax
    ; ret
	
    
    mov ax, 0x4C00
    int 21h