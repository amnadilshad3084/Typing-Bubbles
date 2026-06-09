

;DATA
nbgcolorbyte: db 0x00
nvideomembase: dw 0xB800
nscreencols: db 80
nscreensize: dw 4000
nspacechar: db 0x20
ncursoroff: db 0

; SPEED CONTROL
nballoonspeed: dw 5

; Keyboard interrupt data
nkeypressed: db 0

; RANDOM LETTERS 
nletters: db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
nletters_count: dw 26
nrandomcounter: dw 0

; --- SCORE AND TIME DATA ---
nscore: db 'SCORE:'
nscorelength: dw 6
nscorerow: dw 1
nscorecol: dw 1
nscoretextcolor: db 0x0F
ncurrent_score: dw 0

ntime: db 'TIME:'
ntimelength: dw 5
ntimerow: dw 3
ntimecol: dw 1
ntimetextcolor: db 0x0F

; TIMER VARIABLES
ntimer_min: dw 2
ntimer_sec: dw 0
nlast_tick: dw 0


; balloon 1
nb1col: dw 15
nb1row: dw 9
nb1w1len: dw 5
nb1w2len: dw 7
nb1w3len: dw 3
nb1threadlen: dw 2
nb1char: db 0x20
nb1color: db 0xDD
nb1letterchar: db 0x41

nb1lettercolor: db 0xD0
nb1lettercol: dw 17
nb1letterrow: dw 11
nb1threadcol: dw 17
nb1threadrow: dw 15

; balloon 2
nb2col: dw 28
nb2row: dw 2
nb2char: db 0x20
nb2color: db 0xEE

nb2lettercolor: db 0xE0
nb2lettercol: dw 30
nb2letterrow: dw 4
nb2threadcol: dw 30
nb2threadrow: dw 8
nb2letterchar: db 0x42

; balloon 3
nb3col: dw 43
nb3row: dw 12
nb3char: db 0x20
nb3color: db 0xAA

nb3lettercolor: db 0xA0
nb3lettercol: dw 45
nb3letterrow: dw 14
nb3threadcol: dw 45
nb3threadrow: dw 18
nb3letterchar: db 0x43      

; balloon 4
nb4col: dw 59
nb4row: dw 6
nb4char: db 0x20
nb4color: db 0x99

nb4lettercolor: db 0x90
nb4lettercol: dw 61
nb4letterrow: dw 8
nb4threadcol: dw 61
nb4threadrow: dw 12
nb4letterchar: db 0x44

; VOLUME
nvolbcol: dw 1
nvolbrow: dw 23
nvolblen: dw 2
nvoltcol: dw 3
nvoltrow: dw 23
nvolttoprow: dw 22
nvoltbotrow: dw 24
nvolspeakerchar: db 0x20
nvolspeakercolor: db 0xFB
nvolw1col: dw 4
nvolw1row: dw 23
nvolw1len: dw 1
nvolw2col: dw 5
nvolw2row: dw 22
nvolw2len: dw 3
nvolw3col: dw 6
nvolw3row: dw 22
nvolw3len: dw 3
nvolwavechar: db 0x7C
nvolwavecolor: db 0x0F

; thread attributes
nthreadchar: db 0x7C
nthreadcolor: db 0x77

; clearballoons dimensions
nclearheight: dw 8
nclearwidth: dw 7

; respawn settings
nrespawnrow: dw 25
nletteroffset: dw 3
nthreadoffset: dw 6


; --- PROCEDURES ---
; --- POP SOUND PROCEDURE ---
nplay_pop_sound:
    push ax
    push cx
    mov al, 0B6h     ;preparing speaker for sound (controls internal speaker)
	;43h, 42h, 61h =special addresses where sound hardware is
    out 43h, al               ;command to timer chip
    mov ax, 5000      ; Frequency (5000 Hz for pop sound)
    out 42h, al       ; Send low byte
    mov al, ah
    out 42h, al       ; Send high byte
    
    ; Turn ON the speaker
    in al, 61h
    or al, 00000011b  ; Set bits 0 and 1
    out 61h, al
    
    ;  sound playing for a short time
    mov cx, 25000     ; duration of sound
npopdelay:
    loop npopdelay
    
    ; turn off speaker
    in al, 61h
    and al, 11111100b ;clear bits 0 and 1
    out 61h, al
    
    pop cx
    pop ax
    ret
;RANDOM LETTER FUNCTION 
nget_random_letter:
    mov ax, [nrandomcounter]  ;for e.g =0
    add ax, 7 ;ax= 0 + 7 = 7 (add 7 to change it)
    mov [nrandomcounter], ax   ;to save randcouter
    xor dx, dx   ;dx= 0 (clear dx for division)
    mov bx, [nletters_count]    
    div bx    ; to get remainder between 0 and 26 and using that remainder to get a letter
    mov bx, dx
    mov al, [nletters + bx]
    ret
	
; STARS DATA
starchar: db '*'     ;asterisk character
starcolor: db 0x0F        ; White color

; star positions
star1col: dw 5
star1row: dw 10

star2col: dw 15  
star2row: dw 3

star3col: dw 25
star3row: dw 24

star4col: dw 35
star4row: dw 4

star5col: dw 45
star5row: dw 6

star6col: dw 55
star6row: dw 10

star7col: dw 65
star7row: dw 21

star8col: dw 75
star8row: dw 13

star9col: dw 12
star9row: dw 17

star10col: dw 22
star10row: dw 8

star11col: dw 8
star11row: dw 12

star12col: dw 18
star12row: dw 20

star13col: dw 28
star13row: dw 5

star14col: dw 38
star14row: dw 10

star15col: dw 48
star15row: dw 14

star16col: dw 58
star16row: dw 7

star17col: dw 68
star17row: dw 16

star18col: dw 78
star18row: dw 11

star19col: dw 14
star19row: dw 9

star20col: dw 32
star20row: dw 19	
	
	
draw_stars:
    push ax
    push bx
    push si
    
    mov bl, [starchar]
    mov bh, [starcolor]
    
; Star 1
mov ax, [star1col]
push ax
mov ax, [star1row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 2
mov ax, [star2col]
push ax
mov ax, [star2row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 3
mov ax, [star3col]
push ax
mov ax, [star3row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 4
mov ax, [star4col]
push ax
mov ax, [star4row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 5
mov ax, [star5col]
push ax
mov ax, [star5row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 6
mov ax, [star6col]
push ax
mov ax, [star6row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 7
mov ax, [star7col]
push ax
mov ax, [star7row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 8
mov ax, [star8col]
push ax
mov ax, [star8row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 9
mov ax, [star9col]
push ax
mov ax, [star9row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 10
mov ax, [star10col]
push ax
mov ax, [star10row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 11
mov ax, [star11col]
push ax
mov ax, [star11row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 12
mov ax, [star12col]
push ax
mov ax, [star12row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 13
mov ax, [star13col]
push ax
mov ax, [star13row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 14
mov ax, [star14col]
push ax
mov ax, [star14row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 15
mov ax, [star15col]
push ax
mov ax, [star15row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 16
mov ax, [star16col]
push ax
mov ax, [star16row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 17
mov ax, [star17col]
push ax
mov ax, [star17row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 18
mov ax, [star18col]
push ax
mov ax, [star18row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 19
mov ax, [star19col]
push ax
mov ax, [star19row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

; Star 20
mov ax, [star20col]
push ax
mov ax, [star20row]
push ax
call nposition
mov ax, bx
mov cx, 1
call nprint

pop si
pop bx
pop ax
ret

nclrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
nclearing:
    mov word[es:di], ax
    add di, 2
    cmp di, 4000
    jne nclearing
    ret
    
nposition:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [nvideomembase]
    mov es, ax              
    mov al, [nscreencols]
    mul byte [bp+4]
    add ax, [bp+6]        
    shl ax, 1               
    mov si, ax    
    
    pop ax
    pop bp
    ret 4

nvertical:
    push cx 
nverticalline:
    mov [es:di], ax
    add di, 160
    loop nverticalline
    pop cx
    ret

nprintvert:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call nvertical
    pop es
    pop di
    pop ax
    pop bp
    ret

nballoon:
    push cx
nballoonprn:
    mov [es:di], ax
    add di, 2
    loop nballoonprn
    pop cx
    ret

nthread:
    push cx               
nthreadloop:
    mov [es:di], ax       
    add di, 160         
    loop nthreadloop
    pop cx
    ret

nprint:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call nballoon 
    pop es
    pop di
    pop ax
    pop bp
    ret

nfillbackground:
    mov ax, [nvideomembase]
    mov es, ax
    mov di, 0             
    mov cx, [nscreensize]
    mov al, [nspacechar]     
    mov ah, [nbgcolorbyte]
nfillloop:
    mov [es:di], ax
    add di, 2   
    loop nfillloop
    ret 

nprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [nvideomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, 0x0F

nnextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop nnextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

draw_night_screen:
    ; disable blinking to enable all 16 background colors
    mov ax, 1003h
    mov bl, [ncursoroff]
    int 10h
      call nclrscr
    call nfillbackground     
    call draw_stars
    
    ; score print
	ngame_display:      ; subroutine label
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    mov ax, [nscorecol]
    push ax
    mov ax, [nscorerow]
    push ax
    call nposition
    
    push si
    mov ax, nscore
    push ax
    push word [nscorelength]
    call nprinttext

    ; INITIAL SCORE VALUE (0)
    call nprint_score_num
    
    ; time print
    mov ax, [ntimecol]
    push ax
    mov ax, [ntimerow]
    push ax
    call nposition
    
    push si
    mov ax, ntime
    push ax
    push word [ntimelength]
    call nprinttext

    ; INITIAL TIME VALUE (2:00)
    call nprint_time_num

    ; INITIALIZE CLOCK for timer
    mov ax, 0x40
    mov es, ax
    mov ax, [es:0x6c]
    mov [nlast_tick], ax
    
    ; VOLUME speaker base
    mov bl, [nvolspeakerchar]
    mov bh, [nvolspeakercolor]
    
    mov ax, [nvolbcol]
    push ax
    mov ax, [nvolbrow]
    push ax
    call nposition
    mov ax, bx
    mov cx, [nvolblen]
    call nprint
    
    ; triangle middle
    mov ax, [nvoltcol]
    push ax
    mov ax, [nvoltrow]
    push ax
    call nposition
    mov ax, bx
    mov cx, 1
    call nprint
    
    ; triangle bottom
    mov ax, [nvoltcol]
    push ax
    mov ax, [nvoltbotrow]
    push ax
    call nposition
    mov ax, bx
    mov cx, 1
    call nprint
    
    ; triangle top
    mov ax, [nvoltcol]
    push ax
    mov ax, [nvolttoprow]
    push ax
    call nposition
    mov ax, bx
    mov cx, 1
    call nprint
    
    ; WAVES
    mov bl, [nvolwavechar]
    mov bh, [nvolwavecolor]
    
    ; wave 1
    mov ax, [nvolw1col]
    push ax 
    mov ax, [nvolw1row]
    push ax 
    call nposition 
    mov ax, bx
    mov cx, [nvolw1len]
    call nprintvert
    
    ; wave 2
    mov ax, [nvolw2col]
    push ax 
    mov ax, [nvolw2row]
    push ax 
    call nposition 
    mov ax, bx
    mov cx, [nvolw2len]
    call nprintvert
    
    ; wave 3
    mov ax, [nvolw3col]
    push ax 
    mov ax, [nvolw3row]
    push ax 
    call nposition 
    mov ax, bx
    mov cx, [nvolw3len]
    call nprintvert
    
   call draw_stars

    call nget_random_letter
    mov [nb1letterchar], al
    
    call nget_random_letter
    mov [nb2letterchar], al
    
    call nget_random_letter  
    mov [nb3letterchar], al
    
    call nget_random_letter
    mov [nb4letterchar], al

    ; DRAW BALLOONS initially
    call ndraw_balloons
  

;------ BALLOON MOVEMENT ----------
nballoon_loop:

    ; --- TIMER UPDATE CHECK ---
    ; Check BIOS clock area (0040:006C) for ticks
    push ax
    push bx
    push es
    
    mov ax, 0x40
    mov es, ax
    mov ax, [es:0x6c]  ; Read current tick count
    mov bx, [nlast_tick]
    sub ax, bx
    cmp ax, 18         ; Approx 1 second (18.2 ticks)
    jl nskip_timer
    
    ; 1 Second has passed
    mov ax, [es:0x6c]
    mov [nlast_tick], ax ; Reset last tick
    
    ; Decrement Logic
    mov ax, [ntimer_sec]
    cmp ax, 0
    jne ndec_sec
    ; Seconds is 0
    mov ax, [ntimer_min]
    cmp ax, 0
    je ntimer_finished ; 0:00 reached
    dec word [ntimer_min]
    mov word [ntimer_sec], 59
    jmp nupdate_timer_display
    
	ndec_sec:
    dec word [ntimer_sec]
    

nupdate_timer_display:
    call nprint_time_num
    
    ; this checks if timer reached 0;00
    mov ax, [ntimer_min]
    cmp ax, 0
    jne nskip_timer
    mov ax, [ntimer_sec]
    cmp ax, 0
    jne nskip_timer
    
    ; Timer reached 0 so GAME OVER
    jmp draw_gameover_screen  ; jmp to game over screen
	ntimer_finished:
    ; Timer reached 0, game continues or can end here


nskip_timer:
    pop es
    pop bx
    pop ax
    ; --- END TIMER CHECK ---

    ; this whole delay section just wastes time to slow down balloon movement
    mov bx, [nballoonspeed]
nouterloop:
    mov cx, 0xFFFF
ninnerloop:
    dec cx
    jnz ninnerloop
    dec bx
    jnz nouterloop
    
    ; --- KEYBOARD INTERRUPT
    mov ah, 0x01
    int 0x16
    jz nno_key_pressed
    
    mov ah, 0x00
    int 0x16
    mov [nkeypressed], al
	
	  cmp al, 0x20        ; Check if char is Space
    je no_space     ; If Space, jump 
	
	
    
    ; convert lowercase to uppercase
    cmp al, 'a'
    jb nnotlowercase
    cmp al, 'z'
    ja nnotlowercase
    sub al, 32
    mov [nkeypressed], al
    
nnotlowercase:
    ; check balloon 1
    mov al, [nb1letterchar]
    cmp al, [nkeypressed]
    jne ncheck_balloon2
    call nclear_single_balloon1
    jmp nredrawballoons
    
ncheck_balloon2:
    mov al, [nb2letterchar]
    cmp al, [nkeypressed]
    jne ncheck_balloon3
    call nclear_single_balloon2
    jmp nredrawballoons
    
ncheck_balloon3:
    mov al, [nb3letterchar]
    cmp al, [nkeypressed]
    jne ncheck_balloon4
    call nclear_single_balloon3
    jmp nredrawballoons
    
ncheck_balloon4:
    mov al, [nb4letterchar]
    cmp al, [nkeypressed]
    jne nno_key_pressed
    call nclear_single_balloon4
    jmp nredrawballoons


    
nno_key_pressed:
    ;KEYBOARD INTERRUPT  END 
    ;no key pressed so normal code for movement
    call nclearballoons
    ;--------------Balloon 1 moved up by 1 row

        dec word [nb1row]
    dec word [nb1letterrow]
    dec word [nb1threadrow]
    cmp word [nb1row], 1    ;reset when balloon reaches row 1
    jne nnextballoon1
    mov word [nb1row], 25
    mov ax, [nb1row]
    add ax, [nletteroffset]
    mov [nb1letterrow], ax
    mov ax, [nb1row]
    add ax, [nthreadoffset]
    mov [nb1threadrow], ax
    call nget_random_letter
    mov [nb1letterchar], al
nnextballoon1:
    ;balloon 2 up by 1 row
    dec word [nb2row]
    dec word [nb2letterrow]
    dec word [nb2threadrow]
    cmp word [nb2row], 1
    jne nnextballoon2
    mov word [nb2row], 25
    mov ax, [nb2row]
    add ax, [nletteroffset]
    mov [nb2letterrow], ax
    mov ax, [nb2row]
    add ax, [nthreadoffset]
    mov [nb2threadrow], ax
    call nget_random_letter
    mov [nb2letterchar], al
nnextballoon2:

    ; balloon 3 up by 1 row
    dec word [nb3row]
    dec word [nb3letterrow]
    dec word [nb3threadrow]
    cmp word [nb3row], 1
    jne nnextballoon3
    mov word [nb3row], 25
    mov ax, [nb3row]
    add ax, [nletteroffset]
    mov [nb3letterrow], ax
    mov ax, [nb3row]
    add ax, [nthreadoffset]
    mov [nb3threadrow], ax
    call nget_random_letter
    mov [nb3letterchar], al
nnextballoon3:

    ;balloon 4 up by 1 row
    dec word [nb4row]
    dec word [nb4letterrow]
    dec word [nb4threadrow]
    cmp word [nb4row], 1
    jne nnextballoon4
    mov word [nb4row], 25
    mov ax, [nb4row]
    add ax, [nletteroffset]
    mov [nb4letterrow], ax
    mov ax, [nb4row]
    add ax, [nthreadoffset]
    mov [nb4threadrow], ax
    call nget_random_letter
    mov [nb4letterchar], al
nnextballoon4:


nredrawballoons:
  call draw_stars
   ;redraw balloons at new positions
    call ndraw_balloons

    
  ;infinite loop
    jmp nballoon_loop
; ----------  CLEAR BALLOONS ---erase balloons with bgr color

nclearballoons:
    push ax
    push bx
    push cx
    push dx
    

    mov bl, [nspacechar]
    mov bh, [nbgcolorbyte]
    
    ;clear balloon 1 area
    mov dx, [nclearheight]
nclear_b1loop:
    mov ax, [nb1col]
    sub ax, 1
    push ax
    mov ax, [nb1row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b1loop
    
    ;clear balloon 2 area
    mov dx, [nclearheight]
nclear_b2loop:
    mov ax, [nb2col]
    sub ax, 1
    push ax
    mov ax, [nb2row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b2loop
    
    ;clear balloon 3 area
    mov dx, [nclearheight]
nclear_b3loop:
    mov ax, [nb3col]
    sub ax, 1
    push ax
    mov ax, [nb3row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b3loop
    
    ;clear balloon 4 area
    mov dx, [nclearheight]
nclear_b4loop:
    mov ax, [nb4col]
    sub ax, 1
    push ax
    mov ax, [nb4row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b4loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret


;-----------------------------
; DRAW BALLOONS here we redraw all 4 balloons at current positions
;-------------------------------------

    ndraw_balloons:
    ; BALLOON 1
    mov bl, [nb1char]
    mov bh, [nb1color]
    
    ; Row 1
    mov ax, [nb1col]
    push ax
    mov ax, [nb1row]
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w1len]
    call nprint
    
    ; Row 2
    mov ax, [nb1col]
    sub ax, 1
    push ax
    mov ax, [nb1row]
    add ax, 1
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w2len]
    call nprint
    
    ; Row 3
    mov ax, [nb1col]
    sub ax, 1
    push ax
    mov ax, [nb1row]
    add ax, 2
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w2len]
    call nprint
    
    ; Row 4
    mov ax, [nb1col]
    sub ax, 1
    push ax
    mov ax, [nb1row]
    add ax, 3
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w2len]
    call nprint
    
    ; Row 5
    mov ax, [nb1col]
    push ax
    mov ax, [nb1row]
    add ax, 4
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w1len]
    call nprint
    
    ; Row 6
    mov ax, [nb1col]
    add ax, 1
    push ax
    mov ax, [nb1row]
    add ax, 5
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w3len]
    call nprint
    
    ; Thread
    mov bl, [nthreadchar]
    mov bh, [nthreadcolor]
    
    mov ax, [nb1threadcol]
    push ax
    mov ax, [nb1threadrow]
    push ax
    call nposition 
    mov di, si    
    mov ax, bx
    mov cx, [nb1threadlen]
    call nthread
    
    ; Letter
    mov ax, [nb1lettercol]
    push ax
    mov ax, [nb1letterrow]
    push ax
    call nposition 
    mov di, si
    mov al, [nb1letterchar]
    mov ah, [nb1lettercolor]
    mov [es:di], ax
    
    ; BALLOON 2
    mov bl, [nb2char]
    mov bh, [nb2color]
    
    mov ax, [nb2col]
    push ax
    mov ax, [nb2row]
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w1len]
    call nprint
    
    mov ax, [nb2col]
    sub ax, 1
    push ax
    mov ax, [nb2row]
    add ax, 1
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w2len]
    call nprint
    
    mov ax, [nb2col]
    sub ax, 1
    push ax
    mov ax, [nb2row]
    add ax, 2
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w2len]
    call nprint
    
    mov ax, [nb2col]
    sub ax, 1
    push ax
    mov ax, [nb2row]
    add ax, 3
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w2len]
    call nprint
    
    mov ax, [nb2col]
    push ax
    mov ax, [nb2row]
    add ax, 4
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w1len]
    call nprint
    
    mov ax, [nb2col]
    add ax, 1
    push ax
    mov ax, [nb2row]
    add ax, 5
    push ax
    call nposition           
    mov ax, bx
    mov cx, [nb1w3len]
    call nprint
    
    mov bl, [nthreadchar]
    mov bh, [nthreadcolor]
	
	mov ax, [nb1threadcol]
push ax
mov ax, [nb1threadrow]
push ax
call nposition 
mov di, si    
mov ax, bx
mov cx, [nb1threadlen]
call nthread

; Letter
mov ax, [nb1lettercol]
push ax
mov ax, [nb1letterrow]
push ax
call nposition 
mov di, si
mov al, [nb1letterchar]
mov ah, [nb1lettercolor]
mov [es:di], ax

; BALLOON 2
mov bl, [nb2char]
mov bh, [nb2color]

mov ax, [nb2col]
push ax
mov ax, [nb2row]
push ax
call nposition           
mov ax, bx
mov cx, [nb1w1len]
call nprint

mov ax, [nb2col]
sub ax, 1
push ax
mov ax, [nb2row]
add ax, 1
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb2col]
sub ax, 1
push ax
mov ax, [nb2row]
add ax, 2
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb2col]
sub ax, 1
push ax
mov ax, [nb2row]
add ax, 3
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb2col]
push ax
mov ax, [nb2row]
add ax, 4
push ax
call nposition           
mov ax, bx
mov cx, [nb1w1len]
call nprint

mov ax, [nb2col]
add ax, 1
push ax
mov ax, [nb2row]
add ax, 5
push ax
call nposition           
mov ax, bx
mov cx, [nb1w3len]
call nprint

mov bl, [nthreadchar]
mov bh, [nthreadcolor]

mov ax, [nb2threadcol]
push ax
mov ax, [nb2threadrow]
push ax
call nposition 
mov di, si    
mov ax, bx
mov cx, [nb1threadlen]
call nthread

mov ax, [nb2lettercol]
push ax
mov ax, [nb2letterrow]
push ax
call nposition 
mov di, si
mov al, [nb2letterchar]
mov ah, [nb2lettercolor]
mov [es:di], ax

; BALLOON 3
mov bl, [nb3char]
mov bh, [nb3color]

mov ax, [nb3col]
push ax
mov ax, [nb3row]
push ax
call nposition           
mov ax, bx
mov cx, [nb1w1len]
call nprint

mov ax, [nb3col]
sub ax, 1
push ax
mov ax, [nb3row]
add ax, 1
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb3col]
sub ax, 1
push ax
mov ax, [nb3row]
add ax, 2
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb3col]
sub ax, 1
push ax
mov ax, [nb3row]
add ax, 3
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb3col]
push ax
mov ax, [nb3row]
add ax, 4
push ax
call nposition           
mov ax, bx
mov cx, [nb1w1len]
call nprint

mov ax, [nb3col]
add ax, 1
push ax
mov ax, [nb3row]
add ax, 5
push ax
call nposition           
mov ax, bx
mov cx, [nb1w3len]
call nprint

mov bl, [nthreadchar]
mov bh, [nthreadcolor]

mov ax, [nb3threadcol]
push ax
mov ax, [nb3threadrow]
push ax
call nposition 
mov di, si    
mov ax, bx
mov cx, [nb1threadlen]
call nthread

mov ax, [nb3lettercol]
push ax
mov ax, [nb3letterrow]
push ax
call nposition 
mov di, si
mov al, [nb3letterchar]
mov ah, [nb3lettercolor]
mov [es:di], ax

; BALLOON 4
mov bl, [nb4char]
mov bh, [nb4color]

mov ax, [nb4col]
push ax
mov ax, [nb4row]
push ax
call nposition           
mov ax, bx
mov cx, [nb1w1len]
call nprint

mov ax, [nb4col]
sub ax, 1
push ax
mov ax, [nb4row]
add ax, 1
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb4col]
sub ax, 1
push ax
mov ax, [nb4row]
add ax, 2
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb4col]
sub ax, 1
push ax
mov ax, [nb4row]
add ax, 3
push ax
call nposition           
mov ax, bx
mov cx, [nb1w2len]
call nprint

mov ax, [nb4col]
push ax
mov ax, [nb4row]
add ax, 4
push ax
call nposition           
mov ax, bx
mov cx, [nb1w1len]
call nprint

mov ax, [nb4col]
add ax, 1
push ax
mov ax, [nb4row]
add ax, 5
push ax
call nposition           
mov ax, bx
mov cx, [nb1w3len]
call nprint

mov bl, [nthreadchar]
mov bh, [nthreadcolor]

mov ax, [nb4threadcol]
push ax
mov ax, [nb4threadrow]
push ax
call nposition 
mov di, si    
mov ax, bx
mov cx, [nb1threadlen]
call nthread

mov ax, [nb4lettercol]
push ax
mov ax, [nb4letterrow]
push ax
call nposition 
mov di, si
mov al, [nb4letterchar]
mov ah, [nb4lettercolor]
mov [es:di], ax

ret

nclear_single_balloon1:
push ax
push bx
push cx
push dx
call nplay_pop_sound
mov bl, [nspacechar]
mov bh, [nbgcolorbyte]

mov dx, [nclearheight]

nclear_b1_single:
    mov ax, [nb1col]
    sub ax, 1
    push ax
    mov ax, [nb1row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b1_single

    mov word [nb1row], 25
    mov ax, [nb1row]
    add ax, [nletteroffset]
    mov [nb1letterrow], ax
    mov ax, [nb1row]
    add ax, [nthreadoffset]
    mov [nb1threadrow], ax
    call nget_random_letter
    mov [nb1letterchar], al

    add word [ncurrent_score], 10
    call nprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


nclear_single_balloon2:
    push ax
    push bx
    push cx
    push dx
    call nplay_pop_sound
    mov bl, [nspacechar]
    mov bh, [nbgcolorbyte]

    mov dx, [nclearheight]
nclear_b2_single:
    mov ax, [nb2col]
    sub ax, 1
    push ax
    mov ax, [nb2row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b2_single

    mov word [nb2row], 25
    mov ax, [nb2row]
    add ax, [nletteroffset]
    mov [nb2letterrow], ax
    mov ax, [nb2row]
    add ax, [nthreadoffset]
    mov [nb2threadrow], ax
    call nget_random_letter
    mov [nb2letterchar], al

    add word [ncurrent_score], 10
    call nprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


nclear_single_balloon3:
    push ax
    push bx
    push cx
    push dx
    call nplay_pop_sound
    mov bl, [nspacechar]
    mov bh, [nbgcolorbyte]

    mov dx, [nclearheight]
nclear_b3_single:
    mov ax, [nb3col]
    sub ax, 1
    push ax
    mov ax, [nb3row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b3_single

    mov word [nb3row], 25
    mov ax, [nb3row]
    add ax, [nletteroffset]
    mov [nb3letterrow], ax
    mov ax, [nb3row]
    add ax, [nthreadoffset]
    mov [nb3threadrow], ax
    call nget_random_letter
    mov [nb3letterchar], al

    add word [ncurrent_score], 10
    call nprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


nclear_single_balloon4:
    push ax
    push bx
    push cx
    push dx
    call nplay_pop_sound
    mov bl, [nspacechar]
    mov bh, [nbgcolorbyte]

    mov dx, [nclearheight]
nclear_b4_single:
    mov ax, [nb4col]
    sub ax, 1
    push ax
    mov ax, [nb4row]
    add ax, dx
    sub ax, 1
    push ax
    call nposition
    mov ax, bx
    mov cx, [nclearwidth]
    call nprint
    dec dx
    jnz nclear_b4_single

    mov word [nb4row], 25
    mov ax, [nb4row]
    add ax, [nletteroffset]
    mov [nb4letterrow], ax
    mov ax, [nb4row]
    add ax, [nthreadoffset]
    mov [nb4threadrow], ax
    call nget_random_letter
    mov [nb4letterchar], al

    add word [ncurrent_score], 10
    call nprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret
;;;;;;;;;;;; SCORE/TIME ---

; Prints value in current_score next to score:
nprint_score_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es

    ; Calculate position: Row 1, Col (scorecol + scorelength + 1)
    mov ax, [nscorecol]
    add ax, [nscorelength]
    add ax, 1 ; Space
    push ax
    mov ax, [nscorerow]
    push ax
    call nposition
    mov di, si

    mov ax, [nvideomembase]
    mov es, ax

    mov ax, [ncurrent_score]
    mov bx, 10
    mov cx, 0

nget_digits:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne nget_digits

    mov ah, [nscoretextcolor]
nprint_digits:
    pop dx
    add dl, 0x30 ; convert to ascii
    mov al, dl
    mov [es:di], ax
    add di, 2
    loop nprint_digits

    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Prints timer M:SS
nprint_time_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es

    ; Calculate position: Row 3, Col (timecol + timelength + 1)
    mov ax, [ntimecol]
    add ax, [ntimelength]
    add ax, 1
    push ax
    mov ax, [ntimerow]
    push ax
    call nposition
    mov di, si

    mov ax, [nvideomembase]
    mov es, ax

    ; Print Minute
    mov ax, [ntimer_min]
    add al, 0x30
    mov ah, [ntimetextcolor] ; Explicitly reload color (Cyan background)
    mov [es:di], ax
    add di, 2

    ; Print Colon
    mov al, ':'
    mov ah, [ntimetextcolor]
    mov [es:di], ax
    add di, 2

    ; Print Seconds (Tens place)
    mov ax, [ntimer_sec]
    xor dx, dx
    mov bx, 10
    div bx
    ; AX is quotient (tens), DX is remainder (ones)
    add al, 0x30
    mov ah, [ntimetextcolor]
    mov [es:di], ax
    add di, 2

    ; Print Seconds (Ones place)
    mov al, dl
    add al, 0x30
    mov ah, [ntimetextcolor]
    mov [es:di], ax

    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

no_space:

    call draw_ntpause_screen

