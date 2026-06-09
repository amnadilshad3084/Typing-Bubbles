org 0x100

jmp start
%include "nightgm.asm"   
%include "hlp.asm"
%include "diff.asm"
%include "easy.asm"
%include "gameplay.asm"  
%include "hard.asm"  
%include "gpause.asm"
%include "gameover.asm"
%include "ntpause.asm"


;DATA
current_screen: db 0    ; 0=start, 1=night,2=help
  
bgcolorbyte: db 0xBB    ;bgr color attribute(high byte)
videomembase: dw 0xB800  ;base address for video memory ,b800h
screencols: db 80        ;total cols=80
screensize: dw 4000      ;total size 4000
spacechar: db 0x20    ;space ascii
cursoroff: db 0       ;value to disable the blinking cursor,0
;all buttons attribute
buttonsattr: db 0x9F        ; White on blue
;themes button
thememsg: db ' NIGHT THEME (N) '     
themelen: dw 17
themerow: dw 14      
themecol: dw 16

; HELP button
helpmsg: db '    HELP (H)    '       
helplen: dw 16         
helprow: dw 14        
helpcol: dw 42


;DIFFICULTY button 
; difficultymsg: db ' DIFFICULTY (D) '  
; difficultylen: dw 16    
; difficultyrow: dw 19   
; difficultycol: dw 16

; START button
startmsg: db '   START (S)  '     
startlen: dw 14
startrow: dw 19
startcol: dw 30 


;---------  CLOUD-------------
cloudchar: db 0x20    
cloudcolor: db 0xFF       ; White on Cyan 

; Cloud 1 (top left)
cloud1col: dw 4
cloud1row: dw 2

; Cloud 2 (top right)
cloud2col: dw 60
cloud2row: dw 1

; Cloud 3 (middle left)
cloud3col: dw 3
cloud3row: dw 14

; Cloud 4 (middle right)
cloud4col: dw 65
cloud4row: dw 13

;COLOR ATTRIBUTES(char in al,color in ah)
titlechar: db 0x20     ; char for TYPING (space)
titlecolor: db 0x9B     ; color of typing

bubbleschar: db 0x20    ; char for bubbles(space)
bubblescolor: db 0xFB   ; color for bubbles

balloon1char: db 0x20    ; char for balloon 1 (space)
balloon1color: db 0xDD   ; color for balloon 1

balloon2char: db 0x20   ; char for balloon 2 (space)
balloon2color: db 0xEE   ; color for balloon 2
;thread
threadchar: db 0x7C     ; char for thread , |
threadcolor: db 0x77    ; color for balloon thread
;volume
volspeakerchar: db 0x20   ; char for speaker icon (space)
volspeakercolor: db 0xFF  ; color for speaker icon
volwavechar: db 0x7C    ; char for vol wave lines , |
volwavecolor: db 0xB0     ; color for vol wave lines


; T
thcol: dw 16
throw: dw 2
thlen: dw 7
  
tvcol: dw 19
tvrow: dw 3
tvlen: dw 3

; Y
ydlcol: dw 26
ydlrow: dw 2
ydrcol: dw 30
ydrrow: dw 2
ydlen: dw 2
yvcol: dw 28
yvrow: dw 4
yvlen: dw 2

; P
pcol: dw 34
prow: dw 2
pvlen: dw 4
phlen: dw 3
pmrow: dw 4
prvcol: dw 36
prvlen: dw 2

; I
icol: dw  40
irow: dw 2
ihlen: dw 5
ivcol: dw 42
ivrow: dw 3
ivlen: dw 2
ibrow: dw 5

; N
ncol: dw 47 
nrow: dw 2
nvlen: dw 2 
nvmrow: dw 4
ndlen: dw 4 
nrvcol: dw 50 
nrvlen: dw 3 

; G
gvcol: dw 52
gvrow: dw 3
gvlen: dw 2
ghcol: dw 52
ghrow: dw 2
ghlen: dw 5
grhrow: dw 5
grvcol: dw 56
grvrow: dw 4
grvlen: dw 2
gmhcol: dw 55

; B U B B L E S
; B
bcol: dw 17
brow: dw 7            
bvlen: dw 4           
bhlen: dw 4           
bmrow: dw 9           
bbrow: dw 11          
brvcol: dw 20
brvlen: dw 2          

; U
ucol: dw 23
uvlen: dw 5           
urvcol: dw 27
uhlen: dw 4          

; B
b2col: dw 30
b2rvcol: dw 33
b2bh2col: dw 32
b2bh2len: dw 2

b3col: dw 37
b3rvcol: dw 40

; L
lcol: dw 43
lvlen: dw 4           
lhlen: dw 3           

; E
ecol: dw 48
ehlen: dw 4           
emlen: dw 3           

; S
scol: dw 54
shlen: dw 4           
slvlen: dw 3          
srvcol: dw 57
srvlen: dw 2          

; --- BALLOON 1 
b1basecol: dw 69
b1baserow: dw 2
b1w1len: dw 5
b1w2len: dw 7
b1w3len: dw 3
b1threadlen: dw 2

; ---------- BALLOON 2 

b2basecol: dw 69
b2baserow: dw 14    

; --- VOLUME BUTTON

volbcol: dw 2  ;speaker base
volbrow: dw 23 ;speaker base  
volblen: dw 2  ;speaker length
voltcol: dw 1  ;triangle left
voltrow: dw 23 ;triangle left
voltrcol: dw 3 ;triangle top
voltrrow: dw 24 ;triangle top
volbrcol: dw 3  ;triangle bottom
volbrrow: dw 22 ;triangle bottom
volw1col: dw 4  ;wave 1
volw1row: dw 23  ;wave 1
volw1len: dw 1  ; wave 1
volw2col: dw 5   ; wave 2
volw2row: dw 22  ; wave 2
volw2len: dw 3  ; wave 2
volw3col: dw 6   ; wave 3
volw3row: dw 22   ; wave 3
volw3len: dw 3  ; wave 3




; subroutines
;-------- DRAW CLOUD -----
draw_clouds:
    push ax
    push bx
    push cx
    
  
    mov bl, [cloudchar]
    mov bh, [cloudcolor]
    
    ;            CLOUD 1 
   ; Row 1 , top
    mov ax, [cloud1col]
    add ax, 4          
    push ax
    mov ax, [cloud1row]
    push ax
    call position
    mov ax, bx
    mov cx, 6        
    call print
    
    ; Row 2 , upper middle 
    mov ax, [cloud1col]
    add ax, 2         
    push ax
    mov ax, [cloud1row]
    add ax, 1           ; Row + 1
    push ax
    call position
    mov ax, bx
    mov cx, 10          ;Length 10
    call print
    
    ; Row 3 (middle )
    mov ax, [cloud1col] 
    push ax             
    mov ax, [cloud1row]
    add ax, 2        
    push ax
    call position
    mov ax, bx
    mov cx, 14       
    call print
    
    ; Row 4 
    mov ax, [cloud1col]
    add ax, 3        
    push ax
    mov ax, [cloud1row]
    add ax, 3         
    push ax
    call position
    mov ax, bx
    mov cx, 8          
    call print
    
    ;CLOUD 2
	
	    mov ax, [cloud2col]
    add ax, 5
    push ax
    mov ax, [cloud2row]
    push ax
    call position
    mov ax, bx
    mov cx, 7
    call print
    
    ; Row 2
    mov ax, [cloud2col]
    add ax, 2
    push ax
    mov ax, [cloud2row]
    add ax, 1
    push ax
    call position
    mov ax, bx
    mov cx, 13
    call print
    
    ; Row 3
    mov ax, [cloud2col]
    push ax
    mov ax, [cloud2row]
    add ax, 2
    push ax
    call position
    mov ax, bx
    mov cx, 17
    call print
    
    ; Row 4
    mov ax, [cloud2col]
    add ax, 4
    push ax
    mov ax, [cloud2row]
    add ax, 3
    push ax
    call position
    mov ax, bx
    mov cx, 9
    call print
    
    ; CLOUD 3
    ; Row 1
    mov ax, [cloud3col]
    add ax, 2
    push ax
    mov ax, [cloud3row]
    push ax
    call position
    mov ax, bx
    mov cx, 4
    call print
    
    ; Row 2
    mov ax, [cloud3col]
    push ax
    mov ax, [cloud3row]
    add ax, 1
    push ax
    call position
    mov ax, bx
    mov cx, 8
    call print
    
    ; Row 3
    mov ax, [cloud3col]
    add ax, 1
    push ax
    mov ax, [cloud3row]
    add ax, 2
    push ax
    call position
    mov ax, bx
    mov cx, 6
    call print
    
    ; CLOUD 4
    ; Row 1
    mov ax, [cloud4col]
    add ax, 2
    push ax
    mov ax, [cloud4row]
    push ax
    call position
    mov ax, bx
    mov cx, 5
    call print
    
    ; Row 2
    mov ax, [cloud4col]
    push ax
    mov ax, [cloud4row]
    add ax, 1
    push ax
    call position
    mov ax, bx
    mov cx, 9
    call print
    
    ; Row 3
    mov ax, [cloud4col]
    add ax, 2
    push ax
    mov ax, [cloud4row]
    add ax, 2
    push ax
    call position
    mov ax, bx
    mov cx, 5
    call print
    
    pop cx
    pop bx
    pop ax
    ret

print:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call balloon 
    pop es
    pop di
    pop ax
    pop bp
    ret

clrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
clearing:
    mov word[es:di], ax
    add di, 2
    cmp di, 4000
    jne clearing
    ret
    
position:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [videomembase]
    mov es, ax         
    mov al, [screencols]
    mul byte [bp+4] 
    add ax, [bp+6]           
    shl ax, 1                
    mov si, ax       
    
    pop ax
    pop bp
    ret 4

horizontal:
    push cx 
horizontalline:
    mov [es:di], ax
    add di,2
    loop horizontalline
    pop cx
    ret

vertical:
    push cx 
verticalline:
    mov [es:di], ax
    add di,160
    loop verticalline
    pop cx
    ret

diagonal:
    push cx 
diagonalline:
    mov [es:di], ax
    add di,160
    add di,2
    loop diagonalline
    pop cx
    ret

oppdiagonal:
    push cx 
diagonalopposite:
    mov [es:di], ax
    add di,160
    sub di,2
    loop diagonalopposite
    pop cx
    ret

printhorizon:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call horizontal
    pop es
    pop di
    pop ax
    pop bp
    ret

printvert:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call vertical
    pop es
    pop di
    pop ax
    pop bp
    ret

printdiagonal:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call diagonal
    pop es
    pop di
    pop ax
    pop bp
    ret

printoppdiagonal:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call oppdiagonal
    pop es
    pop di
    pop ax
    pop bp
    ret

balloon:
    push cx 
balloonprn:
    mov [es:di], ax
    add di,2
    loop balloonprn
    pop cx
    ret
    
thread:
    push cx           
threadloop:
    mov [es:di], ax    
    add di, 160     
    loop threadloop
    pop cx
    ret

printballoon:
    push bp
    mov bp,sp
    push ax
    push di
    push es
    mov di,si
    call balloon
    pop es
    pop di
    pop ax
    pop bp
    ret

printbutton:
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
	mov ah, [buttonsattr]

nextchar1:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop nextchar1

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

fillbackground:
    mov ax, [videomembase]
    mov es, ax
    mov di, 0         
    mov cx, [screensize]

    mov al, [spacechar]        
    mov ah, [bgcolorbyte]

fillloop:
    mov [es:di], ax
    add di, 2   
    loop fillloop
    ret 

start:
    ;disable blinking to enable all 16 background colors
    mov ax, 1003h  ;10h and 03h=Get cursor position and shape
    mov bl, [cursoroff]   ;blinkingoff
    int 10h
    call clrscr
    call fillbackground    
	call draw_clouds

;putting title color in bx(will remain same throughout)
    mov bl, [titlechar]
    mov bh, [titlecolor]
    
    ; T
    mov ax, [thcol]
    push ax
    mov ax, [throw]
    push ax
    call position
    mov ax, bx
    mov cx, [thlen]
    call printhorizon
    
    mov ax, [tvcol]
    push ax
    mov ax, [tvrow]
    push ax
    call position
    mov ax, bx
    mov cx, [tvlen]
    call printvert

    ; --- Y ---
    mov ax, [ydlcol]
    push ax
    mov ax, [ydlrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ydlen]
    call printdiagonal
    
    mov ax, [ydrcol]
    push ax
    mov ax, [ydrrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ydlen]
    call printoppdiagonal
    
    mov ax, [yvcol]
    push ax
    mov ax, [yvrow]
    push ax
    call position
    mov ax, bx
    mov cx, [yvlen]
    call printvert

    ; --- P ---
    mov ax, [pcol]
    push ax
    mov ax, [prow]
    push ax
    call position
    mov ax, bx
    mov cx, [pvlen]
    call printvert
    
    mov ax, [pcol]
    push ax
    mov ax, [prow]
    push ax
    call position
    mov ax, bx
    mov cx, [phlen]
    call printhorizon
    
    mov ax, [pcol]
    push ax
    mov ax, [pmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [phlen]
    call printhorizon
    
    mov ax, [prvcol]
    push ax
    mov ax, [prow]
    push ax
    call position
    mov ax, bx
    mov cx, [prvlen]
    call printvert

    ; --- I ---
    mov ax, [icol]
    push ax
    mov ax, [irow]
    push ax
    call position
    mov ax, bx
    mov cx, [ihlen]
    call printhorizon
    
    mov ax, [ivcol]
    push ax
    mov ax, [ivrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ivlen]
    call printvert
    
    mov ax, [icol]
    push ax
    mov ax, [ibrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ihlen]
    call printhorizon

    ; --- N ---
    mov ax, [ncol]
    push ax
    mov ax, [nrow]
    push ax
    call position
    mov ax, bx
    mov cx, [nvlen]
    call printvert
    
    mov ax, [ncol]
    push ax
    mov ax, [nvmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [nvlen]
    call printvert
    
    mov ax, [ncol]
    push ax
    mov ax, [nrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ndlen]
    call printdiagonal
    
    mov ax, [nrvcol]
    push ax
    mov ax, [nrow]
    push ax
    call position
    mov ax, bx
    mov cx, [nrvlen]
    call printvert
    
    ; --- G ---
    mov ax, [gvcol]
    push ax
    mov ax, [gvrow]
    push ax
    call position
    mov ax, bx
    mov cx, [gvlen]
    call printvert
    
    mov ax, [ghcol]
    push ax
    mov ax, [ghrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ghlen]
    call printhorizon
    
    mov ax, [ghcol]
    push ax
    mov ax, [grhrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ghlen]
    call printhorizon
    
    mov ax, [grvcol]
    push ax
    mov ax, [grvrow]
    push ax
    call position
    mov ax, bx
    mov cx, [grvlen]
    call printvert
    
    mov ax, [gmhcol]
    push ax
    mov ax, [grvrow]
    push ax
    call position
    mov ax, bx
    mov cx, [grvlen]
    call printhorizon

    ; Load BUBBLES color into BX
    mov bl, [bubbleschar]
    mov bh, [bubblescolor]

    ; --- B1 ---
    mov ax, [bcol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [bvlen]
    call printvert
    
    mov ax, [bcol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [bhlen]
    call printhorizon
    
    mov ax, [bcol]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [bhlen]
    call printhorizon
    
    mov ax, [bcol]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [bhlen]
    call printhorizon
    
    mov ax, [brvcol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printvert
    
    mov ax, [brvcol]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printvert

    ; --- U ---
    mov ax, [ucol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [uvlen]
    call printvert
    
    mov ax, [urvcol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [uvlen]
    call printvert
    
    mov ax, [ucol]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [uhlen]
    call printhorizon

    ; --- B2 ---
    mov ax, [b2col]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [bvlen]
    call printvert
    
    mov ax, [b2col]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [bhlen]
    call printhorizon
    
    mov ax, [b2col]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [bhlen]
    call printhorizon
    
    mov ax, [b2col]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printhorizon
    
    mov ax, [b2bh2col]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [b2bh2len]
    call printhorizon
    
    mov ax, [b2rvcol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printvert
    
    mov ax, [b2rvcol]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printvert

    ; --- B3 ---
    mov ax, [b3col]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [bvlen]
    call printvert
    
    mov ax, [b3col]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [bhlen]
    call printhorizon
    
    mov ax, [b3col]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [bhlen]
    call printhorizon
    
    mov ax, [b3col]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printhorizon
    
    mov ax, [b2bh2col]
    add ax, [b3col]
    sub ax, [b2col]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [b2bh2len]
    call printhorizon
    
    mov ax, [b3rvcol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printvert
    
    mov ax, [b3rvcol]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [brvlen]
    call printvert
    
    ; --- L ---
    mov ax, [lcol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [lvlen]
    call printvert
    
    mov ax, [lcol]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [lhlen]
    call printhorizon

    ; --- E ---
    mov ax, [ecol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [bvlen]
    call printvert
    
    mov ax, [ecol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [ehlen]
    call printhorizon
    
    mov ax, [ecol]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [emlen]
    call printhorizon
    
    mov ax, [ecol]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [ehlen]
    call printhorizon

    ; --- S ---
    mov ax, [scol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [shlen]
    call printhorizon
    
    mov ax, [scol]
    push ax
    mov ax, [brow]
    push ax
    call position
    mov ax, bx
    mov cx, [slvlen]
    call printvert
    
    mov ax, [scol]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [shlen]
    call printhorizon
    
    mov ax, [srvcol]
    push ax
    mov ax, [bmrow]
    push ax
    call position
    mov ax, bx
    mov cx, [srvlen]
    call printvert
    
    mov ax, [scol]
    push ax
    mov ax, [bbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [shlen]
    call printhorizon

    ; BALLOON 1
    mov bl, [balloon1char]
    mov bh, [balloon1color]
    
    mov ax, [b1basecol] ;topcol
    push ax
    mov ax, [b1baserow] ;top row
    push ax
    call position
    mov ax, bx ;char and color of ballon moved to ax
	
    mov cx, [b1w1len]
    call printballoon
    
    mov ax, [b1basecol]
    sub ax, 1
    push ax
    mov ax, [b1baserow]
    add ax, 1
    push ax
    call position
    mov ax, bx
    mov cx, [b1w2len]
    call printballoon
    
    mov ax, [b1basecol]
    sub ax, 1
    push ax
    mov ax, [b1baserow]
    add ax, 2
    push ax
    call position
    mov ax, bx
    mov cx, [b1w2len]
    call printballoon
    
    mov ax, [b1basecol]
    sub ax, 1
    push ax
    mov ax, [b1baserow]
    add ax, 3
    push ax
    call position
    mov ax, bx
    mov cx, [b1w2len]
    call printballoon
    
    mov ax, [b1basecol]
    push ax
    mov ax, [b1baserow]
    add ax, 4
    push ax
    call position
    mov ax, bx
    mov cx, [b1w1len]
    call printballoon
    
    mov ax, [b1basecol]
    add ax, 1
    push ax
    mov ax, [b1baserow]
    add ax, 5
    push ax
    call position
    mov ax, bx
    mov cx, [b1w3len]
    call printballoon
    
    ; Thread 1
    mov bl, [threadchar]
    mov bh, [threadcolor]
    
    mov ax, [b1basecol]
    add ax, 2
    push ax
    mov ax, [b1baserow]
    add ax, 6
    push ax
    call position
    mov ax, bx
    mov di, si
    mov cx, [b1threadlen]
    call thread

    ; --- BALLOON 2 ---
    mov bl, [balloon2char]
    mov bh, [balloon2color]
    
    mov ax, [b2basecol]
    push ax
    mov ax, [b2baserow]
    push ax
    call position
    mov ax, bx
    mov cx, [b1w1len]
    call printballoon
    
    mov ax, [b2basecol]
    sub ax, 1
    push ax
    mov ax, [b2baserow]
    add ax, 1
    push ax
    call position
    mov ax, bx
    mov cx, [b1w2len]
    call printballoon
    
    mov ax, [b2basecol]
    sub ax, 1
    push ax
    mov ax, [b2baserow]
    add ax, 2
    push ax
    call position
    mov ax, bx
    mov cx, [b1w2len]
    call printballoon
    
    mov ax, [b2basecol]
    sub ax, 1
    push ax
    mov ax, [b2baserow]
    add ax, 3
    push ax
    call position
    mov ax, bx
    mov cx, [b1w2len]
    call printballoon
    
    mov ax, [b2basecol]
    push ax
    mov ax, [b2baserow]
    add ax, 4
    push ax
    call position
    mov ax, bx
    mov cx, [b1w1len]
    call printballoon
    
    mov ax, [b2basecol]
    add ax, 1
    push ax
    mov ax, [b2baserow]
    add ax, 5
    push ax
    call position
    mov ax, bx
    mov cx, [b1w3len]
    call printballoon
    
    ; Thread 2
    mov bl, [threadchar]
    mov bh, [threadcolor]
    
    mov ax, [b2basecol]
    add ax, 2
    push ax
    mov ax, [b2baserow]
    add ax, 6
    push ax
    call position
    mov ax, bx
    mov di, si
    mov cx, [b1threadlen]
    call thread
	
	;themecol    
	mov ax, [themecol]
    push ax
    mov ax, [themerow]
    push ax
    call position
    push si
    mov ax, thememsg
    push ax
    push word [themelen]
	
    call printbutton
	

    ;START button

    mov ax, [startcol]
    push ax
    mov ax, [startrow]
    push ax
    call position
    push si
    mov ax, startmsg
    push ax
    push word [startlen]
	
    call printbutton
	

    ; HELP button  
    mov ax, [helpcol]
    push ax
    mov ax, [helprow]
    push ax
    call position
    push si
    mov ax, helpmsg
    push ax
    push word [helplen]
    call printbutton

    ; ; DIFFICULTY button
    ; mov ax, [difficultycol]
    ; push ax
    ; mov ax, [difficultyrow]
    ; push ax
    ; call position
    ; push si
    ; mov ax, difficultymsg
    ; push ax
    ; push word [difficultylen]
    ; call printbutton
	;EXIT 

    mov ax, [startcol]
    push ax
    mov ax, [startrow]
    push ax
    call position
    push si
    mov ax, startmsg
    push ax
    push word [startlen]
    call printbutton
	
	

    ; --- VOLUME BUTTON ---
    mov bl, [volspeakerchar]
    mov bh, [volspeakercolor]
    
    ; speaker base
    mov ax, [volbcol]
    push ax
    mov ax, [volbrow]
    push ax
    call position
    mov ax, bx
    mov cx, [volblen]
    call printballoon
    
    ; triangle shape
    mov ax, [voltcol]
    push ax
    mov ax, [voltrow]
    push ax
    call position
    mov ax, bx
    mov cx, 1
    call printballoon
    
    mov ax, [voltrcol]
    push ax
    mov ax, [voltrrow]
    push ax
    call position
    mov ax, bx
    mov cx, 1
    call printballoon
    
    mov ax, [volbrcol]
    push ax
    mov ax, [volbrrow]
    push ax
    call position
    mov ax, bx
    mov cx, 1
    call printballoon

    ; WAVES
    mov bl, [volwavechar]
    mov bh, [volwavecolor]
    
    mov ax, [volw1col]
    push ax
    mov ax, [volw1row]
    push ax
    call position
    mov ax, bx
    mov cx, [volw1len]
    call printvert
    
    mov ax, [volw2col]
    push ax
    mov ax, [volw2row]
    push ax
    call position
    mov ax, bx
    mov cx, [volw2len]
    call printvert
    
    mov ax, [volw3col]
    push ax
    mov ax, [volw3row]
    push ax
    call position
    mov ax, bx
    mov cx, [volw3len]
    call printvert
    
    main_loop:
    ; keypress
    mov ah, 0x00
    int 0x16
    
    ;convert to lowercase
    ; cmp al, 'A'
    ; jb check_key
	
    ; cmp al, 'Z'
    ; ja check_key
    ; add al, 32      ; convert to lowercase

 check_key:
 cmp al, 'n'        
 je go_night

 cmp al, 'h' 
 je go_help
 
  cmp al,'s'  
 je go_difficulty
 
  ; ; mov ah, 0
    ; ; int 16h
   ; cmp al,'m'  
 ; je go_gameplay
 
jmp main_loop

go_night:
    mov byte [current_screen], 1
    call draw_night_screen
    jmp main_loop

go_help:
    mov byte [current_screen], 2
	call clrscr          
    call fillbackground 
    call draw_help_screen
    jmp main_loop

	go_difficulty:
    mov byte [current_screen], 3
	call clrscr          
    call fillbackground 
    call draw_difficulty_screen
ending:
