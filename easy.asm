

; org 0x100
; jmp draw_gameplay_screen

;DATA
ebgcolorbyte: db 0xBB
evideomembase: dw 0xB800
escreencols: db 80
escreensize: dw 4000
espacechar: db 0x20
ecursoroff: db 0

; SPEED CONTROL
eballoonspeed: dw 8

;----------  CLOUD-------------
ecloudchar: db 0x20     
ecloudcolor: db 0xFF

; Cloud 1
ecloud1col: dw 8
ecloud1row: dw 7

; Cloud 2
ecloud2col: dw 52
ecloud2row: dw 5

; Cloud 3
ecloud3col: dw 3
ecloud3row: dw 14

; Cloud 4
ecloud4col: dw 62
ecloud4row: dw 17

; Cloud 5
ecloud5col: dw 35
ecloud5row: dw 20

; Keyboard interrupt data
ekeypressed: db 0

; RANDOM LETTERS 
eletters: db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
eletters_count: dw 26
erandomcounter: dw 0

; --- SCORE AND TIME DATA ---
escore: db 'SCORE:'
escorelength: dw 6
escorerow: dw 1
escorecol: dw 1
escoretextcolor: db 0xB0
ecurrent_score: dw 0

etime: db 'TIME:'
etimelength: dw 5
etimerow: dw 3
etimecol: dw 1
etimetextcolor: db 0xB0

; TIMER VARIABLES
etimer_min: dw 2
etimer_sec: dw 0
elast_tick: dw 0


; balloon 1
eb1col: dw 15
eb1row: dw 9
eb1w1len: dw 5
eb1w2len: dw 7
eb1w3len: dw 3
eb1threadlen: dw 2
eb1char: db 0x20
eb1color: db 0xDD
eb1letterchar: db 0x41

eb1lettercolor: db 0xD0
eb1lettercol: dw 17
eb1letterrow: dw 11
eb1threadcol: dw 17
eb1threadrow: dw 15

; balloon 2
eb2col: dw 28
eb2row: dw 2
eb2char: db 0x20
eb2color: db 0xEE

eb2lettercolor: db 0xE0
eb2lettercol: dw 30
eb2letterrow: dw 4
eb2threadcol: dw 30
eb2threadrow: dw 8
eb2letterchar: db 0x42

; balloon 3
eb3col: dw 43
eb3row: dw 12
eb3char: db 0x20
eb3color: db 0xAA

eb3lettercolor: db 0xA0
eb3lettercol: dw 45
eb3letterrow: dw 14
eb3threadcol: dw 45
eb3threadrow: dw 18
eb3letterchar: db 0x43      

; balloon 4
eb4col: dw 59
eb4row: dw 6
eb4char: db 0x20
eb4color: db 0x99

eb4lettercolor: db 0x90
eb4lettercol: dw 61
eb4letterrow: dw 8
eb4threadcol: dw 61
eb4threadrow: dw 12
eb4letterchar: db 0x44

; VOLUME
evolbcol: dw 1
evolbrow: dw 23
evolblen: dw 2
evoltcol: dw 3
evoltrow: dw 23
evolttoprow: dw 22
evoltbotrow: dw 24
evolspeakerchar: db 0x20
evolspeakercolor: db 0xFB
evolw1col: dw 4
evolw1row: dw 23
evolw1len: dw 1
evolw2col: dw 5
evolw2row: dw 22
evolw2len: dw 3
evolw3col: dw 6
evolw3row: dw 22
evolw3len: dw 3
evolwavechar: db 0x7C
evolwavecolor: db 0xB0

; thread attributes
ethreadchar: db 0x7C
ethreadcolor: db 0x77

; clearballoons dimensions
eclearheight: dw 8
eclearwidth: dw 7

; respawn settings
erespawnrow: dw 25
eletteroffset: dw 3
ethreadoffset: dw 6


; --- PROCEDURES ---
; --- POP SOUND PROCEDURE ---
eplay_pop_sound:
    push ax
    push cx
    mov al, 0B6h
    out 43h, al
    mov ax, 5000
    out 42h, al
    mov al, ah
    out 42h, al
    in al, 61h
    or al, 00000011b
    out 61h, al
    mov cx, 25000
epopdelay:
    loop epopdelay
    in al, 61h
    and al, 11111100b
    out 61h, al
    pop cx
    pop ax
    ret
;RANDOM LETTER FUNCTION 
eget_random_letter:
    mov ax, [erandomcounter]
    add ax, 7
    mov [erandomcounter], ax
    xor dx, dx
    mov bx, [eletters_count]
    div bx
    mov bx, dx
    mov al, [eletters + bx]
    ret

;-------- DRAW CLOUD -----
edraw_clouds:
    push ax
    push bx
    push cx
    
    mov bl, [ecloudchar]
    mov bh, [ecloudcolor]
    
  ;            CLOUD 1 
; Row 1
mov ax, [ecloud1col]
add ax, 4
push ax
mov ax, [ecloud1row]
push ax
call eposition
mov ax, bx
mov cx, 6
call eprint

; Row 2
mov ax, [ecloud1col]
add ax, 2
push ax
mov ax, [ecloud1row]
add ax, 1
push ax
call eposition
mov ax, bx
mov cx, 10
call eprint

; Row 3
mov ax, [ecloud1col] 
push ax
mov ax, [ecloud1row]
add ax, 2
push ax
call eposition
mov ax, bx
mov cx, 14
call eprint

; Row 4
mov ax, [ecloud1col]
add ax, 3
push ax
mov ax, [ecloud1row]
add ax, 3
push ax
call eposition
mov ax, bx
mov cx, 8
call eprint

; ============ CLOUD 2 ============

; Row 1
mov ax, [ecloud2col]
add ax, 5
push ax
mov ax, [ecloud2row]
push ax
call eposition
mov ax, bx
mov cx, 7
call eprint

; Row 2
mov ax, [ecloud2col]
add ax, 2
push ax
mov ax, [ecloud2row]
add ax, 1
push ax
call eposition
mov ax, bx
mov cx, 13
call eprint

; Row 3
mov ax, [ecloud2col]
push ax
mov ax, [ecloud2row]
add ax, 2
push ax
call eposition
mov ax, bx
mov cx, 17
call eprint

; Row 4
mov ax, [ecloud2col]
add ax, 4
push ax
mov ax, [ecloud2row]
add ax, 3
push ax
call eposition
mov ax, bx
mov cx, 9
call eprint

; ============ CLOUD 3 ============    

; Row 1
mov ax, [ecloud3col]
add ax, 2
push ax
mov ax, [ecloud3row]
push ax
call eposition
mov ax, bx
mov cx, 3
call eprint

; Row 2
mov ax, [ecloud3col]
push ax
mov ax, [ecloud3row]
add ax, 1
push ax
call eposition
mov ax, bx
mov cx, 7
call eprint

; Row 3
mov ax, [ecloud3col]
add ax, 1
push ax
mov ax, [ecloud3row]
add ax, 2
push ax
call eposition
mov ax, bx
mov cx, 5
call eprint

; ============ CLOUD 4 ============    

; Row 1
mov ax, [ecloud4col]
add ax, 2
push ax
mov ax, [ecloud4row]
push ax
call eposition
mov ax, bx
mov cx, 5
call eprint

; Row 2
mov ax, [ecloud4col]
push ax
mov ax, [ecloud4row]
add ax, 1
push ax
call eposition
mov ax, bx
mov cx, 9
call eprint

; Row 3
mov ax, [ecloud4col]
add ax, 2
push ax
mov ax, [ecloud4row]
add ax, 2
push ax
call eposition
mov ax, bx
mov cx, 5
call eprint

; ============ CLOUD 5 ============    

; Row 1
mov ax, [ecloud5col]
add ax, 3
push ax
mov ax, [ecloud5row]
push ax
call eposition
mov ax, bx
mov cx, 6
call eprint

; Row 2
mov ax, [ecloud5col]
add ax, 1
push ax
mov ax, [ecloud5row]
add ax, 1
push ax
call eposition
mov ax, bx
mov cx, 10
call eprint

; Row 3
mov ax, [ecloud5col]
push ax
mov ax, [ecloud5row]
add ax, 2
push ax
call eposition
mov ax, bx
mov cx, 12
call eprint

; Row 4
mov ax, [ecloud5col]
add ax, 2
push ax
mov ax, [ecloud5row]
add ax, 3
push ax
call eposition
mov ax, bx
mov cx, 8
call eprint

pop cx
pop bx
pop ax
ret

eclrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
eclearing:
    mov word[es:di], ax
    add di, 2
    cmp di, 4000
    jne eclearing
    ret


    
eposition:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [evideomembase]
    mov es, ax              
    mov al, [escreencols]
    mul byte [bp+4]
    add ax, [bp+6]        
    shl ax, 1               
    mov si, ax    
    
    pop ax
    pop bp
    ret 4

evertical:
    push cx 
everticalline:
    mov [es:di], ax
    add di, 160
    loop everticalline
    pop cx
    ret

eprintvert:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call evertical
    pop es
    pop di
    pop ax
    pop bp
    ret

eballoon:
    push cx
eballoonprn:
    mov [es:di], ax
    add di, 2
    loop eballoonprn
    pop cx
    ret

ethread:
    push cx               
ethreadloop:
    mov [es:di], ax       
    add di, 160         
    loop ethreadloop
    pop cx
    ret

eprint:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call eballoon 
    pop es
    pop di
    pop ax
    pop bp
    ret

efillbackground:
    mov ax, [evideomembase]
    mov es, ax
    mov di, 0             
    mov cx, [escreensize]
    mov al, [espacechar]     
    mov ah, [ebgcolorbyte]
efillloop:
    mov [es:di], ax
    add di, 2   
    loop efillloop
    ret 

eprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [evideomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, 0xB0

enextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop enextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

draw_easy_screen:
  ; disable blinking to enable all 16 background colors
mov ax, 1003h
mov bl, [ecursoroff]
int 10h
call eclrscr
call efillbackground     
call edraw_clouds

; score print
mov ax, [escorecol]
push ax
mov ax, [escorerow]
push ax
call eposition

push si
mov ax, escore
push ax
push word [escorelength]
call eprinttext

; INITIAL SCORE VALUE (0)
call eprint_score_num

; time print
mov ax, [etimecol]
push ax
mov ax, [etimerow]
push ax
call eposition

push si
mov ax, etime
push ax
push word [etimelength]
call eprinttext

; INITIAL TIME VALUE (2:00)
call eprint_time_num

; INITIALIZE CLOCK for timer
mov ax, 0x40
mov es, ax
mov ax, [es:0x6c]
mov [elast_tick], ax

; VOLUME speaker base
mov bl, [evolspeakerchar]
mov bh, [evolspeakercolor]

mov ax, [evolbcol]
push ax
mov ax, [evolbrow]
push ax
call eposition
mov ax, bx
mov cx, [evolblen]
call eprint

; triangle middle
mov ax, [evoltcol]
push ax
mov ax, [evoltrow]
push ax
call eposition
mov ax, bx
mov cx, 1
call eprint

; triangle bottom
mov ax, [evoltcol]
push ax
mov ax, [evoltbotrow]
push ax
call eposition
mov ax, bx
mov cx, 1
call eprint

; triangle top
mov ax, [evoltcol]
push ax
mov ax, [evolttoprow]
push ax
call eposition
mov ax, bx
mov cx, 1
call eprint

; WAVES
mov bl, [evolwavechar]
mov bh, [evolwavecolor]

; wave 1
mov ax, [evolw1col]
push ax 
mov ax, [evolw1row]
push ax 
call eposition 
mov ax, bx
mov cx, [evolw1len]
call eprintvert

; wave 2
mov ax, [evolw2col]
push ax 
mov ax, [evolw2row]
push ax 
call eposition 
mov ax, bx
mov cx, [evolw2len]
call eprintvert

; wave 3
mov ax, [evolw3col]
push ax 
mov ax, [evolw3row]
push ax 
call eposition 
mov ax, bx
mov cx, [evolw3len]
call eprintvert

call edraw_clouds   ; cloud

call eget_random_letter
mov [eb1letterchar], al

call eget_random_letter
mov [eb2letterchar], al

call eget_random_letter  
mov [eb3letterchar], al

call eget_random_letter
mov [eb4letterchar], al


    ; DRAW BALLOONS initially
    call edraw_balloons
;------ BALLOON MOVEMENT ----------
eballoon_loop:

    ; --- TIMER UPDATE CHECK ---
    ; Check BIOS clock area (0040:006C) for ticks
    push ax
    push bx
    push es
    
    mov ax, 0x40
    mov es, ax
    mov ax, [es:0x6c]  ; Read current tick count
    mov bx, [elast_tick]
    sub ax, bx
    cmp ax, 18         ; Approx 1 second (18.2 ticks)
    jl eskip_timer
    
    ; 1 Second has passed
    mov ax, [es:0x6c]
    mov [elast_tick], ax ; Reset last tick
    
    ; Decrement Logic
    mov ax, [etimer_sec]
    cmp ax, 0
    jne edec_sec
    ; Seconds is 0
    mov ax, [etimer_min]
    cmp ax, 0
    je etimer_finished ; 0:00 reached
    dec word [etimer_min]
    mov word [etimer_sec], 59
    jmp eupdate_timer_display
    
	edec_sec:
    dec word [etimer_sec]
    
eupdate_timer_display:
    call eprint_time_num
    
    ; this checks if timer reached 0;00
    mov ax, [etimer_min]
    cmp ax, 0
    jne eskip_timer
    mov ax, [etimer_sec]
    cmp ax, 0
    jne eskip_timer
    
    ; Timer reached 0 so GAME OVER
    jmp draw_gameover_screen  ; jmp to game over screen
    
etimer_finished:
    ; Timer reached 0, game continues or can end here
eskip_timer:
    pop es
    pop bx
    pop ax
    ; --- END TIMER CHECK ---

    ; this whole delay section just wastes time to slow down balloon movement
    mov bx, [eballoonspeed]
eouterloop:
    mov cx, 0xFFFF
einnerloop:
    dec cx
    jnz einnerloop
    dec bx
    jnz eouterloop
    
    ; --- KEYBOARD INTERRUPT
    mov ah, 0x01
    int 0x16
    jz eno_key_pressed
    
    mov ah, 0x00
    int 0x16
    mov [ekeypressed], al
	
	
	  cmp al, 0x20        ; Check if char is Space
    je go_espace     ; If Space, jump 
    
    ; convert lowercase to uppercase
    cmp al, 'a'
    jb enotlowercase
    cmp al, 'z'
    ja enotlowercase
    sub al, 32
    mov [ekeypressed], al
    
enotlowercase:
    ; check balloon 1
    mov al, [eb1letterchar]
    cmp al, [ekeypressed]
    jne echeck_balloon2
    call eclear_single_balloon1
    jmp eredrawballoons
    
echeck_balloon2:
    mov al, [eb2letterchar]
    cmp al, [ekeypressed]
    jne echeck_balloon3
    call eclear_single_balloon2
    jmp eredrawballoons
    
echeck_balloon3:
    mov al, [eb3letterchar]
    cmp al, [ekeypressed]
    jne echeck_balloon4
    call eclear_single_balloon3
    jmp eredrawballoons
    
echeck_balloon4:
    mov al, [eb4letterchar]
    cmp al, [ekeypressed]
    jne eno_key_pressed
    call eclear_single_balloon4
    jmp eredrawballoons

eno_key_pressed:



    ;KEYBOARD INTERRUPT  END 
  ;no key pressed so normal code for movement
    call eclearballoons
    ;--------------Balloon 1 moved up by 1 row

        dec word [eb1row]
    dec word [eb1letterrow]
    dec word [eb1threadrow]
    cmp word [eb1row], 1    ;reset when balloon reaches row 1
    jne enextballoon1
    mov word [eb1row], 25
    mov ax, [eb1row]
    add ax, [eletteroffset]
    mov [eb1letterrow], ax
    mov ax, [eb1row]
    add ax, [ethreadoffset]
    mov [eb1threadrow], ax
    call eget_random_letter
    mov [eb1letterchar], al
enextballoon1:
    ;balloon 2 up by 1 row
    dec word [eb2row]
    dec word [eb2letterrow]
    dec word [eb2threadrow]
    cmp word [eb2row], 1
    jne enextballoon2
    mov word [eb2row], 25
    mov ax, [eb2row]
    add ax, [eletteroffset]
    mov [eb2letterrow], ax
    mov ax, [eb2row]
    add ax, [ethreadoffset]
    mov [eb2threadrow], ax
    call eget_random_letter
    mov [eb2letterchar], al
enextballoon2:

    ; balloon 3 up by 1 row
    dec word [eb3row]
    dec word [eb3letterrow]
    dec word [eb3threadrow]
    cmp word [eb3row], 1
    jne enextballoon3
    mov word [eb3row], 25
    mov ax, [eb3row]
    add ax, [eletteroffset]
    mov [eb3letterrow], ax
    mov ax, [eb3row]
    add ax, [ethreadoffset]
    mov [eb3threadrow], ax
    call eget_random_letter
    mov [eb3letterchar], al
enextballoon3:

    ;balloon 4 up by 1 row
    dec word [eb4row]
    dec word [eb4letterrow]
    dec word [eb4threadrow]
    cmp word [eb4row], 1
    jne enextballoon4
    mov word [eb4row], 25
    mov ax, [eb4row]
    add ax, [eletteroffset]
    mov [eb4letterrow], ax
    mov ax, [eb4row]
    add ax, [ethreadoffset]
    mov [eb4threadrow], ax
    call eget_random_letter
    mov [eb4letterchar], al
enextballoon4:


eredrawballoons:
call edraw_clouds
   ;redraw balloons at new positions
    call edraw_balloons

    
  ;infinite loop
    jmp eballoon_loop

; ----------  CLEAR BALLOONS ---erase balloons with bgr color

eclearballoons:
    push ax
    push bx
    push cx
    push dx
    

    mov bl, [espacechar]
    mov bh, [ebgcolorbyte]
    
    ;clear balloon 1 area
    mov dx, [eclearheight]
eclear_b1loop:
    mov ax, [eb1col]
    sub ax, 1
    push ax
    mov ax, [eb1row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b1loop
    
    ;clear balloon 2 area
    mov dx, [eclearheight]
eclear_b2loop:
    mov ax, [eb2col]
    sub ax, 1
    push ax
    mov ax, [eb2row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b2loop
    
    ;clear balloon 3 area
    mov dx, [eclearheight]
eclear_b3loop:
    mov ax, [eb3col]
    sub ax, 1
    push ax
    mov ax, [eb3row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b3loop
    
    ;clear balloon 4 area
    mov dx, [eclearheight]
eclear_b4loop:
    mov ax, [eb4col]
    sub ax, 1
    push ax
    mov ax, [eb4row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b4loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret



;-----------------------------
; DRAW BALLOONS here we redraw all 4 balloons at current positions

edraw_balloons:
    ; BALLOON 1
    mov bl, [eb1char]
    mov bh, [eb1color]
    
    ; Row 1
    mov ax, [eb1col]
    push ax
    mov ax, [eb1row]
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    ; Row 2
    mov ax, [eb1col]
    sub ax, 1
    push ax
    mov ax, [eb1row]
    add ax, 1
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    ; Row 3
    mov ax, [eb1col]
    sub ax, 1
    push ax
    mov ax, [eb1row]
    add ax, 2
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    ; Row 4
    mov ax, [eb1col]
    sub ax, 1
    push ax
    mov ax, [eb1row]
    add ax, 3
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    ; Row 5
    mov ax, [eb1col]
    push ax
    mov ax, [eb1row]
    add ax, 4
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    ; Row 6
    mov ax, [eb1col]
    add ax, 1
    push ax
    mov ax, [eb1row]
    add ax, 5
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w3len]
    call eprint
    
    ; Thread
    mov bl, [ethreadchar]
    mov bh, [ethreadcolor]
    
    mov ax, [eb1threadcol]
    push ax
    mov ax, [eb1threadrow]
    push ax
    call eposition 
    mov di, si    
    mov ax, bx
    mov cx, [eb1threadlen]
    call ethread
    
    ; Letter
    mov ax, [eb1lettercol]
    push ax
    mov ax, [eb1letterrow]
    push ax
    call eposition 
    mov di, si
    mov al, [eb1letterchar]
    mov ah, [eb1lettercolor]
    mov [es:di], ax
    
    ; BALLOON 2
    mov bl, [eb2char]
    mov bh, [eb2color]
    
    mov ax, [eb2col]
    push ax
    mov ax, [eb2row]
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    mov ax, [eb2col]
    sub ax, 1
    push ax
    mov ax, [eb2row]
    add ax, 1
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb2col]
    sub ax, 1
    push ax
    mov ax, [eb2row]
    add ax, 2
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb2col]
    sub ax, 1
    push ax
    mov ax, [eb2row]
    add ax, 3
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb2col]
    push ax
    mov ax, [eb2row]
    add ax, 4
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    mov ax, [eb2col]
    add ax, 1
    push ax
    mov ax, [eb2row]
    add ax, 5
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w3len]
    call eprint
    
    mov bl, [ethreadchar]
    mov bh, [ethreadcolor]
    
    mov ax, [eb2threadcol]
    push ax
    mov ax, [eb2threadrow]
    push ax
    call eposition 
    mov di, si    
    mov ax, bx
    mov cx, [eb1threadlen]
    call ethread
    
    mov ax, [eb2lettercol]
    push ax
    mov ax, [eb2letterrow]
    push ax
    call eposition 
    mov di, si
    mov al, [eb2letterchar]
    mov ah, [eb2lettercolor]
    mov [es:di], ax
    
    ; BALLOON 3
    mov bl, [eb3char]
    mov bh, [eb3color]
    
    mov ax, [eb3col]
    push ax
    mov ax, [eb3row]
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    mov ax, [eb3col]
    sub ax, 1
    push ax
    mov ax, [eb3row]
    add ax, 1
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb3col]
    sub ax, 1
    push ax
    mov ax, [eb3row]
    add ax, 2
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb3col]
    sub ax, 1
    push ax
    mov ax, [eb3row]
    add ax, 3
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb3col]
    push ax
    mov ax, [eb3row]
    add ax, 4
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    mov ax, [eb3col]
    add ax, 1
    push ax
    mov ax, [eb3row]
    add ax, 5
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w3len]
    call eprint
    
    mov bl, [ethreadchar]
    mov bh, [ethreadcolor]
    
    mov ax, [eb3threadcol]
    push ax
    mov ax, [eb3threadrow]
    push ax
    call eposition 
    mov di, si    
    mov ax, bx
    mov cx, [eb1threadlen]
    call ethread
    
    mov ax, [eb3lettercol]
    push ax
    mov ax, [eb3letterrow]
    push ax
    call eposition 
    mov di, si
    mov al, [eb3letterchar]
    mov ah, [eb3lettercolor]
    mov [es:di], ax
    
    ; BALLOON 4
    mov bl, [eb4char]
    mov bh, [eb4color]
    
    mov ax, [eb4col]
    push ax
    mov ax, [eb4row]
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    mov ax, [eb4col]
    sub ax, 1
    push ax
    mov ax, [eb4row]
    add ax, 1
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb4col]
    sub ax, 1
    push ax
    mov ax, [eb4row]
    add ax, 2
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb4col]
    sub ax, 1
    push ax
    mov ax, [eb4row]
    add ax, 3
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w2len]
    call eprint
    
    mov ax, [eb4col]
    push ax
    mov ax, [eb4row]
    add ax, 4
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w1len]
    call eprint
    
    mov ax, [eb4col]
    add ax, 1
    push ax
    mov ax, [eb4row]
    add ax, 5
    push ax
    call eposition           
    mov ax, bx
    mov cx, [eb1w3len]
    call eprint
    
    mov bl, [ethreadchar]
    mov bh, [ethreadcolor]
    
    mov ax, [eb4threadcol]
    push ax
    mov ax, [eb4threadrow]
    push ax
    call eposition 
    mov di, si    
    mov ax, bx
    mov cx, [eb1threadlen]
    call ethread
    
    mov ax, [eb4lettercol]
    push ax
    mov ax, [eb4letterrow]
    push ax
    call eposition 
    mov di, si
    mov al, [eb4letterchar]
    mov ah, [eb4lettercolor]
    mov [es:di], ax
    
    ret

eclear_single_balloon1:
    push ax
    push bx
    push cx
    push dx
    call eplay_pop_sound
    mov bl, [espacechar]
    mov bh, [ebgcolorbyte]
    
    mov dx, [eclearheight]
eclear_b1_single:
    mov ax, [eb1col]
    sub ax, 1
    push ax
    mov ax, [eb1row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b1_single
    
    mov word [eb1row], 25
    mov ax, [eb1row]
    add ax, [eletteroffset]
    mov [eb1letterrow], ax
    mov ax, [eb1row]
    add ax, [ethreadoffset]
    mov [eb1threadrow], ax
    call eget_random_letter
    mov [eb1letterchar], al
    
    add word [ecurrent_score], 10
    call eprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


eclear_single_balloon2:
    push ax
    push bx
    push cx
    push dx
    call eplay_pop_sound
    mov bl, [espacechar]
    mov bh, [ebgcolorbyte]
    
    mov dx, [eclearheight]
eclear_b2_single:
    mov ax, [eb2col]
    sub ax, 1
    push ax
    mov ax, [eb2row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b2_single
    
    mov word [eb2row], 25
    mov ax, [eb2row]
    add ax, [eletteroffset]
    mov [eb2letterrow], ax
    mov ax, [eb2row]
    add ax, [ethreadoffset]
    mov [eb2threadrow], ax
    call eget_random_letter
    mov [eb2letterchar], al
    
    add word [ecurrent_score], 10
    call eprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


eclear_single_balloon3:
    push ax
    push bx
    push cx
    push dx
    call eplay_pop_sound
    mov bl, [espacechar]
    mov bh, [ebgcolorbyte]
    
    mov dx, [eclearheight]
eclear_b3_single:
    mov ax, [eb3col]
    sub ax, 1
    push ax
    mov ax, [eb3row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b3_single
    
    mov word [eb3row], 25
    mov ax, [eb3row]
    add ax, [eletteroffset]
    mov [eb3letterrow], ax
    mov ax, [eb3row]
    add ax, [ethreadoffset]
    mov [eb3threadrow], ax
    call eget_random_letter
    mov [eb3letterchar], al
    
    add word [ecurrent_score], 10
    call eprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


eclear_single_balloon4:
    push ax
    push bx
    push cx
    push dx
    call eplay_pop_sound
    mov bl, [espacechar]
    mov bh, [ebgcolorbyte]
    
    mov dx, [eclearheight]
eclear_b4_single:
    mov ax, [eb4col]
    sub ax, 1
    push ax
    mov ax, [eb4row]
    add ax, dx
    sub ax, 1
    push ax
    call eposition
    mov ax, bx
    mov cx, [eclearwidth]
    call eprint
    dec dx
    jnz eclear_b4_single
    
    mov word [eb4row], 25
    mov ax, [eb4row]
    add ax, [eletteroffset]
    mov [eb4letterrow], ax
    mov ax, [eb4row]
    add ax, [ethreadoffset]
    mov [eb4threadrow], ax
    call eget_random_letter
    mov [eb4letterchar], al
    
    add word [ecurrent_score], 10
    call eprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret

  

;;;;;;;;;;;; SCORE/TIME ---

; Prints  value in current_score next to score:
eprint_score_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    ; Calculate position: Row 1, Col (scorecol + scorelength + 1)
    mov ax, [escorecol]
    add ax, [escorelength]
    add ax, 1 ; Space
    push ax
    mov ax, [escorerow]
    push ax
    call eposition
    mov di, si
    
    mov ax, [evideomembase]
    mov es, ax
    
    mov ax, [ecurrent_score]
    mov bx, 10
    mov cx, 0
    
eget_digits:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne eget_digits
    
    mov ah, [escoretextcolor]
eprint_digits:
    pop dx
    add dl, 0x30 ; convert to ascii
    mov al, dl
    mov [es:di], ax
    add di, 2
    loop eprint_digits
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Prints timer M:SS
eprint_time_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    ; Calculate position: Row 3, Col (timecol + timelength + 1)
    mov ax, [etimecol]
    add ax, [etimelength]
    add ax, 1
    push ax
    mov ax, [etimerow]
    push ax
    call eposition
    mov di, si
    
    mov ax, [evideomembase]
    mov es, ax
    
    ; Print Minute
    mov ax, [etimer_min]
    add al, 0x30
    mov ah, [etimetextcolor] ; Explicitly reload color (Cyan background)
    mov [es:di], ax
    add di, 2
    
    ; Print Colon
    mov al, ':'
    mov ah, [etimetextcolor]
    mov [es:di], ax
    add di, 2
    
    ; Print Seconds (Tens place)
    mov ax, [etimer_sec]
    xor dx, dx
    mov bx, 10
    div bx
    ; AX is quotient (tens), DX is remainder (ones)
    add al, 0x30
    mov ah, [etimetextcolor]
    mov [es:di], ax
    add di, 2
    
    ; Print Seconds (Ones place)
    mov al, dl
    add al, 0x30
    mov ah, [etimetextcolor]
    mov [es:di], ax
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
	
	 go_espace: 

	   call draw_gpause_screen
