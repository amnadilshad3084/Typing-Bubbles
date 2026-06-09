
;DATA
habgcolorbyte: db 0xBB
havideomembase: dw 0xB800
hascreencols: db 80
hascreensize: dw 4000
haspacechar: db 0x20
hacursoroff: db 0

; SPEED CONTROL
haballoonspeed: dw 1

;----------  CLOUD-------------
hacloudchar: db 0x20     
hacloudcolor: db 0xFF 

; Cloud 1
hacloud1col: dw 8
hacloud1row: dw 7

; Cloud 2
hacloud2col: dw 52
hacloud2row: dw 5

; Cloud 3
hacloud3col: dw 3
hacloud3row: dw 14

; Cloud 4
hacloud4col: dw 62
hacloud4row: dw 17

; Cloud 5
hacloud5col: dw 35
hacloud5row: dw 20

; Keyboard interrupt data
hakeypressed: db 0

; RANDOM LETTERS 
haletters: db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
haletters_count: dw 26
harandomcounter: dw 0

; --- SCORE AND TIME DATA ---
hascore: db 'SCORE:'
hascorelength: dw 6
hascorerow: dw 1
hascorecol: dw 1
hascoretextcolor: db 0xB0
hacurrent_score: dw 0

hatime: db 'TIME:'
hatimelength: dw 5
hatimerow: dw 3
hatimecol: dw 1
hatimetextcolor: db 0xB0

; TIMER VARIABLES
hatimer_min: dw 2
hatimer_sec: dw 0
halast_tick: dw 0


; balloon 1
hab1col: dw 15
hab1row: dw 9
hab1w1len: dw 5
hab1w2len: dw 7
hab1w3len: dw 3
hab1threadlen: dw 2
hab1char: db 0x20
hab1color: db 0xDD
hab1letterchar: db 0x41

hab1lettercolor: db 0xD0
hab1lettercol: dw 17
hab1letterrow: dw 11
hab1threadcol: dw 17
hab1threadrow: dw 15

; balloon 2
hab2col: dw 28
hab2row: dw 2
hab2char: db 0x20
hab2color: db 0xEE

hab2lettercolor: db 0xE0
hab2lettercol: dw 30
hab2letterrow: dw 4
hab2threadcol: dw 30
hab2threadrow: dw 8
hab2letterchar: db 0x42

; balloon 3
hab3col: dw 43
hab3row: dw 12
hab3char: db 0x20
hab3color: db 0xAA

hab3lettercolor: db 0xA0
hab3lettercol: dw 45
hab3letterrow: dw 14
hab3threadcol: dw 45
hab3threadrow: dw 18
hab3letterchar: db 0x43      

; balloon 4
hab4col: dw 59
hab4row: dw 6
hab4char: db 0x20
hab4color: db 0x99

hab4lettercolor: db 0x90
hab4lettercol: dw 61
hab4letterrow: dw 8
hab4threadcol: dw 61
hab4threadrow: dw 12
hab4letterchar: db 0x44

; VOLUME
havolbcol: dw 1
havolbrow: dw 23
havolblen: dw 2
havoltcol: dw 3
havoltrow: dw 23
havolttoprow: dw 22
havoltbotrow: dw 24
havolspeakerchar: db 0x20
havolspeakercolor: db 0xFB
havolw1col: dw 4
havolw1row: dw 23
havolw1len: dw 1
havolw2col: dw 5
havolw2row: dw 22
havolw2len: dw 3
havolw3col: dw 6
havolw3row: dw 22
havolw3len: dw 3
havolwavechar: db 0x7C
havolwavecolor: db 0xB0

; thread attributes
hathreadchar: db 0x7C
hathreadcolor: db 0x77

; clearballoons dimensions
haclearheight: dw 8
haclearwidth: dw 7

; respawn settings
harespawnrow: dw 25
haletteroffset: dw 3
hathreadoffset: dw 6


; --- PROCEDURES ---
; --- POP SOUND PROCEDURE ---
haplay_pop_sound:
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
hapopdelay:
    loop hapopdelay
    in al, 61h
    and al, 11111100b
    out 61h, al
    pop cx
    pop ax
    ret

; RANDOM LETTER FUNCTION 
haget_random_letter:
    mov ax, [harandomcounter]
    add ax, 7
    mov [harandomcounter], ax
    xor dx, dx
    mov bx, [haletters_count]
    div bx
    mov bx, dx
    mov al, [haletters + bx]
    ret

;-------- DRAW CLOUD -----
hadraw_clouds:
    push ax
    push bx
    push cx
    
    mov bl, [hacloudchar]
    mov bh, [hacloudcolor]
    
  ;            CLOUD 1 
; Row 1
mov ax, [hacloud1col]
add ax, 4
push ax
mov ax, [hacloud1row]
push ax
call haposition
mov ax, bx
mov cx, 6
call haprint

; Row 2
mov ax, [hacloud1col]
add ax, 2
push ax
mov ax, [hacloud1row]
add ax, 1
push ax
call haposition
mov ax, bx
mov cx, 10
call haprint

; Row 3
mov ax, [hacloud1col] 
push ax
mov ax, [hacloud1row]
add ax, 2
push ax
call haposition
mov ax, bx
mov cx, 14
call haprint

; Row 4
mov ax, [hacloud1col]
add ax, 3
push ax
mov ax, [hacloud1row]
add ax, 3
push ax
call haposition
mov ax, bx
mov cx, 8
call haprint

; ============ CLOUD 2 ============

; Row 1
mov ax, [hacloud2col]
add ax, 5
push ax
mov ax, [hacloud2row]
push ax
call haposition
mov ax, bx
mov cx, 7
call haprint

; Row 2
mov ax, [hacloud2col]
add ax, 2
push ax
mov ax, [hacloud2row]
add ax, 1
push ax
call haposition
mov ax, bx
mov cx, 13
call haprint

; Row 3
mov ax, [hacloud2col]
push ax
mov ax, [hacloud2row]
add ax, 2
push ax
call haposition
mov ax, bx
mov cx, 17
call haprint

; Row 4
mov ax, [hacloud2col]
add ax, 4
push ax
mov ax, [hacloud2row]
add ax, 3
push ax
call haposition
mov ax, bx
mov cx, 9
call haprint

; ============ CLOUD 3 ============    

; Row 1
mov ax, [hacloud3col]
add ax, 2
push ax
mov ax, [hacloud3row]
push ax
call haposition
mov ax, bx
mov cx, 3
call haprint

; Row 2
mov ax, [hacloud3col]
push ax
mov ax, [hacloud3row]
add ax, 1
push ax
call haposition
mov ax, bx
mov cx, 7
call haprint

; Row 3
mov ax, [hacloud3col]
add ax, 1
push ax
mov ax, [hacloud3row]
add ax, 2
push ax
call haposition
mov ax, bx
mov cx, 5
call haprint

; ============ CLOUD 4 ============    

; Row 1
mov ax, [hacloud4col]
add ax, 2
push ax
mov ax, [hacloud4row]
push ax
call haposition
mov ax, bx
mov cx, 5
call haprint

; Row 2
mov ax, [hacloud4col]
push ax
mov ax, [hacloud4row]
add ax, 1
push ax
call haposition
mov ax, bx
mov cx, 9
call haprint

; Row 3
mov ax, [hacloud4col]
add ax, 2
push ax
mov ax, [hacloud4row]
add ax, 2
push ax
call haposition
mov ax, bx
mov cx, 5
call haprint

; ============ CLOUD 5 ============    

; Row 1
mov ax, [hacloud5col]
add ax, 3
push ax
mov ax, [hacloud5row]
push ax
call haposition
mov ax, bx
mov cx, 6
call haprint

; Row 2
mov ax, [hacloud5col]
add ax, 1
push ax
mov ax, [hacloud5row]
add ax, 1
push ax
call haposition
mov ax, bx
mov cx, 10
call haprint

; Row 3
mov ax, [hacloud5col]
push ax
mov ax, [hacloud5row]
add ax, 2
push ax
call haposition
mov ax, bx
mov cx, 12
call haprint

; Row 4
mov ax, [hacloud5col]
add ax, 2
push ax
mov ax, [hacloud5row]
add ax, 3
push ax
call haposition
mov ax, bx
mov cx, 8
call haprint

pop cx
pop bx
pop ax
ret

haclrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
haclearing:
    mov word[es:di], ax
    add di, 2
    cmp di, 4000
    jne haclearing
    ret

haposition:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [havideomembase]
    mov es, ax              
    mov al, [hascreencols]
    mul byte [bp+4]
    add ax, [bp+6]        
    shl ax, 1               
    mov si, ax    
    
    pop ax
    pop bp
    ret 4

havertical:
    push cx 
haverticalline:
    mov [es:di], ax
    add di, 160
    loop haverticalline
    pop cx
    ret

haprintvert:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call havertical
    pop es
    pop di
    pop ax
    pop bp
    ret

haballoon:
    push cx
haballoonprn:
    mov [es:di], ax
    add di, 2
    loop haballoonprn
    pop cx
    ret

hathread:
    push cx               
hathreadloop:
    mov [es:di], ax       
    add di, 160         
    loop hathreadloop
    pop cx
    ret

haprint:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call haballoon 
    pop es
    pop di
    pop ax
    pop bp
    ret

hafillbackground:
    mov ax, [havideomembase]
    mov es, ax
    mov di, 0             
    mov cx, [hascreensize]
    mov al, [haspacechar]     
    mov ah, [habgcolorbyte]
hafillloop:
    mov [es:di], ax
    add di, 2   
    loop hafillloop
    ret 

haprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [havideomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, 0xB0

hanextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop hanextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4


draw_hard_screen:
 ; disable blinking to enable all 16 background colors
mov ax, 1003h
mov bl, [hacursoroff]
int 10h
call haclrscr
call hafillbackground     
call hadraw_clouds

; score print
mov ax, [hascorecol]
push ax
mov ax, [hascorerow]
push ax
call haposition

push si
mov ax, hascore
push ax
push word [hascorelength]
call haprinttext

; INITIAL SCORE VALUE (0)
call haprint_score_num

; time print
mov ax, [hatimecol]
push ax
mov ax, [hatimerow]
push ax
call haposition

push si
mov ax, hatime
push ax
push word [hatimelength]
call haprinttext

; INITIAL TIME VALUE (2:00)
call haprint_time_num

; INITIALIZE CLOCK for timer
mov ax, 0x40
mov es, ax
mov ax, [es:0x6c]
mov [halast_tick], ax

; VOLUME speaker base
mov bl, [havolspeakerchar]
mov bh, [havolspeakercolor]

mov ax, [havolbcol]
push ax
mov ax, [havolbrow]
push ax
call haposition
mov ax, bx
mov cx, [havolblen]
call haprint

; triangle middle
mov ax, [havoltcol]
push ax
mov ax, [havoltrow]
push ax
call haposition
mov ax, bx
mov cx, 1
call haprint

; triangle bottom
mov ax, [havoltcol]
push ax
mov ax, [havoltbotrow]
push ax
call haposition
mov ax, bx
mov cx, 1
call haprint

; triangle top
mov ax, [havoltcol]
push ax
mov ax, [havolttoprow]
push ax
call haposition
mov ax, bx
mov cx, 1
call haprint

; WAVES
mov bl, [havolwavechar]
mov bh, [havolwavecolor]

; wave 1
mov ax, [havolw1col]
push ax 
mov ax, [havolw1row]
push ax 
call haposition 
mov ax, bx
mov cx, [havolw1len]
call haprintvert

; wave 2
mov ax, [havolw2col]
push ax 
mov ax, [havolw2row]
push ax 
call haposition 
mov ax, bx
mov cx, [havolw2len]
call haprintvert

; wave 3
mov ax, [havolw3col]
push ax 
mov ax, [havolw3row]
push ax 
call haposition 
mov ax, bx
mov cx, [havolw3len]
call haprintvert

call hadraw_clouds   ; cloud

call haget_random_letter
mov [hab1letterchar], al

call haget_random_letter
mov [hab2letterchar], al

call haget_random_letter  
mov [hab3letterchar], al

call haget_random_letter
mov [hab4letterchar], al

; DRAW BALLOONS initially
call hadraw_balloons
;------ BALLOON MOVEMENT ----------
haballoon_loop:

    ; --- TIMER UPDATE CHECK ---
    ; Check BIOS clock area (0040:006C) for ticks
    push ax
    push bx
    push es
    
    mov ax, 0x40
    mov es, ax
    mov ax, [es:0x6c]  ; Read current tick count
    mov bx, [halast_tick]
    sub ax, bx
    cmp ax, 18         ; Approx 1 second (18.2 ticks)
    jl haskip_timer
    
    ; 1 Second has passed
    mov ax, [es:0x6c]
    mov [halast_tick], ax ; Reset last tick
    
    ; Decrement Logic
    mov ax, [hatimer_sec]
    cmp ax, 0
    jne hadec_sec
    ; Seconds is 0
    mov ax, [hatimer_min]
    cmp ax, 0
    je hatimer_finished ; 0:00 reached
    dec word [hatimer_min]
    mov word [hatimer_sec], 59
    jmp haupdate_timer_display
    

		hadec_sec:
    dec word [hatimer_sec]
    
haupdate_timer_display:
    call haprint_time_num
    
    ; this checks if timer reached 0;00
    mov ax, [hatimer_min]
    cmp ax, 0
    jne haskip_timer
    mov ax, [hatimer_sec]
    cmp ax, 0
    jne haskip_timer
    
    ; Timer reached 0 so GAME OVER
    jmp draw_gameover_screen  ; jmp to game over screen
	
	
    
hatimer_finished:
    ; Timer reached 0, game continues or can end here
haskip_timer:
    pop es
    pop bx
    pop ax
    ; --- END TIMER CHECK ---

    ; this whole delay section just wastes time to slow down balloon movement
    mov bx, [haballoonspeed]
haouterloop:
    mov cx, 0xFFFF
hainnerloop:
    dec cx
    jnz hainnerloop
    dec bx
    jnz haouterloop
    
    ; --- KEYBOARD INTERRUPT
    mov ah, 0x01
    int 0x16
    jz hano_key_pressed
    
    mov ah, 0x00
    int 0x16
    mov [hakeypressed], al
    
	
	  cmp al, 0x20        ; Check if char is Space
    je go_hspace     ; If Space, jump 
	
    ; convert lowercase to uppercase
    cmp al, 'a'
    jb hanotlowercase
    cmp al, 'z'
    ja hanotlowercase
    sub al, 32
    mov [hakeypressed], al


hanotlowercase:
    ; check balloon 1
    mov al, [hab1letterchar]
    cmp al, [hakeypressed]
    jne hacheck_balloon2
    call haclear_single_balloon1
    jmp haredrawballoons
    
hacheck_balloon2:
    mov al, [hab2letterchar]
    cmp al, [hakeypressed]
    jne hacheck_balloon3
    call haclear_single_balloon2
    jmp haredrawballoons
    
hacheck_balloon3:
    mov al, [hab3letterchar]
    cmp al, [hakeypressed]
    jne hacheck_balloon4
    call haclear_single_balloon3
    jmp haredrawballoons
    
hacheck_balloon4:
    mov al, [hab4letterchar]
    cmp al, [hakeypressed]
    jne hano_key_pressed
    call haclear_single_balloon4
    jmp haredrawballoons

hano_key_pressed:

    ;KEYBOARD INTERRUPT  END 
    ;no key pressed so normal code for movement
    call haclearballoons
    ;--------------Balloon 1 moved up by 1 row

    dec word [hab1row]
    dec word [hab1letterrow]
    dec word [hab1threadrow]
    cmp word [hab1row], 1    ;reset when balloon reaches row 1
    jne hanextballoon1
    mov word [hab1row], 25
    mov ax, [hab1row]
    add ax, [haletteroffset]
    mov [hab1letterrow], ax
    mov ax, [hab1row]
    add ax, [hathreadoffset]
    mov [hab1threadrow], ax
    call haget_random_letter
    mov [hab1letterchar], al
hanextballoon1:
    ;balloon 2 up by 1 row
    dec word [hab2row]
    dec word [hab2letterrow]
    dec word [hab2threadrow]
    cmp word [hab2row], 1
    jne hanextballoon2
    mov word [hab2row], 25
    mov ax, [hab2row]
    add ax, [haletteroffset]
    mov [hab2letterrow], ax
    mov ax, [hab2row]
    add ax, [hathreadoffset]
    mov [hab2threadrow], ax
    call haget_random_letter
    mov [hab2letterchar], al
hanextballoon2:

    ; balloon 3 up by 1 row
    dec word [hab3row]
    dec word [hab3letterrow]
    dec word [hab3threadrow]
    cmp word [hab3row], 1
    jne hanextballoon3
    mov word [hab3row], 25
    mov ax, [hab3row]
    add ax, [haletteroffset]
    mov [hab3letterrow], ax
    mov ax, [hab3row]
    add ax, [hathreadoffset]
    mov [hab3threadrow], ax
    call haget_random_letter
    mov [hab3letterchar], al
hanextballoon3:

    ;balloon 4 up by 1 row
    dec word [hab4row]
    dec word [hab4letterrow]
    dec word [hab4threadrow]
    cmp word [hab4row], 1
    jne hanextballoon4
    mov word [hab4row], 25
    mov ax, [hab4row]
    add ax, [haletteroffset]
    mov [hab4letterrow], ax
    mov ax, [hab4row]
    add ax, [hathreadoffset]
    mov [hab4threadrow], ax
    call haget_random_letter
    mov [hab4letterchar], al
hanextballoon4:

haredrawballoons:
    call hadraw_clouds
    ;redraw balloons at new positions
    call hadraw_balloons

    ;infinite loop
    jmp haballoon_loop

; ----------  CLEAR BALLOONS ---erase balloons with bgr color

haclearballoons:
    push ax
    push bx
    push cx
    push dx
    
    mov bl, [haspacechar]
    mov bh, [habgcolorbyte]
    
    ;clear balloon 1 area
    mov dx, [haclearheight]
haclear_b1loop:
    mov ax, [hab1col]
    sub ax, 1
    push ax
    mov ax, [hab1row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b1loop
    
    ;clear balloon 2 area
    mov dx, [haclearheight]
haclear_b2loop:
    mov ax, [hab2col]
    sub ax, 1
    push ax
    mov ax, [hab2row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b2loop
    
    ;clear balloon 3 area
    mov dx, [haclearheight]
haclear_b3loop:
    mov ax, [hab3col]
    sub ax, 1
    push ax
    mov ax, [hab3row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b3loop
    
    ;clear balloon 4 area
    mov dx, [haclearheight]
haclear_b4loop:
    mov ax, [hab4col]
    sub ax, 1
    push ax
    mov ax, [hab4row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b4loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret



;-----------------------------
; DRAW BALLOONS here we redraw all 4 balloons at current positions
hadraw_balloons:
    ; BALLOON 1
    mov bl, [hab1char]
    mov bh, [hab1color]
    
    ; Row 1
    mov ax, [hab1col]
    push ax
    mov ax, [hab1row]
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    ; Row 2
    mov ax, [hab1col]
    sub ax, 1
    push ax
    mov ax, [hab1row]
    add ax, 1
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    ; Row 3
    mov ax, [hab1col]
    sub ax, 1
    push ax
    mov ax, [hab1row]
    add ax, 2
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    ; Row 4
    mov ax, [hab1col]
    sub ax, 1
    push ax
    mov ax, [hab1row]
    add ax, 3
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    ; Row 5
    mov ax, [hab1col]
    push ax
    mov ax, [hab1row]
    add ax, 4
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    ; Row 6
    mov ax, [hab1col]
    add ax, 1
    push ax
    mov ax, [hab1row]
    add ax, 5
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w3len]
    call haprint
    
    ; Thread
    mov bl, [hathreadchar]
    mov bh, [hathreadcolor]
    
    mov ax, [hab1threadcol]
    push ax
    mov ax, [hab1threadrow]
    push ax
    call haposition 
    mov di, si    
    mov ax, bx
    mov cx, [hab1threadlen]
    call hathread
    
    ; Letter
    mov ax, [hab1lettercol]
    push ax
    mov ax, [hab1letterrow]
    push ax
    call haposition 
    mov di, si
    mov al, [hab1letterchar]
    mov ah, [hab1lettercolor]
    mov [es:di], ax
    
    ; BALLOON 2
    mov bl, [hab2char]
    mov bh, [hab2color]
    
    mov ax, [hab2col]
    push ax
    mov ax, [hab2row]
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    mov ax, [hab2col]
    sub ax, 1
    push ax
    mov ax, [hab2row]
    add ax, 1
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab2col]
    sub ax, 1
    push ax
    mov ax, [hab2row]
    add ax, 2
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab2col]
    sub ax, 1
    push ax
    mov ax, [hab2row]
    add ax, 3
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab2col]
    push ax
    mov ax, [hab2row]
    add ax, 4
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    mov ax, [hab2col]
    add ax, 1
    push ax
    mov ax, [hab2row]
    add ax, 5
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w3len]
    call haprint
    
    mov bl, [hathreadchar]
    mov bh, [hathreadcolor]
    
    mov ax, [hab2threadcol]
    push ax
    mov ax, [hab2threadrow]
    push ax
    call haposition 
    mov di, si    
    mov ax, bx
    mov cx, [hab1threadlen]
    call hathread
    
    mov ax, [hab2lettercol]
    push ax
    mov ax, [hab2letterrow]
    push ax
    call haposition 
    mov di, si
    mov al, [hab2letterchar]
    mov ah, [hab2lettercolor]
    mov [es:di], ax
    
    ; BALLOON 3
    mov bl, [hab3char]
    mov bh, [hab3color]
    
    mov ax, [hab3col]
    push ax
    mov ax, [hab3row]
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    mov ax, [hab3col]
    sub ax, 1
    push ax
    mov ax, [hab3row]
    add ax, 1
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab3col]
    sub ax, 1
    push ax
    mov ax, [hab3row]
    add ax, 2
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab3col]
    sub ax, 1
    push ax
    mov ax, [hab3row]
    add ax, 3
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab3col]
    push ax
    mov ax, [hab3row]
    add ax, 4
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    mov ax, [hab3col]
    add ax, 1
    push ax
    mov ax, [hab3row]
    add ax, 5
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w3len]
    call haprint
    
    mov bl, [hathreadchar]
    mov bh, [hathreadcolor]
    
    mov ax, [hab3threadcol]
    push ax
    mov ax, [hab3threadrow]
    push ax
    call haposition 
    mov di, si    
    mov ax, bx
    mov cx, [hab1threadlen]
    call hathread
    
    mov ax, [hab3lettercol]
    push ax
    mov ax, [hab3letterrow]
    push ax
    call haposition 
    mov di, si
    mov al, [hab3letterchar]
    mov ah, [hab3lettercolor]
    mov [es:di], ax
    
    ; BALLOON 4
    mov bl, [hab4char]
    mov bh, [hab4color]
    
    mov ax, [hab4col]
    push ax
    mov ax, [hab4row]
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    mov ax, [hab4col]
    sub ax, 1
    push ax
    mov ax, [hab4row]
    add ax, 1
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab4col]
    sub ax, 1
    push ax
    mov ax, [hab4row]
    add ax, 2
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab4col]
    sub ax, 1
    push ax
    mov ax, [hab4row]
    add ax, 3
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w2len]
    call haprint
    
    mov ax, [hab4col]
    push ax
    mov ax, [hab4row]
    add ax, 4
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w1len]
    call haprint
    
    mov ax, [hab4col]
    add ax, 1
    push ax
    mov ax, [hab4row]
    add ax, 5
    push ax
    call haposition           
    mov ax, bx
    mov cx, [hab1w3len]
    call haprint
    
    mov bl, [hathreadchar]
    mov bh, [hathreadcolor]
    
    mov ax, [hab4threadcol]
    push ax
    mov ax, [hab4threadrow]
    push ax
    call haposition 
    mov di, si    
    mov ax, bx
    mov cx, [hab1threadlen]
    call hathread
    
    mov ax, [hab4lettercol]
    push ax
    mov ax, [hab4letterrow]
    push ax
    call haposition 
    mov di, si
    mov al, [hab4letterchar]
    mov ah, [hab4lettercolor]
    mov [es:di], ax
    
    ret


;;;;;;;;;;;;;;;

  haclear_single_balloon1:
    push ax
    push bx
    push cx
    push dx
    call haplay_pop_sound
    mov bl, [haspacechar]
    mov bh, [habgcolorbyte]
    
    mov dx, [haclearheight]
haclear_b1_single:
    mov ax, [hab1col]
    sub ax, 1
    push ax
    mov ax, [hab1row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b1_single
    
    mov word [hab1row], 25
    mov ax, [hab1row]
    add ax, [haletteroffset]
    mov [hab1letterrow], ax
    mov ax, [hab1row]
    add ax, [hathreadoffset]
    mov [hab1threadrow], ax
    call haget_random_letter
    mov [hab1letterchar], al
    
    add word [hacurrent_score], 10
    call haprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


haclear_single_balloon2:
    push ax
    push bx
    push cx
    push dx
    call haplay_pop_sound
    mov bl, [haspacechar]
    mov bh, [habgcolorbyte]
    
    mov dx, [haclearheight]
haclear_b2_single:
    mov ax, [hab2col]
    sub ax, 1
    push ax
    mov ax, [hab2row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b2_single
    
    mov word [hab2row], 25
    mov ax, [hab2row]
    add ax, [haletteroffset]
    mov [hab2letterrow], ax
    mov ax, [hab2row]
    add ax, [hathreadoffset]
    mov [hab2threadrow], ax
    call haget_random_letter
    mov [hab2letterchar], al
    
    add word [hacurrent_score], 10
    call haprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


haclear_single_balloon3:
    push ax
    push bx
    push cx
    push dx
    call haplay_pop_sound
    mov bl, [haspacechar]
    mov bh, [habgcolorbyte]
    
    mov dx, [haclearheight]
haclear_b3_single:
    mov ax, [hab3col]
    sub ax, 1
    push ax
    mov ax, [hab3row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b3_single
    
    mov word [hab3row], 25
    mov ax, [hab3row]
    add ax, [haletteroffset]
    mov [hab3letterrow], ax
    mov ax, [hab3row]
    add ax, [hathreadoffset]
    mov [hab3threadrow], ax
    call haget_random_letter
    mov [hab3letterchar], al
    
    add word [hacurrent_score], 10
    call haprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


haclear_single_balloon4:
    push ax
    push bx
    push cx
    push dx
    call haplay_pop_sound
    mov bl, [haspacechar]
    mov bh, [habgcolorbyte]
    
    mov dx, [haclearheight]
haclear_b4_single:
    mov ax, [hab4col]
    sub ax, 1
    push ax
    mov ax, [hab4row]
    add ax, dx
    sub ax, 1
    push ax
    call haposition
    mov ax, bx
    mov cx, [haclearwidth]
    call haprint
    dec dx
    jnz haclear_b4_single
    
    mov word [hab4row], 25
    mov ax, [hab4row]
    add ax, [haletteroffset]
    mov [hab4letterrow], ax
    mov ax, [hab4row]
    add ax, [hathreadoffset]
    mov [hab4threadrow], ax
    call haget_random_letter
    mov [hab4letterchar], al
    
    add word [hacurrent_score], 10
    call haprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


;;;;;;;;;;;; SCORE/TIME ---
; Prints value in current_score next to score:
haprint_score_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    ; Calculate position: Row 1, Col (scorecol + scorelength + 1)
    mov ax, [hascorecol]
    add ax, [hascorelength]
    add ax, 1 ; Space
    push ax
    mov ax, [hascorerow]
    push ax
    call haposition
    mov di, si
    
    mov ax, [havideomembase]
    mov es, ax
    
    mov ax, [hacurrent_score]
    mov bx, 10
    mov cx, 0
    
haget_digits:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne haget_digits
    
    mov ah, [hascoretextcolor]
haprint_digits:
    pop dx
    add dl, 0x30 ; convert to ascii
    mov al, dl
    mov [es:di], ax
    add di, 2
    loop haprint_digits
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Prints timer M:SS
haprint_time_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    ; Calculate position: Row 3, Col (timecol + timelength + 1)
    mov ax, [hatimecol]
    add ax, [hatimelength]
    add ax, 1
    push ax
    mov ax, [hatimerow]
    push ax
    call haposition
    mov di, si
    
    mov ax, [havideomembase]
    mov es, ax
    
    ; Print Minute
    mov ax, [hatimer_min]
    add al, 0x30
    mov ah, [hatimetextcolor] ; Explicitly reload color (Cyan background)
    mov [es:di], ax
    add di, 2
    
    ; Print Colon
    mov al, ':'
    mov ah, [hatimetextcolor]
    mov [es:di], ax
    add di, 2
    
    ; Print Seconds (Tens place)
    mov ax, [hatimer_sec]
    xor dx, dx
    mov bx, 10
    div bx
    ; AX is quotient (tens), DX is remainder (ones)
    add al, 0x30
    mov ah, [hatimetextcolor]
    mov [es:di], ax
    add di, 2
    
    ; Print Seconds (Ones place)
    mov al, dl
    add al, 0x30
    mov ah, [hatimetextcolor]
    mov [es:di], ax
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

 go_hspace:
; mov word[haballoonspeed],1 
	   call draw_gpause_screen