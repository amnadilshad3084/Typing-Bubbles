

; ------ DATA ----

npbgcolorbyte: db 0x00      ; bgr color attribute (high byte)
npvideomembase: dw 0xB800   ; base address for video memory, b800h
npscreencols: db 80         ; total cols = 80
npscreensize: dw 4000       ; total size 4000
npspacechar: db 0x20        ; space ascii
npcursoroff: db 0           ; value to disable the blinking cursor, 0

; Text strings
nppaused: db '    GAME PAUSED !!!'
nppausedlength: dw 19
nppausedrow: dw 6
nppausedcol: dw 30

npmove: db 'What is your next move?'
npmovelength: dw 23
npmoverow: dw 10
npmovecol: dw 28

npresume: db '-> RESUME (R)'
npresumelength: dw 13
npresumerow: dw 13
npresumecol: dw 33

npreplay: db '-> START AGAIN (S)'
npreplaylength: dw 18
npreplayrow: dw 15
npreplaycol: dw 33

npexit: db '-> Exit (E)'
npexitlength: dw 11
npexitrow: dw 17
npexitcol: dw 33

; Text color
nptextcolor: db 0xF0        ; White on Black

; White box (menu background) data
npboxchar: db 0x20          ; Space character
npboxcolor: db 0xFB         ; White on Cyan
npboxstartcol: dw 25        ; Box starting column
npboxstartrow: dw 4         ; Box starting row
npboxwidth: dw 30           ; Box width (30 columns)
npboxheight: dw 19          ; Box height (19 rows)

; Border data
npborderchar: db 0x20       ; Space character
npbordercolor: db 0x7B      ; Light Grey on Cyan
npborderleftcol: dw 24      ; Left border column
npborderupcol: dw 24        ; Top border column
npborderuprow: dw 3         ; Top border row
npborderrightcol: dw 55     ; Right border column
npborderdownrow: dw 22      ; Bottom border row
npbordertopwidth: dw 32     ; Top/bottom border width
npbordersideheight: dw 19   ; Left/right border height

; --- BALLOON 1 DATA (Left balloon) ---
npbl1col: dw 9              ; Balloon left 1 base column
npbl1row: dw 9              ; Balloon left 1 base row
npbl1w1len: dw 5            ; Balloon width 1
npbl1w2len: dw 7            ; Balloon width 2
npbl1w3len: dw 3            ; Balloon width 3
npbl1threadlen: dw 2        ; Thread length
npbl1char: db 0x20          ; Balloon character (Space)
npbl1color: db 0xDD         ; Balloon color (Light Magenta)
npbl1threadcol: dw 11       ; Thread column
npbl1threadrow: dw 15       ; Thread row

; --- BALLOON 2 DATA (Right balloon) ---
npbl2col: dw 65             ; Balloon right base column
npbl2row: dw 9              ; Balloon right base row
npbl2char: db 0x20          ; Balloon character (Space)
npbl2color: db 0x99         ; Balloon color (Light Blue)
npbl2threadcol: dw 67       ; Thread column
npbl2threadrow: dw 15       ; Thread row

; Thread attributes (shared)
npthreadchar: db 0x7C       ; Thread character ('|')
npthreadcolor: db 0x77      ; Thread color (Light Grey on Cyan)


;---------  stars-------------
; STARS DATA
npstarchar: db '*'           ; asterisk character
npstarcolor: db 0x0F         ; White color

; star positions
npstar1col: dw 5
npstar1row: dw 10

npstar2col: dw 15  
npstar2row: dw 3

npstar3col: dw 25
npstar3row: dw 24

npstar4col: dw 35
npstar4row: dw 4

npstar5col: dw 45
npstar5row: dw 6

npstar6col: dw 55
npstar6row: dw 10

npstar7col: dw 65
npstar7row: dw 21

npstar8col: dw 75
npstar8row: dw 13

npstar9col: dw 12
npstar9row: dw 17

npstar10col: dw 22
npstar10row: dw 8

npstar11col: dw 8
npstar11row: dw 12

npstar12col: dw 18
npstar12row: dw 20

npstar13col: dw 28
npstar13row: dw 5

npstar14col: dw 38
npstar14row: dw 10

npstar15col: dw 48
npstar15row: dw 14

npstar16col: dw 58
npstar16row: dw 7

npstar17col: dw 68
npstar17row: dw 16

npstar18col: dw 78
npstar18row: dw 11

npstar19col: dw 14
npstar19row: dw 9

npstar20col: dw 32
npstar20row: dw 19

; --- PROCEDURES ---
;---------STARS

npdraw_stars:
    push ax
    push bx
    push si
    
    mov bl, [npstarchar]
    mov bh, [npstarcolor]
    
    ; Star 1
    mov ax, [npstar1col]
    push ax
    mov ax, [npstar1row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 2
    mov ax, [npstar2col]
    push ax
    mov ax, [npstar2row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 3
    mov ax, [npstar3col]
    push ax
    mov ax, [npstar3row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 4
    mov ax, [npstar4col]
    push ax
    mov ax, [npstar4row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 5
    mov ax, [npstar5col]
    push ax
    mov ax, [npstar5row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 6
    mov ax, [npstar6col]
    push ax
    mov ax, [npstar6row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 7
    mov ax, [npstar7col]
    push ax
    mov ax, [npstar7row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 8
    mov ax, [npstar8col]
    push ax
    mov ax, [npstar8row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 9
    mov ax, [npstar9col]
    push ax
    mov ax, [npstar9row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 10
    mov ax, [npstar10col]
    push ax
    mov ax, [npstar10row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
 
    ; Star 11
    mov ax, [npstar11col]
    push ax
    mov ax, [npstar11row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 12
    mov ax, [npstar12col]
    push ax
    mov ax, [npstar12row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 13
    mov ax, [npstar13col]
    push ax
    mov ax, [npstar13row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 14
    mov ax, [npstar14col]
    push ax
    mov ax, [npstar14row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 15
    mov ax, [npstar15col]
    push ax
    mov ax, [npstar15row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 16
    mov ax, [npstar16col]
    push ax
    mov ax, [npstar16row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 17
    mov ax, [npstar17col]
    push ax
    mov ax, [npstar17row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 18
    mov ax, [npstar18col]
    push ax
    mov ax, [npstar18row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 19
    mov ax, [npstar19col]
    push ax
    mov ax, [npstar19row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    ; Star 20
    mov ax, [npstar20col]
    push ax
    mov ax, [npstar20row]
    push ax
    call npposition
    mov ax, bx
    mov cx, 1
    call npprint
    
    pop si
    pop bx
    pop ax
    ret

npclrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
npclearing:
    mov word[es:di], ax
    add di, 2
    cmp di, 4000
    jne npclearing
    ret
    
npposition:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [npvideomembase]
    mov es, ax              
    mov al, [npscreencols]
    mul byte [bp+4]
    add ax, [bp+6]       
    shl ax, 1             
    mov si, ax    
    
    pop ax
    pop bp
    ret 4

npballoon:
    push cx
npprintballoon:
    mov [es:di], ax
    add di,2
    loop npprintballoon
    pop cx
    ret

npthread:
    push cx            
npthreadloop:
    mov [es:di], ax    
    add di, 160     
    loop npthreadloop
    pop cx
    ret

npprint:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call npballoon 
    pop es
    pop di
    pop ax
    pop bp
    ret


npprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [npvideomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, [nptextcolor]

npnextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop npnextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

nprectangle:
    push cx 
nprec:
    mov [es:di], ax
    add di,2
    loop nprec
    pop cx
    ret

npprintrec:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call nprectangle 
    pop es
    pop di
    pop ax
    pop bp
    ret

npvertline:
    push cx 
npverticalline:
    mov [es:di], ax
    add di,160
    loop npverticalline
    pop cx
    ret

npprintvert:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call npvertline 
    pop es
    pop di
    pop ax
    pop bp
    ret

npfillbackground:
    mov ax, [npvideomembase]
    mov es, ax
    mov di, 0          
    mov cx, [npscreensize]
    mov al, [npspacechar]      
    mov ah, [npbgcolorbyte]
npfillloop:
    mov [es:di], ax
    add di, 2   
    loop npfillloop
    ret 

draw_ntpause_screen:
    ; Disable blinking
    mov ax, 1003h
    mov bl, [npcursoroff]
    int 10h
    call npclrscr
    call npfillbackground    
	call npdraw_stars
    
    ; Load box color into BX
    mov bl, [npboxchar]
    mov bh, [npboxcolor]
    
    ; Draw white box (menu background) - 19 rows
    mov dx, [npboxstartrow]    ; Start at row 4
    mov cx, [npboxheight]      ; 19 rows total
    
npdrawboxloop:
    mov ax, [npboxstartcol]
    push ax
    push dx
    call npposition
    mov ax, bx
    push cx
    mov cx, [npboxwidth]
    call npprintrec
    pop cx
    inc dx
    loop npdrawboxloop
    
    ; Load border color into BX
    mov bl, [npborderchar]
    mov bh, [npbordercolor]
    
    ; Border left
    mov ax, [npborderleftcol]
    push ax
    mov ax, [npboxstartrow]
    push ax
    call npposition
    mov ax, bx
    mov cx, [npbordersideheight]
    call npprintvert
    
    ; Border top
    mov ax, [npborderupcol]
    push ax
    mov ax, [npborderuprow]
    push ax
    call npposition
    mov ax, bx
    mov cx, [npbordertopwidth]
    call npprintrec
    
    ; Border right
    mov ax, [npborderrightcol]
    push ax
    mov ax, [npboxstartrow]
    push ax
    call npposition
    mov ax, bx
    mov cx, [npbordersideheight]
    call npprintvert
    
    ; Border bottom
    mov ax, [npborderupcol]
    push ax
    mov ax, [npborderdownrow]
    push ax
    call npposition
    mov ax, bx
    mov cx, [npbordertopwidth]
    call npprintrec
    
    ; --- BALLOON 1 (Left) ---
    mov bl, [npbl1char]
    mov bh, [npbl1color]
    
    ; Row 1
    mov ax, [npbl1col]
    push ax
    mov ax, [npbl1row]
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w1len]
    call npprint
    
    ; Row 2
    mov ax, [npbl1col]
    sub ax, 1
    push ax
    mov ax, [npbl1row]
    add ax, 1
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w2len]
    call npprint
    
    ; Row 3
    mov ax, [npbl1col]
    sub ax, 1
    push ax
    mov ax, [npbl1row]
    add ax, 2
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w2len]
    call npprint
    
    ; Row 4
    mov ax, [npbl1col]
    sub ax, 1
    push ax
    mov ax, [npbl1row]
    add ax, 3
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w2len]
    call npprint
    
    ; Row 5
    mov ax, [npbl1col]
    push ax
    mov ax, [npbl1row]
    add ax, 4
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w1len]
    call npprint
    
    ; Row 6
    mov ax, [npbl1col]
    add ax, 1
    push ax
    mov ax, [npbl1row]
    add ax, 5
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w3len]
    call npprint
    
    ; Thread
    mov bl, [npthreadchar]
    mov bh, [npthreadcolor]
    
    mov ax, [npbl1threadcol]
    push ax
    mov ax, [npbl1threadrow]
    push ax
    call npposition 
    mov di, si    
    mov ax, bx
    mov cx, [npbl1threadlen]
    call npthread
    
    ; --- BALLOON 2 (Right) ---
    mov bl, [npbl2char]
    mov bh, [npbl2color]
    
    ; Row 1
    mov ax, [npbl2col]
    push ax
    mov ax, [npbl2row]
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w1len]
    call npprint
    
    ; Row 2
    mov ax, [npbl2col]
    sub ax, 1
    push ax
    mov ax, [npbl2row]
    add ax, 1
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w2len]
    call npprint
    
    ; Row 3
    mov ax, [npbl2col]
    sub ax, 1
    push ax
    mov ax, [npbl2row]
    add ax, 2
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w2len]
    call npprint
    
    ; Row 4
    mov ax, [npbl2col]
    sub ax, 1
    push ax
    mov ax, [npbl2row]
    add ax, 3
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w2len]
    call npprint
    
    ; Row 5
    mov ax, [npbl2col]
    push ax
    mov ax, [npbl2row]
    add ax, 4
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w1len]
    call npprint
    
    ; Row 6
    mov ax, [npbl2col]
    add ax, 1
    push ax
    mov ax, [npbl2row]
    add ax, 5
    push ax
    call npposition          
    mov ax, bx
    mov cx, [npbl1w3len]
    call npprint

     ;thread
    mov bl, [npthreadchar]
    mov bh, [npthreadcolor]
    
    mov ax, [npbl2threadcol]
    push ax
    mov ax, [npbl2threadrow]
    push ax
    call npposition 
    mov di, si    
    mov ax, bx
    mov cx, [npbl1threadlen]
    call npthread
    
    ; --- TEXT: GAME PAUSED ---
    mov ax, [nppausedcol]
    push ax
    mov ax, [nppausedrow]
    push ax
    call npposition
    
    push si
    mov ax, nppaused
    push ax
    push word[nppausedlength]
    call npprinttext
    
    ; --- TEXT: What is your next move? ---
    mov ax, [npmovecol]
    push ax
    mov ax, [npmoverow]
    push ax
    call npposition
    
    push si
    mov ax, npmove
    push ax
    push word[npmovelength]
    call npprinttext
    
    ; --- TEXT: RESUME ---
    mov ax, [npresumecol]
    push ax
    mov ax, [npresumerow]
    push ax
    call npposition
    
    push si
    mov ax, npresume
    push ax
    push word[npresumelength]
    call npprinttext
    
    ; --- TEXT: START AGAIN ---
    mov ax, [npreplaycol]
    push ax
    mov ax, [npreplayrow]
    push ax
    call npposition
    
    push si
    mov ax, npreplay
    push ax
    push word[npreplaylength]
    call npprinttext
	
	;---exit   
	mov ax, [npexitcol]
    push ax
    push ax
    mov ax, [npexitrow]
    push ax
    call npposition
    
    push si
    mov ax, npexit
    push ax
    push word[npexitlength]
    call npprinttext

 
	
;start again
	npreadkey: ;reading e  key press 
    mov ah, 0
    int 16h
	 cmp al,'r'
	 je resumenight
	 
    cmp al, 's'
	je npgoback
    ; je gostart
	
	 cmp al, 'e'
    je npgoback

    jmp readkey

resumenight:
call nclrscr
call nfillbackground
call ngame_display
call nballoon_loop

;;;exit
	npgoback:
     call start
    
    mov ax, 0x4C00
    int 21h