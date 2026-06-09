
; ------ DATA ----

pbgcolorbyte: db 0xBB      ; bgr color attribute (high byte)
pvideomembase: dw 0xB800   ; base address for video memory, b800h
pscreencols: db 80         ; total cols = 80
pscreensize: dw 4000       ; total size 4000
pspacechar: db 0x20        ; space ascii
pcursoroff: db 0           ; value to disable the blinking cursor, 0

; Text strings
ppaused: db '    GAME PAUSED !!!'
ppausedlength: dw 19
ppausedrow: dw 6
ppausedcol: dw 30

pmove: db 'What is your next move?'
pmovelength: dw 23
pmoverow: dw 10
pmovecol: dw 28

presume: db '-> RESUME (R)'
presumelength: dw 13
presumerow: dw 13
presumecol: dw 33

preplay: db '-> START AGAIN (S)'
preplaylength: dw 18
preplayrow: dw 15
preplaycol: dw 33

pexit: db '-> Exit (E)'
pexitlength: dw 11
pexitrow: dw 17
pexitcol: dw 33

; Text color
ptextcolor: db 0xF0        ; White on Black

; White box (menu background) data
pboxchar: db 0x20          ; Space character
pboxcolor: db 0xFB         ; White on Cyan
pboxstartcol: dw 25        ; Box starting column
pboxstartrow: dw 4         ; Box starting row
pboxwidth: dw 30           ; Box width (30 columns)
pboxheight: dw 19          ; Box height (19 rows)

; Border data
pborderchar: db 0x20       ; Space character
pbordercolor: db 0x7B      ; Light Grey on Cyan
pborderleftcol: dw 24      ; Left border column
pborderupcol: dw 24        ; Top border column
pborderuprow: dw 3         ; Top border row
pborderrightcol: dw 55     ; Right border column
pborderdownrow: dw 22      ; Bottom border row
pbordertopwidth: dw 32     ; Top/bottom border width
pbordersideheight: dw 19   ; Left/right border height

; --- BALLOON 1 DATA (Left balloon) ---
pbl1col: dw 9              ; Balloon left 1 base column
pbl1row: dw 9              ; Balloon left 1 base row
pbl1w1len: dw 5            ; Balloon width 1
pbl1w2len: dw 7            ; Balloon width 2
pbl1w3len: dw 3            ; Balloon width 3
pbl1threadlen: dw 2        ; Thread length
pbl1char: db 0x20          ; Balloon character (Space)
pbl1color: db 0xDD         ; Balloon color (Light Magenta)
pbl1threadcol: dw 11       ; Thread column
pbl1threadrow: dw 15       ; Thread row

; --- BALLOON 2 DATA (Right balloon) ---
pbl2col: dw 65             ; Balloon right base column
pbl2row: dw 9              ; Balloon right base row
pbl2char: db 0x20          ; Balloon character (Space)
pbl2color: db 0x99         ; Balloon color (Light Blue)
pbl2threadcol: dw 67       ; Thread column
pbl2threadrow: dw 15       ; Thread row

; Thread attributes (shared)
pthreadchar: db 0x7C       ; Thread character ('|')
pthreadcolor: db 0x77      ; Thread color (Light Grey on Cyan)

;---------  CLOUD-------------
pcloudchar: db 0x20    
pcloudcolor: db 0xFF       ; White on Cyan 

; Cloud 1 (top left)
pcloud1col: dw 3
pcloud1row: dw 3

; Cloud 2 (top right)
pcloud2col: dw 58
pcloud2row: dw 1

; Cloud 3 (middle left)
pcloud3col: dw 3
pcloud3row: dw 16

; Cloud 4 (middle right)
pcloud4col: dw 69
pcloud4row: dw 20

;subroutines
;-------- DRAW CLOUD -----
pdraw_clouds:
    push ax
    push bx
    push cx
    
    mov bl, [pcloudchar]
    mov bh, [pcloudcolor]
    
    ;            CLOUD 1 
   ; Row 1 , top
    mov ax, [pcloud1col]
    add ax, 4          
    push ax
    mov ax, [pcloud1row]
    push ax
    call pposition
    mov ax, bx
    mov cx, 6        
    call pprint
    
    ; Row 2 , upper middle 
    mov ax, [pcloud1col]
    add ax, 2         
    push ax
    mov ax, [pcloud1row]
    add ax, 1           ; Row + 1
    push ax
    call pposition
    mov ax, bx
    mov cx, 10          ;Length 10
    call pprint
    
    ; Row 3 (middle )
    mov ax, [pcloud1col] 
    push ax             
    mov ax, [pcloud1row]
    add ax, 2        
    push ax
    call pposition
    mov ax, bx
    mov cx, 14       
    call pprint
    
    ; Row 4 
    mov ax, [pcloud1col]
    add ax, 3        
    push ax
    mov ax, [pcloud1row]
    add ax, 3         
    push ax
    call pposition
    mov ax, bx
    mov cx, 8          
    call pprint
    
    ;CLOUD 2
    mov ax, [pcloud2col]
    add ax, 5
    push ax
    mov ax, [pcloud2row]
    push ax
    call pposition
    mov ax, bx
    mov cx, 7
    call pprint
    
    ; Row 2
    mov ax, [pcloud2col]
    add ax, 2
    push ax
    mov ax, [pcloud2row]
    add ax, 1
    push ax
    call pposition
    mov ax, bx
    mov cx, 13
    call pprint
    
    ; Row 3
    mov ax, [pcloud2col]
    push ax
    mov ax, [pcloud2row]
    add ax, 2
    push ax
    call pposition
    mov ax, bx
    mov cx, 17
    call pprint
    
    ; Row 4
    mov ax, [pcloud2col]
    add ax, 4
    push ax
    mov ax, [pcloud2row]
    add ax, 3
    push ax
    call pposition
    mov ax, bx
    mov cx, 9
    call pprint
    
    ; CLOUD 3
    ; Row 1
    mov ax, [pcloud3col]
    add ax, 2
    push ax
    mov ax, [pcloud3row]
    push ax
    call pposition
    mov ax, bx
    mov cx, 3
    call pprint
    
    ; Row 2
    mov ax, [pcloud3col]
    push ax
    mov ax, [pcloud3row]
    add ax, 1
    push ax
    call pposition
    mov ax, bx
    mov cx, 7
    call pprint
    
    ; Row 3
    mov ax, [pcloud3col]
    add ax, 1
    push ax
    mov ax, [pcloud3row]
    add ax, 2
    push ax
    call pposition
    mov ax, bx
    mov cx, 5
    call pprint
    
    ; CLOUD 4
    ; Row 1
    mov ax, [pcloud4col]
    add ax, 2
    push ax
    mov ax, [pcloud4row]
    push ax
    call pposition
    mov ax, bx
    mov cx, 5
    call pprint
    
    ; Row 2
    mov ax, [pcloud4col]
    push ax
    mov ax, [pcloud4row]
    add ax, 1
    push ax
    call pposition
    mov ax, bx
    mov cx, 9
    call pprint
    
    ; Row 3
    mov ax, [pcloud4col]
    add ax, 2
    push ax
    mov ax, [pcloud4row]
    add ax, 2
    push ax
    call pposition
    mov ax, bx
    mov cx, 5
    call pprint
    
    pop cx
    pop bx
    pop ax
    ret


pclrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
pclearing:
    mov word [es:di], ax
    add di, 2
    cmp di, 4000
    jne pclearing
    ret


    
pposition:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [pvideomembase]
    mov es, ax              
    mov al, [pscreencols]
    mul byte [bp+4]
    add ax, [bp+6]       
    shl ax, 1             
    mov si, ax    
    
    pop ax
    pop bp
    ret 4

pballoon:
    push cx
pprintballoon:
    mov [es:di], ax
    add di,2
    loop pprintballoon
    pop cx
    ret

pthread:
    push cx            
pthreadloop:
    mov [es:di], ax    
    add di, 160     
    loop pthreadloop
    pop cx
    ret

pprint:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call pballoon 
    pop es
    pop di
    pop ax
    pop bp
    ret

pprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [pvideomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, [ptextcolor]

pnextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop pnextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

prectangle:
    push cx 
prec:
    mov [es:di], ax
    add di,2
    loop prec
    pop cx
    ret

pprintrec:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call prectangle 
    pop es
    pop di
    pop ax
    pop bp
    ret

pvertline:
    push cx 
pverticalline:
    mov [es:di], ax
    add di,160
    loop pverticalline
    pop cx
    ret

pprintvert:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call pvertline 
    pop es
    pop di
    pop ax
    pop bp
    ret

pfillbackground:
    mov ax, [pvideomembase]
    mov es, ax
    mov di, 0          
    mov cx, [pscreensize]
    mov al, [pspacechar]      
    mov ah, [pbgcolorbyte]
pfillloop:
    mov [es:di], ax
    add di, 2   
    loop pfillloop
    ret 

draw_gpause_screen:
    ; Disable blinking
      mov ax, 1003h
    mov bl, [pcursoroff]
    int 10h
    call pclrscr
    call pfillbackground    
    call pdraw_clouds
    
    ; Load box color into BX
    mov bl, [pboxchar]
    mov bh, [pboxcolor]
    
    ; Draw white box (menu background) - 19 rows
    mov dx, [pboxstartrow]    ; Start at row 4
    mov cx, [pboxheight]      ; 19 rows total
    
pdrawboxloop:
    mov ax, [pboxstartcol]
    push ax
    push dx
    call pposition
    mov ax, bx
    push cx
    mov cx, [pboxwidth]
    call pprintrec
    pop cx
    inc dx
    loop pdrawboxloop
    
    ; Load border color into BX
    mov bl, [pborderchar]
    mov bh, [pbordercolor]
    
    ; Border left
    mov ax, [pborderleftcol]
    push ax
    mov ax, [pboxstartrow]
    push ax
    call pposition
    mov ax, bx
    mov cx, [pbordersideheight]
    call pprintvert
    
    ; Border top
    mov ax, [pborderupcol]
    push ax
    mov ax, [pborderuprow]
    push ax
    call pposition
    mov ax, bx
    mov cx, [pbordertopwidth]
    call pprintrec
    
    ; Border right
    mov ax, [pborderrightcol]
    push ax
    mov ax, [pboxstartrow]
    push ax
    call pposition
    mov ax, bx
    mov cx, [pbordersideheight]
    call pprintvert
    
    ; Border bottom
    mov ax, [pborderupcol]
    push ax
    mov ax, [pborderdownrow]
    push ax
    call pposition
    mov ax, bx
    mov cx, [pbordertopwidth]
    call pprintrec
    
    ; --- BALLOON 1 (Left) ---
    mov bl, [pbl1char]
    mov bh, [pbl1color]
    
    ; Row 1
    mov ax, [pbl1col]
    push ax
    mov ax, [pbl1row]
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w1len]
    call pprint
    
    ; Row 2
    mov ax, [pbl1col]
    sub ax, 1
    push ax
    mov ax, [pbl1row]
    add ax, 1
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w2len]
    call pprint
    
    ; Row 3
    mov ax, [pbl1col]
    sub ax, 1
    push ax
    mov ax, [pbl1row]
    add ax, 2
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w2len]
    call pprint
    
    ; Row 4
    mov ax, [pbl1col]
    sub ax, 1
    push ax
    mov ax, [pbl1row]
    add ax, 3
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w2len]
    call pprint
    
    ; Row 5
    mov ax, [pbl1col]
    push ax
    mov ax, [pbl1row]
    add ax, 4
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w1len]
    call pprint
    
    ; Row 6
    mov ax, [pbl1col]
    add ax, 1
    push ax
    mov ax, [pbl1row]
    add ax, 5
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w3len]
    call pprint

       ; Thread
    mov bl, [pthreadchar]
    mov bh, [pthreadcolor]
    
    mov ax, [pbl1threadcol]
    push ax
    mov ax, [pbl1threadrow]
    push ax
    call pposition 
    mov di, si    
    mov ax, bx
    mov cx, [pbl1threadlen]
    call pthread
    
    ; --- BALLOON 2 (Right) ---
    mov bl, [pbl2char]
    mov bh, [pbl2color]
    
    ; Row 1
    mov ax, [pbl2col]
    push ax
    mov ax, [pbl2row]
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w1len]
    call pprint
    
    ; Row 2
    mov ax, [pbl2col]
    sub ax, 1
    push ax
    mov ax, [pbl2row]
    add ax, 1
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w2len]
    call pprint
    
    ; Row 3
    mov ax, [pbl2col]
    sub ax, 1
    push ax
    mov ax, [pbl2row]
    add ax, 2
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w2len]
    call pprint
    
    ; Row 4
    mov ax, [pbl2col]
    sub ax, 1
    push ax
    mov ax, [pbl2row]
    add ax, 3
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w2len]
    call pprint
    
    ; Row 5
    mov ax, [pbl2col]
    push ax
    mov ax, [pbl2row]
    add ax, 4
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w1len]
    call pprint
    
    ; Row 6
    mov ax, [pbl2col]
    add ax, 1
    push ax
    mov ax, [pbl2row]
    add ax, 5
    push ax
    call pposition          
    mov ax, bx
    mov cx, [pbl1w3len]
    call pprint
    
    ; Thread
    mov bl, [pthreadchar]
    mov bh, [pthreadcolor]
    
    mov ax, [pbl2threadcol]
    push ax
    mov ax, [pbl2threadrow]
    push ax
    call pposition 
    mov di, si    
    mov ax, bx
    mov cx, [pbl1threadlen]
    call pthread

       ; --- TEXT: GAME PAUSED ---
    mov ax, [ppausedcol]
    push ax
    mov ax, [ppausedrow]
    push ax
    call pposition
    
    push si
    mov ax, ppaused
    push ax
    push word[ppausedlength]
    call pprinttext
    
    ; --- TEXT: What is your next move? ---
    mov ax, [pmovecol]
    push ax
    mov ax, [pmoverow]
    push ax
    call pposition
    
    push si
    mov ax, pmove
    push ax
    push word[pmovelength]
    call pprinttext
    
    ; --- TEXT: RESUME ---
    mov ax, [presumecol]
    push ax
    mov ax, [presumerow]
    push ax
    call pposition
    
    push si
    mov ax, presume
    push ax
    push word[presumelength]
    call pprinttext
    
    ; --- TEXT: START AGAIN ---
    mov ax, [preplaycol]
    push ax
    mov ax, [preplayrow]
    push ax
    call pposition
    
    push si
    mov ax, preplay
    push ax
    push word[preplaylength]
    call pprinttext
    
    ; --- TEXT: Exit ---
    mov ax, [pexitcol]
    push ax
    push ax
    mov ax, [pexitrow]
    push ax
    call pposition
    
    push si
    mov ax, pexit
    push ax
    push word[pexitlength]
    call pprinttext


;RESUME


;start again
	readkey: ;reading e  key press 
    mov ah, 0
    int 16h
	 cmp al,'r'
	 je goresume
	 
    cmp al, 's'
	je eegoback
    ; je gostart
	
	 cmp al, 'e'
    je eegoback

    jmp readkey

; gostart:

    ; call draw_gameplay_screen

goresume:
call gclrscr
call gfillbackground
call game_display
call gballoon_loop

;;;exit
	eegoback:
     call start
	 
    mov ax, 0x4C00
    int 21h