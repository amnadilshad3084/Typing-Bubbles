; Score display data
final_score_msg: db 'FINAL SCORE: '
final_score_len: dw 13
final_score_row: dw 5        ; Row where score appears
final_score_col: dw 33       ; Column where "FINAL SCORE:" appears
final_score_color: db 0x9B    ; Cyan background, black text


print_final_score:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    push si
    
    ;  "FINAL SCORE
    mov ax, [final_score_col]
    push ax
    mov ax, [final_score_row]
    push ax
    call position         ; Use your position function
    
    mov ax, 0xB800
    mov es, ax
    mov di, si
    mov si, final_score_msg
    mov cx, [final_score_len]
    mov ah, [final_score_color]
    
print_score_text:
    lodsb                 ; load char from si to AL si points to finalscore in memry
    mov [es:di], ax
    add di, 2
    loop print_score_text
    
    ;  print  actual score number
    ; Position after "FINAL SCORE: " text
    mov ax, [final_score_col]
    add ax, [final_score_len]
    add ax, 1             ; Add space
    push ax
    mov ax, [final_score_row]
    push ax
    call position
    mov di, si
    
    ; Convert score to digits and print
    mov ax, [gcurrent_score]  ;e.g 150
    mov bx, 10  ;divisor 10
    mov cx, 0 ;digit counter
    
get_score_digits:
    xor dx, dx  ;clear dx
    div bx   ;divide ax by 10
    push dx         ;push remainder (digit)
    inc cx            ;count digits
    cmp ax, 0
    jne get_score_digits
    
    mov ah, [final_score_color]
print_score_digits:
    pop dx  ;gets digit rom stack
    add dl, 0x30          ; Convert to ASCII
    mov al, dl  ;put char in al
    mov [es:di], ax  ;write char
    add di, 2
    loop print_score_digits
    
    pop si
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
; ------ DATA ----

gobgcolorbyte: db 0xBB      ; bgr color attribute (high byte)
govideomembase: dw 0xB800   ; base address for video memory, b800h
goscreencols: db 80         ; total cols = 80
goscreensize: dw 4000       ; total size 4000
gospacechar: db 0x20        ; space ascii
gocursoroff: db 0           ; value to disable the blinking cursor, 0

; buttons attribute
gobuttoncolor: db 0xB9

;---------  CLOUD-------------
gocloudchar: db 0x20    
gocloudcolor: db 0xFF       ; White on Cyan 

; Cloud 1 (top left)
gocloud1col: dw 3
gocloud1row: dw 3

; Cloud 2 (top right)
gocloud2col: dw 52
gocloud2row: dw 1

; Cloud 3 (middle left)
gocloud3col: dw 3
gocloud3row: dw 16

; Cloud 4 (middle right)
gocloud4col: dw 69
gocloud4row: dw 20


; Text strings
gotext: db 'BETTER LUCK NEXT TIME!'
gotextlength: dw 22
gotextrow: dw 18
gotextcol: dw 28

goplay: db 'Play Again (P)'
goplaylength: dw 14
goplayrow: dw 23
goplaycol: dw 19

gotext2: db 'Exit (E)'
gotext2length: dw 8
gotext2row: dw 23
gotext2col: dw 50



; Text color
gotextcolor: db 0xB0        ; Black on Cyan


; --- LETTER G DATA ---
gogcol: dw 6                ; G letter column
gogrow: dw 8                ; G letter row
gogh1len: dw 6              ; G horizontal line 1 length
gogv1len: dw 6              ; G vertical line 1 length
gogh2row: dw 14             ; G horizontal line 2 row
gogv2col: dw 11             ; G vertical line 2 column
gogv2row: dw 12             ; G vertical line 2 row
gogv2len: dw 3              ; G vertical line 2 length
gogh3col: dw 9              ; G horizontal line 3 column
gogh3row: dw 11             ; G horizontal line 3 row
gogh3len: dw 3              ; G horizontal line 3 length
gogcolor: db 0x9B           ; G color (Red on Cyan)

; --- LETTER A DATA ---
goacol: dw 18               ; A letter column (for diagonals)
goarow: dw 10               ; A letter row
goadiaglen: dw 5            ; A diagonal length
goah1col: dw 16             ; A horizontal line column
goah1row: dw 13             ; A horizontal line row
goah1len: dw 5              ; A horizontal line length
goacolor: db 0x9B           ; A color (Black on Cyan)

; --- LETTER M DATA ---
gomcol: dw 24               ; M letter left column
gomrow: dw 10               ; M letter row
gomvlen: dw 5               ; M vertical line length
gomrvcol: dw 29             ; M right vertical column
gomdiaglen: dw 3            ; M diagonal length
gomcolor: db 0x9B           ; M color (Black on Cyan)

; --- LETTER E1 DATA ---
goe1col: dw 31              ; E1 letter column
goe1row: dw 10              ; E1 letter row
goe1vlen: dw 5              ; E1 vertical length
goe1h1len: dw 5             ; E1 horizontal line 1 length
goe1h2row: dw 12            ; E1 horizontal line 2 row
goe1h3row: dw 14            ; E1 horizontal line 3 row
goe1color: db 0x9B          ; E1 color (Black on Cyan)

; --- LETTER O DATA ---
gocol: dw 39               ; O letter column
goorow: dw 8               ; O letter row
gooh1len: dw 7             ; O horizontal line 1 length
goov1len: dw 7             ; O vertical line 1 length
gooh2row: dw 14            ; O horizontal line 2 row
goorvcol: dw 45            ; O right vertical column
gocolor: db 0x9B           ; O color (Red on Cyan)

; --- LETTER V DATA ---
govcol: dw 48               ; V letter left diagonal column
govrow: dw 10               ; V letter row
govdiaglen: dw 5            ; V diagonal length
govrdiagcol: dw 56          ; V right diagonal column
govcolor: db 0x9B           ; V color (Black on Cyan)

; --- LETTER E2 DATA ---
goe2col: dw 58              ; E2 letter column
goe2row: dw 10              ; E2 letter row
goe2vlen: dw 5              ; E2 vertical length
goe2h1len: dw 5             ; E2 horizontal line 1 length
goe2h2row: dw 12            ; E2 horizontal line 2 row
goe2h3row: dw 14            ; E2 horizontal line 3 row
goe2color: db 0x9B          ; E2 color (Black on Cyan)

; --- LETTER R DATA ---
gorcol: dw 65               ; R letter column
gorrow: dw 10               ; R letter row
gorvlen: dw 5               ; R vertical length
gorh1len: dw 6              ; R horizontal line 1 length
gorh2row: dw 12             ; R horizontal line 2 row
gorrvcol: dw 70             ; R right vertical column
gorrvlen: dw 3              ; R right vertical length
gordiagcol: dw 66           ; R diagonal column
gordiagrow: dw 12           ; R diagonal row
gordiaglen: dw 4            ; R diagonal length
gorcolor: db 0x9B           ; R color (Black on Cyan)

; --- VOLUME BUTTON ---
govolbcol: dw 2             ; Volume button speaker base column
govolbrow: dw 23            ; Volume button speaker base row
govolblen: dw 2             ; Volume button speaker base length
govoltcol: dw 4             ; Volume button triangle column
govoltrow: dw 23            ; Volume button triangle middle row
govolttoprow: dw 22         ; Volume button triangle top row
govoltbotrow: dw 24         ; Volume button triangle bottom row
govolspeakerchar: db 0x20   ; Volume speaker character (Space)
govolspeakercolor: db 0xFF  ; Volume speaker color (White on Cyan)
govolw1col: dw 5            ; wave 1
govolw1row: dw 23           ; wave 1
govolw1len: dw 1            ; wave 1
govolw2col: dw 6            ; wave 2
govolw2row: dw 22           ; wave 2
govolw2len: dw 3            ; wave 2
govolw3col: dw 7            ; wave 3
govolw3row: dw 22           ; wave 3
govolw3len: dw 3            ; wave 3
govolwavechar: db 0x7C      ; Volume wave character ('|')
govolwavecolor: db 0xB0     ; Volume wave color (Black on Cyan)

;subroutines
;-------- DRAW CLOUD -----
godraw_clouds:
    push ax
    push bx
    push cx
    
    mov bl, [gocloudchar]
    mov bh, [gocloudcolor]
    
    ;            CLOUD 1 
   ; Row 1 , top
    mov ax, [gocloud1col]
    add ax, 4          
    push ax
    mov ax, [gocloud1row]
    push ax
    call goposition
    mov ax, bx
    mov cx, 6        
    call goprint
    
    ; Row 2 , upper middle 
    mov ax, [gocloud1col]
    add ax, 2         
    push ax
    mov ax, [gocloud1row]
    add ax, 1           ; Row + 1
    push ax
    call goposition
    mov ax, bx
    mov cx, 10          ;Length 10
    call goprint
    
    ; Row 3 (middle )
    mov ax, [gocloud1col] 
    push ax             
    mov ax, [gocloud1row]
    add ax, 2        
    push ax
    call goposition
    mov ax, bx
    mov cx, 14       
    call goprint
    
    ; Row 4 
    mov ax, [gocloud1col]
    add ax, 3        
    push ax
    mov ax, [gocloud1row]
    add ax, 3         
    push ax
    call goposition
    mov ax, bx
    mov cx, 8          
    call goprint
    
    ;CLOUD 2
    mov ax, [gocloud2col]
    add ax, 5
    push ax
    mov ax, [gocloud2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, 7
    call goprint
    
    ; Row 2
    mov ax, [gocloud2col]
    add ax, 2
    push ax
    mov ax, [gocloud2row]
    add ax, 1
    push ax
    call goposition
    mov ax, bx
    mov cx, 13
    call goprint
    
    ; Row 3
    mov ax, [gocloud2col]
    push ax
    mov ax, [gocloud2row]
    add ax, 2
    push ax
    call goposition
    mov ax, bx
    mov cx, 17
    call goprint
    
    ; Row 4
    mov ax, [gocloud2col]
    add ax, 4
    push ax
    mov ax, [gocloud2row]
    add ax, 3
    push ax
    call goposition
    mov ax, bx
    mov cx, 9
    call goprint
    
    ; CLOUD 3
    ; Row 1
    mov ax, [gocloud3col]
    add ax, 2
    push ax
    mov ax, [gocloud3row]
    push ax
    call goposition
    mov ax, bx
    mov cx, 3
    call goprint
    
    ; Row 2
    mov ax, [gocloud3col]
    push ax
    mov ax, [gocloud3row]
    add ax, 1
    push ax
    call goposition
    mov ax, bx
    mov cx, 7
    call goprint
    
    ; Row 3
    mov ax, [gocloud3col]
    add ax, 1
    push ax
    mov ax, [gocloud3row]
    add ax, 2
    push ax
    call goposition
    mov ax, bx
    mov cx, 5
    call goprint
    
    ; CLOUD 4
    ; Row 1
    mov ax, [gocloud4col]
    add ax, 2
    push ax
    mov ax, [gocloud4row]
    push ax
    call goposition
    mov ax, bx
    mov cx, 5
    call goprint
    
    ; Row 2
    mov ax, [gocloud4col]
    push ax
    mov ax, [gocloud4row]
    add ax, 1
    push ax
    call goposition
    mov ax, bx
    mov cx, 9
    call goprint
    
    ; Row 3
    mov ax, [gocloud4col]
    add ax, 2
    push ax
    mov ax, [gocloud4row]
    add ax, 2
    push ax
    call goposition
    mov ax, bx
    mov cx, 5
    call goprint
    
    pop cx
    pop bx
    pop ax
    ret

;---------- CLEAR SCREEN ----------
goclscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
goclearing:
    mov word [es:di], ax
    add di, 2
    cmp di, 4000
    jne goclearing
    ret
    
;---------- POSITION ----------
goposition:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [govideomembase]
    mov es, ax              
    mov al, [goscreencols]
    mul byte [bp+4]
    add ax, [bp+6]       
    shl ax, 1             
    mov si, ax    
    
    pop ax
    pop bp
    ret 4


goprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [govideomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, [gobuttoncolor]

gonextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop gonextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

govolline:
    push cx
govollineprint:
    mov [es:di], ax
    add di,2
    loop govollineprint
    pop cx
    ret

goprint:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call govolline 
    pop es
    pop di
    pop ax
    pop bp
    ret

gofillbackground:
    mov ax, [govideomembase]
    mov es, ax
    mov di, 0          
    mov cx, [goscreensize]
    mov al, [gospacechar]      
    mov ah, [gobgcolorbyte]
gofillloop:
    mov [es:di], ax
    add di, 2   
    loop gofillloop
    ret 

gohorizontal:
    push cx 
gohori:
    mov [es:di], ax
    add di,2
    loop gohori
    pop cx
    ret

goprinthorizontal:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call gohorizontal 
    pop es
    pop di
    pop ax
    pop bp
    ret

govertical:
    push cx 
govert:
    mov [es:di], ax
    add di,160
    loop govert
    pop cx
    ret

goprintvertical:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call govertical 
    pop es
    pop di
    pop ax
    pop bp
    ret

godiagonal1:
    push cx 
godiag1:
    mov [es:di], ax
    add di,162
    loop godiag1
    pop cx
    ret

goprintdiagonal1:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call godiagonal1 
    pop es
    pop di
    pop ax
    pop bp
    ret


godiagonal2:
    push cx 
godiag2:
    mov [es:di], ax
    add di,158
    loop godiag2
    pop cx
    ret

goprintdiagonal2:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call godiagonal2 
    pop es
    pop di
    pop ax
    pop bp
    ret

draw_gameover_screen:
    ; Disable blinking
       mov ax, 1003h
    mov bl, [gocursoroff]
    int 10h
    call goclscr
    call gofillbackground    
    call godraw_clouds
    ; --- TEXT: BETTER LUCK NEXT TIME! ---
    mov ax, [gotextcol]
    push ax
    mov ax, [gotextrow]
    push ax
    call goposition
    
    push si
    mov ax, gotext
    push ax
    push word[gotextlength]
    call goprinttext

    
    ; Load G color into BX
    mov bl, [gospacechar]
    mov bh, [gogcolor]
    
    ; --- LETTER G ---
    ; G1 - Top horizontal
    mov ax, [gogcol]
    push ax
    mov ax, [gogrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gogh1len]
    call goprinthorizontal
    
    ; G2 - Left vertical
    mov ax, [gogcol]
    push ax
    mov ax, [gogrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gogv1len]
    call goprintvertical
    
    ; G3 - Bottom horizontal
    mov ax, [gogcol]
    push ax
    mov ax, [gogh2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gogh1len]
    call goprinthorizontal
    
    ; G4 - Right vertical
    mov ax, [gogv2col]
    push ax
    mov ax, [gogv2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gogv2len]
    call goprintvertical
    
    ; G5 - Middle horizontal
    mov ax, [gogh3col]
    push ax
    mov ax, [gogh3row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gogh3len]
    call goprinthorizontal
    
    ; Load A color into BX
    mov bl, [gospacechar]
    mov bh, [goacolor]
    
    ; --- LETTER A ---
    ; A1 - Left diagonal
    mov ax, [goacol]
    push ax
    mov ax, [goarow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goadiaglen]
    call goprintdiagonal1
    
    ; A2 - Right diagonal
    mov ax, [goacol]
    push ax
    mov ax, [goarow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goadiaglen]
    call goprintdiagonal2
    
    ; A3 - Middle horizontal
    mov ax, [goah1col]
    push ax
    mov ax, [goah1row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goah1len]
    call goprinthorizontal
    
    ; Load M color into BX
    mov bl, [gospacechar]
    mov bh, [gomcolor]
    
    ; --- LETTER M ---
    ; M1 - Left vertical
    mov ax, [gomcol]
    push ax
    mov ax, [gomrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gomvlen]
    call goprintvertical
    
    ; M2 - Right vertical
    mov ax, [gomrvcol]
    push ax
    mov ax, [gomrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gomvlen]
    call goprintvertical
    
    ; M3 - Left diagonal
    mov ax, [gomcol]
    push ax
    mov ax, [gomrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gomdiaglen]
    call goprintdiagonal1
    
    ; M4 - Right diagonal
    mov ax, [gomrvcol]
    push ax
    mov ax, [gomrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gomdiaglen]
    call goprintdiagonal2
    
    ; Load E1 color into BX
    mov bl, [gospacechar]
    mov bh, [goe1color]
    
    ; --- LETTER E1 ---
    ; E1 - Left vertical
    mov ax, [goe1col]
    push ax
    mov ax, [goe1row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe1vlen]
    call goprintvertical
    
    ; E2 - Top horizontal
    mov ax, [goe1col]
    push ax
    mov ax, [goe1row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe1h1len]
    call goprinthorizontal
    
    ; E3 - Middle horizontal
    mov ax, [goe1col]
    push ax
    mov ax, [goe1h2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe1h1len]
    call goprinthorizontal
    
    ; E4 - Bottom horizontal
    mov ax, [goe1col]
    push ax
    mov ax, [goe1h3row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe1h1len]
    call goprinthorizontal
    
    ; Load O color into BX
    mov bl, [gospacechar]
    mov bh, [gocolor]

    
    ; --- LETTER O ---
    ; O1 - Top horizontal
    mov ax, [gocol]
    push ax
    mov ax, [goorow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gooh1len]
    call goprinthorizontal
    
    ; O2 - Left vertical
    mov ax, [gocol]
    push ax
    mov ax, [goorow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goov1len]
    call goprintvertical
    
    ; O3 - Bottom horizontal
    mov ax, [gocol]
    push ax
    mov ax, [gooh2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gooh1len]
    call goprinthorizontal
    
    ; O4 - Right vertical
    mov ax, [goorvcol]
    push ax
    mov ax, [goorow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goov1len]
    call goprintvertical
    
    ; Load V color into BX
    mov bl, [gospacechar]
    mov bh, [govcolor]
    
    ; --- LETTER V ---
    ; V1 - Left diagonal
    mov ax, [govcol]
    push ax
    mov ax, [govrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [govdiaglen]
    call goprintdiagonal1
    
    ; V2 - Right diagonal
    mov ax, [govrdiagcol]
    push ax
    mov ax, [govrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [govdiaglen]
    call goprintdiagonal2
    
    ; Load E2 color into BX
    mov bl, [gospacechar]
    mov bh, [goe2color]
    
    ; --- LETTER E2 ---
    ; E1 - Left vertical
    mov ax, [goe2col]
    push ax
    mov ax, [goe2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe2vlen]
    call goprintvertical
    
    ; E2 - Top horizontal
    mov ax, [goe2col]
    push ax
    mov ax, [goe2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe2h1len]
    call goprinthorizontal
    
    ; E3 - Middle horizontal
    mov ax, [goe2col]
    push ax
    mov ax, [goe2h2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe2h1len]
    call goprinthorizontal
    
    ; E4 - Bottom horizontal
    mov ax, [goe2col]
    push ax
    mov ax, [goe2h3row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [goe2h1len]
    call goprinthorizontal
    
    ; Load R color into BX
    mov bl, [gospacechar]
    mov bh, [gorcolor]
    
    ; --- LETTER R ---
    ; R1 - Left vertical
    mov ax, [gorcol]
    push ax
    mov ax, [gorrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gorvlen]
    call goprintvertical
    
    ; R2 - Top horizontal
    mov ax, [gorcol]
    push ax
    mov ax, [gorrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gorh1len]
    call goprinthorizontal
    
    ; R3 - Middle horizontal
    mov ax, [gorcol]
    push ax
    mov ax, [gorh2row]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gorh1len]
    call goprinthorizontal
    
    ; R4 - Right vertical
    mov ax, [gorrvcol]
    push ax
    mov ax, [gorrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gorrvlen]
    call goprintvertical
    
    ; R5 - Diagonal leg
    mov ax, [gordiagcol]
    push ax
    mov ax, [gordiagrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [gordiaglen]
    call goprintdiagonal1
	
	;playagain
	  mov ax, [goplaycol]
    push ax
    mov ax, [goplayrow]
    push ax
    call goposition
    
    push si
    mov ax, goplay
    push ax
    push word[goplaylength]
    call goprinttext
    
    ; --- TEXT:exit
    mov ax, [gotext2col]
    push ax
    mov ax, [gotext2row]
    push ax
    call goposition
    
    push si
    mov ax, gotext2
    push ax
    push word[gotext2length]
    call goprinttext
    

    ; --- VOLUME BUTTON ---
    mov bl, [govolspeakerchar]
    mov bh, [govolspeakercolor]
    
    ; Speaker base
    mov ax, [govolbcol]
    push ax
    mov ax, [govolbrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, [govolblen]
    call goprint
    
    ; Triangle middle
    mov ax, [govoltcol]
    push ax
    mov ax, [govoltrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, 1
    call goprint
    
    ; Triangle bottom
    mov ax, [govoltcol]
    push ax
    mov ax, [govoltbotrow]
    push ax
    call goposition
    mov ax, bx
    mov cx, 1
    call goprint
    
    ; Triangle top
    mov ax, [govoltcol]
    push ax
    mov ax, [govolttoprow]
    push ax
    call goposition
    mov ax, bx
    mov cx, 1
    call goprint
    
    ; --- WAVES ---
    mov bl, [govolwavechar]
    mov bh, [govolwavecolor]
    
    ; Wave 1
    mov ax, [govolw1col]
    push ax 
    mov ax, [govolw1row]
    push ax 
    call goposition 
    mov ax, bx
    mov cx, [govolw1len]
    call goprintvertical
    
    ; Wave 2
    mov ax, [govolw2col]
    push ax 
    mov ax, [govolw2row]
    push ax 
    call goposition 
    mov ax, bx
    mov cx, [govolw2len]
    call goprintvertical
    
    ; Wave 3
    mov ax, [govolw3col]
    push ax 
    mov ax, [govolw3row]
    push ax 
    call goposition 
    mov ax, bx
    mov cx, [govolw3len]
    call goprintvertical

  call print_final_score 

   ; --- KEYBOARD INTERRUPT
 
    
 goreadkey: ;reading b  key press 
    mov ah, 0
    int 16h
	
    cmp al, 'p'
    je gostart
    jmp goreadkey
	gostart:

     call start
	

    mov ax, 0x4C00
    int 21h