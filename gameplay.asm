
;;;;;;;;music

; ; Musical notes frequencies (in Hz) - Simple melody
 ; noteFreqs: dw 523, 587, 659, 698, 784, 698, 659, 587  ; C5, D5, E5, F5, G5, F5, E5, D5
            ; dw 523, 587, 659, 698, 784, 784, 880, 880  ; C5, D5, E5, F5, G5, G5, A5, A5
 ; noteCount: dw 16


;DATA
gbgcolorbyte: db 0xBB
gvideomembase: dw 0xB800
gscreencols: db 80
gscreensize: dw 4000
gspacechar: db 0x20
gcursoroff: db 0

; SPEED CONTROL
gballoonspeed: dw 5

;----------  CLOUD-------------
gcloudchar: db 0x20     
gcloudcolor: db 0xFF

; Cloud 1
gcloud1col: dw 8
gcloud1row: dw 7

; Cloud 2
gcloud2col: dw 52
gcloud2row: dw 5

; Cloud 3
gcloud3col: dw 3
gcloud3row: dw 14

; Cloud 4
gcloud4col: dw 62
gcloud4row: dw 17

; Cloud 5
gcloud5col: dw 35
gcloud5row: dw 20

; Keyboard interrupt data
gkeypressed: db 0

; RANDOM LETTERS 
gletters: db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
gletters_count: dw 26
grandomcounter: dw 0

; --- SCORE AND TIME DATA ---
gscore: db 'SCORE:'
gscorelength: dw 6
gscorerow: dw 1
gscorecol: dw 1
gscoretextcolor: db 0xB0
gcurrent_score: dw 0

gtime: db 'TIME:'
gtimelength: dw 5
gtimerow: dw 3
gtimecol: dw 1
gtimetextcolor: db 0xB0

; TIMER VARIABLES
gtimer_min: dw 0;2
gtimer_sec: dw 20;0
glast_tick: dw 0


; balloon 1
gb1col: dw 15
gb1row: dw 9
gb1w1len: dw 5
gb1w2len: dw 7
gb1w3len: dw 3
gb1threadlen: dw 2
gb1char: db 0x20
gb1color: db 0xDD
gb1letterchar: db 0x41

gb1lettercolor: db 0xD0
gb1lettercol: dw 17
gb1letterrow: dw 11
gb1threadcol: dw 17
gb1threadrow: dw 15

; balloon 2
gb2col: dw 28
gb2row: dw 2
gb2char: db 0x20
gb2color: db 0xEE

gb2lettercolor: db 0xE0
gb2lettercol: dw 30
gb2letterrow: dw 4
gb2threadcol: dw 30
gb2threadrow: dw 8
gb2letterchar: db 0x42

; balloon 3
gb3col: dw 43
gb3row: dw 12
gb3char: db 0x20
gb3color: db 0xAA

gb3lettercolor: db 0xA0
gb3lettercol: dw 45
gb3letterrow: dw 14
gb3threadcol: dw 45
gb3threadrow: dw 18
gb3letterchar: db 0x43      

; balloon 4
gb4col: dw 59
gb4row: dw 6
gb4char: db 0x20
gb4color: db 0x99

gb4lettercolor: db 0x90
gb4lettercol: dw 61
gb4letterrow: dw 8
gb4threadcol: dw 61
gb4threadrow: dw 12
gb4letterchar: db 0x44

; VOLUME
gvolbcol: dw 1
gvolbrow: dw 23
gvolblen: dw 2
gvoltcol: dw 3
gvoltrow: dw 23
gvolttoprow: dw 22
gvoltbotrow: dw 24
gvolspeakerchar: db 0x20
gvolspeakercolor: db 0xFB
gvolw1col: dw 4
gvolw1row: dw 23
gvolw1len: dw 1
gvolw2col: dw 5
gvolw2row: dw 22
gvolw2len: dw 3
gvolw3col: dw 6
gvolw3row: dw 22
gvolw3len: dw 3
gvolwavechar: db 0x7C
gvolwavecolor: db 0xB0

; thread attributes
gthreadchar: db 0x7C
gthreadcolor: db 0x77

; clearballoons dimensions
gclearheight: dw 8
gclearwidth: dw 7

; respawn settings
grespawnrow: dw 25
gletteroffset: dw 3
gthreadoffset: dw 6


; --- PROCEDURES ---
; --- POP SOUND PROCEDURE, we used hardware ports
gplay_pop_sound:
    push ax
    push cx
    mov al, 0B6h     ;preparing speaker for sound (controls internal speaker)
	;43h, 42h, 61h =special addresses where sound hardware is
    out 43h, al               ;command to timer chip
    mov ax, 5000      ; Frequency (5000 Hz for pop sound),(higher =squeaky, lower = deep)
    out 42h, al       ; Send low byte
    mov al, ah
    out 42h, al       ; Send high byte
    
    ; Turn ON the speaker
    in al, 61h
    or al, 00000011b  ; Set bits 0 and 1
    out 61h, al
    
    ;  sound playing for a short time
    mov cx, 25000     ; duration of sound
gpopdelay:
    loop gpopdelay
    
    ; turn off speaker
    in al, 61h
    and al, 11111100b ;clear bits 0 and 1
    out 61h, al
    
    pop cx
    pop ax
    ret
;RANDOM LETTER FUNCTION 
gget_random_letter:
    mov ax, [grandomcounter]  ;for e.g =0
    add ax, 7 ;ax= 0 + 7 = 7 (add 7 to change it)
    mov [grandomcounter], ax   ;to save randcouter
    xor dx, dx   ;dx= 0 (clear dx for division)
    mov bx, [gletters_count]    
    div bx    ; to get remainder between 0 and 26 and using that remainder to get a letter
    mov bx, dx
    mov al, [gletters + bx]
    ret

;-------- DRAW CLOUD -----
gdraw_clouds:
    push ax
    push bx
    push cx
    
  
    mov bl, [gcloudchar]
    mov bh, [gcloudcolor]
    
  ;            CLOUD 1 
; Row 1
mov ax, [gcloud1col]
add ax, 4
push ax
mov ax, [gcloud1row]
push ax
call gposition
mov ax, bx
mov cx, 6
call gprint

; Row 2
mov ax, [gcloud1col]
add ax, 2
push ax
mov ax, [gcloud1row]
add ax, 1
push ax
call gposition
mov ax, bx
mov cx, 10
call gprint

; Row 3
mov ax, [gcloud1col] 
push ax
mov ax, [gcloud1row]
add ax, 2
push ax
call gposition
mov ax, bx
mov cx, 14
call gprint

; Row 4
mov ax, [gcloud1col]
add ax, 3
push ax
mov ax, [gcloud1row]
add ax, 3
push ax
call gposition
mov ax, bx
mov cx, 8
call gprint

; ============ CLOUD 2 ============

; Row 1
mov ax, [gcloud2col]
add ax, 5
push ax
mov ax, [gcloud2row]
push ax
call gposition
mov ax, bx
mov cx, 7
call gprint

; Row 2
mov ax, [gcloud2col]
add ax, 2
push ax
mov ax, [gcloud2row]
add ax, 1
push ax
call gposition
mov ax, bx
mov cx, 13
call gprint

; Row 3
mov ax, [gcloud2col]
push ax
mov ax, [gcloud2row]
add ax, 2
push ax
call gposition
mov ax, bx
mov cx, 17
call gprint

; Row 4
mov ax, [gcloud2col]
add ax, 4
push ax
mov ax, [gcloud2row]
add ax, 3
push ax
call gposition
mov ax, bx
mov cx, 9
call gprint

; ============ CLOUD 3 ============    

; Row 1
mov ax, [gcloud3col]
add ax, 2
push ax
mov ax, [gcloud3row]
push ax
call gposition
mov ax, bx
mov cx, 3
call gprint

; Row 2
mov ax, [gcloud3col]
push ax
mov ax, [gcloud3row]
add ax, 1
push ax
call gposition
mov ax, bx
mov cx, 7
call gprint

; Row 3
mov ax, [gcloud3col]
add ax, 1
push ax
mov ax, [gcloud3row]
add ax, 2
push ax
call gposition
mov ax, bx
mov cx, 5
call gprint

; ============ CLOUD 4 ============    

; Row 1
mov ax, [gcloud4col]
add ax, 2
push ax
mov ax, [gcloud4row]
push ax
call gposition
mov ax, bx
mov cx, 5
call gprint

; Row 2
mov ax, [gcloud4col]
push ax
mov ax, [gcloud4row]
add ax, 1
push ax
call gposition
mov ax, bx
mov cx, 9
call gprint

; Row 3
mov ax, [gcloud4col]
add ax, 2
push ax
mov ax, [gcloud4row]
add ax, 2
push ax
call gposition
mov ax, bx
mov cx, 5
call gprint

; ============ CLOUD 5 ============    

; Row 1
mov ax, [gcloud5col]
add ax, 3
push ax
mov ax, [gcloud5row]
push ax
call gposition
mov ax, bx
mov cx, 6
call gprint

; Row 2
mov ax, [gcloud5col]
add ax, 1
push ax
mov ax, [gcloud5row]
add ax, 1
push ax
call gposition
mov ax, bx
mov cx, 10
call gprint

; Row 3
mov ax, [gcloud5col]
push ax
mov ax, [gcloud5row]
add ax, 2
push ax
call gposition
mov ax, bx
mov cx, 12
call gprint

; Row 4
mov ax, [gcloud5col]
add ax, 2
push ax
mov ax, [gcloud5row]
add ax, 3
push ax
call gposition
mov ax, bx
mov cx, 8
call gprint

pop cx
pop bx
pop ax
ret

gclrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov al, ' '
    mov ah, 0x07
gclearing:
    mov word[es:di], ax
    add di, 2
    cmp di, 4000
    jne gclearing
    ret
    
gposition:
    push bp
    mov bp, sp
    push ax
    
    mov ax, [gvideomembase]
    mov es, ax              
    mov al, [gscreencols]
    mul byte [bp+4]
    add ax, [bp+6]        
    shl ax, 1               
    mov si, ax    
    
    pop ax
    pop bp
    ret 4

gvertical:
    push cx 
gverticalline:
    mov [es:di], ax
    add di, 160
    loop gverticalline
    pop cx
    ret

gprintvert:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call gvertical
    pop es
    pop di
    pop ax
    pop bp
    ret

gballoon:
    push cx
gballoonprn:
    mov [es:di], ax
    add di, 2
    loop gballoonprn
    pop cx
    ret

gthread:
    push cx               
gthreadloop:
    mov [es:di], ax       
    add di, 160         
    loop gthreadloop
    pop cx
    ret

gprint:
    push bp
    mov bp, sp
    push ax
    push di
    push es
    mov di, si
    call gballoon 
    pop es
    pop di
    pop ax
    pop bp
    ret

gfillbackground:
    mov ax, [gvideomembase]
    mov es, ax
    mov di, 0             
    mov cx, [gscreensize]
    mov al, [gspacechar]     
    mov ah, [gbgcolorbyte]
gfillloop:
    mov [es:di], ax
    add di, 2   
    loop gfillloop
    ret 

gprinttext:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push di
    push si

    mov ax, [gvideomembase]
    mov es, ax
    mov di, [bp+8] 
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, 0xB0

gnextchar:
    mov al, [si]
    mov [es:di], ax
    add di, 2
    inc si
    loop gnextchar

    pop si
    pop di
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

draw_gameplay_screen:
    ; disable blinking to enable all 16 background colors
    mov ax, 1003h
    mov bl, [gcursoroff]
    int 10h
      call gclrscr
    call gfillbackground     
    call gdraw_clouds

    ; score print
	game_display:      ; subroutine label
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    mov ax, [gscorecol]
    push ax
    mov ax, [gscorerow]
    push ax
    call gposition
    
    push si
    mov ax, gscore
    push ax
    push word [gscorelength]
    call gprinttext

    ; INITIAL SCORE VALUE (0)
    call gprint_score_num
    
    ; time print
    mov ax, [gtimecol]
    push ax
    mov ax, [gtimerow]
    push ax
    call gposition
    
    push si
    mov ax, gtime
    push ax
    push word [gtimelength]
    call gprinttext

    ; INITIAL TIME VALUE (2:00)
    call gprint_time_num

    ; INITIALIZE CLOCK for timer
    mov ax, 0x40
    mov es, ax
    mov ax, [es:0x6c] 
    mov [glast_tick], ax
    
    ; VOLUME speaker base
    mov bl, [gvolspeakerchar]
    mov bh, [gvolspeakercolor]
    
    mov ax, [gvolbcol]
    push ax
    mov ax, [gvolbrow]
    push ax
    call gposition
    mov ax, bx
    mov cx, [gvolblen]
    call gprint
    
    ; triangle middle
    mov ax, [gvoltcol]
    push ax
    mov ax, [gvoltrow]
    push ax
    call gposition
    mov ax, bx
    mov cx, 1
    call gprint
    
    ; triangle bottom
    mov ax, [gvoltcol]
    push ax
    mov ax, [gvoltbotrow]
    push ax
    call gposition
    mov ax, bx
    mov cx, 1
    call gprint
    
    ; triangle top
    mov ax, [gvoltcol]
    push ax
    mov ax, [gvolttoprow]
    push ax
    call gposition
    mov ax, bx
    mov cx, 1
    call gprint
    
    ; WAVES
    mov bl, [gvolwavechar]
    mov bh, [gvolwavecolor]
    
    ; wave 1
    mov ax, [gvolw1col]
    push ax 
    mov ax, [gvolw1row]
    push ax 
    call gposition 
    mov ax, bx
    mov cx, [gvolw1len]
    call gprintvert
    
    ; wave 2
    mov ax, [gvolw2col]
    push ax 
    mov ax, [gvolw2row]
    push ax 
    call gposition 
    mov ax, bx
    mov cx, [gvolw2len]
    call gprintvert
    
    ; wave 3
    mov ax, [gvolw3col]
    push ax 
    mov ax, [gvolw3row]
    push ax 
    call gposition 
    mov ax, bx
    mov cx, [gvolw3len]
    call gprintvert
    
    call gdraw_clouds   ; cloud

    call gget_random_letter
    mov [gb1letterchar], al
    
    call gget_random_letter
    mov [gb2letterchar], al
    
    call gget_random_letter  
    mov [gb3letterchar], al
    
    call gget_random_letter
    mov [gb4letterchar], al

    ; DRAW BALLOONS initially
    call gdraw_balloons
  
 

;------ BALLOON MOVEMENT ----------
gballoon_loop:

    ; --- TIMER UPDATE CHECK ---
    ; Check BIOS clock area (0040:006C) for ticks
    push ax
    push bx
    push es
    
    mov ax, 0x40
    mov es, ax
    mov ax, [es:0x6c]  ;;bulding clck is at 6c, Read current tick count
    mov bx, [glast_tick]
    sub ax, bx
    cmp ax, 18         ;18.2 ticks=1sec
    jl gskip_timer
    
    ; 1 Second has passed
    mov ax, [es:0x6c]
    mov [glast_tick], ax ; Reset last tick
    
    ; Decrement Logic
    mov ax, [gtimer_sec]   ;minute se borrow
    cmp ax, 0
    jne gdec_sec
    ; Seconds is 0
    mov ax, [gtimer_min]
    cmp ax, 0
    je gtimer_finished ; 0:00 reached
    dec word [gtimer_min]
    mov word [gtimer_sec], 59  ;59 seconds
    jmp gupdate_timer_display
    
	
	gdec_sec:
    dec word [gtimer_sec]
    
gupdate_timer_display:
    call gprint_time_num
    
    ; this checks if timer reached 0;00
    mov ax, [gtimer_min]
    cmp ax, 0
    jne gskip_timer
    mov ax, [gtimer_sec]
    cmp ax, 0
    jne gskip_timer
    
    ; Timer reached 0 so GAME OVER
    jmp draw_gameover_screen  ; jmp to game over screen
    
gtimer_finished:
    ; Timer reached 0, game continues or can end here
	
gskip_timer:
    pop es
    pop bx
    pop ax
	
    ; --- END TIMER CHECK ---
  ;  call gplay_background_music
    ; this whole delay section just wastes time to slow down balloon movement
    mov bx, [gballoonspeed]
gouterloop:
    mov cx, 0xFFFF
ginnerloop:
    dec cx
    jnz ginnerloop
    dec bx
    jnz gouterloop
    
    ; --- KEYBOARD INTERRUPT
    mov ah, 0x01
    int 0x16
    jz gno_key_pressed
    
    mov ah, 0x00
    int 0x16
    mov [gkeypressed], al
	
	  cmp al, 0x20        ; Check if char is Space
    je go_space     ; If Space, jump 
	
	
    
    ; convert lowercase to uppercase
    cmp al, 'a'
    jb gnotlowercase
    cmp al, 'z'
    ja gnotlowercase
    sub al, 32
    mov [gkeypressed], al
    
gnotlowercase:
    ; check balloon 1
    mov al, [gb1letterchar]
    cmp al, [gkeypressed]
    jne gcheck_balloon2
    call gclear_single_balloon1
    jmp gredrawballoons
    
gcheck_balloon2:
    mov al, [gb2letterchar]
    cmp al, [gkeypressed]
    jne gcheck_balloon3
    call gclear_single_balloon2
    jmp gredrawballoons
    
gcheck_balloon3:
    mov al, [gb3letterchar]
    cmp al, [gkeypressed]
    jne gcheck_balloon4
    call gclear_single_balloon3
    jmp gredrawballoons
    
gcheck_balloon4:
    mov al, [gb4letterchar]
    cmp al, [gkeypressed]
    jne gno_key_pressed
    call gclear_single_balloon4
    jmp gredrawballoons


    
gno_key_pressed:
    ;KEYBOARD INTERRUPT  END 
    ;no key pressed so normal code for movement
    call gclearballoons
    ;--------------Balloon 1 moved up by 1 row

        dec word [gb1row]
    dec word [gb1letterrow]
    dec word [gb1threadrow]
    cmp word [gb1row], 1    ;reset when balloon reaches row 1
    jne gnextballoon1
    mov word [gb1row], 25
    mov ax, [gb1row]
    add ax, [gletteroffset]
    mov [gb1letterrow], ax
    mov ax, [gb1row]
    add ax, [gthreadoffset]
    mov [gb1threadrow], ax
    call gget_random_letter
    mov [gb1letterchar], al
gnextballoon1:
    ;balloon 2 up by 1 row
    dec word [gb2row]
    dec word [gb2letterrow]
    dec word [gb2threadrow]
    cmp word [gb2row], 1
    jne gnextballoon2
    mov word [gb2row], 25
    mov ax, [gb2row]
    add ax, [gletteroffset]
    mov [gb2letterrow], ax
    mov ax, [gb2row]
    add ax, [gthreadoffset]
    mov [gb2threadrow], ax
    call gget_random_letter
    mov [gb2letterchar], al
gnextballoon2:

    ; balloon 3 up by 1 row
    dec word [gb3row]
    dec word [gb3letterrow]
    dec word [gb3threadrow]
    cmp word [gb3row], 1
    jne gnextballoon3
    mov word [gb3row], 25
    mov ax, [gb3row]
    add ax, [gletteroffset]
    mov [gb3letterrow], ax
    mov ax, [gb3row]
    add ax, [gthreadoffset]
    mov [gb3threadrow], ax
    call gget_random_letter
    mov [gb3letterchar], al
gnextballoon3:

    ;balloon 4 up by 1 row
    dec word [gb4row]
    dec word [gb4letterrow]
    dec word [gb4threadrow]
    cmp word [gb4row], 1
    jne gnextballoon4
    mov word [gb4row], 25
    mov ax, [gb4row]
    add ax, [gletteroffset]
    mov [gb4letterrow], ax
    mov ax, [gb4row]
    add ax, [gthreadoffset]
    mov [gb4threadrow], ax
    call gget_random_letter
    mov [gb4letterchar], al
gnextballoon4:


gredrawballoons:
call gdraw_clouds
   ;redraw balloons at new positions
    call gdraw_balloons

    
  ;infinite loop
    jmp gballoon_loop
; ----------  CLEAR BALLOONS ---erase balloons with bgr color

gclearballoons:
    push ax
    push bx
    push cx
    push dx
    

    mov bl, [gspacechar]
    mov bh, [gbgcolorbyte]
    
    ;clear balloon 1 area
    mov dx, [gclearheight]
gclear_b1loop:
    mov ax, [gb1col]
    sub ax, 1
    push ax
    mov ax, [gb1row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b1loop
    
    ;clear balloon 2 area
    mov dx, [gclearheight]
gclear_b2loop:
    mov ax, [gb2col]
    sub ax, 1
    push ax
    mov ax, [gb2row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b2loop
    
    ;clear balloon 3 area
    mov dx, [gclearheight]
gclear_b3loop:
    mov ax, [gb3col]
    sub ax, 1
    push ax
    mov ax, [gb3row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b3loop
    
    ;clear balloon 4 area
    mov dx, [gclearheight]
gclear_b4loop:
    mov ax, [gb4col]
    sub ax, 1
    push ax
    mov ax, [gb4row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b4loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret


;-----------------------------
; DRAW BALLOONS here we redraw all 4 balloons at current positions
;-------------------------------------

    gdraw_balloons:
    ; BALLOON 1
    mov bl, [gb1char]
    mov bh, [gb1color]
    
    ; Row 1
    mov ax, [gb1col]
    push ax
    mov ax, [gb1row]
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    ; Row 2
    mov ax, [gb1col]
    sub ax, 1
    push ax
    mov ax, [gb1row]
    add ax, 1
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    ; Row 3
    mov ax, [gb1col]
    sub ax, 1
    push ax
    mov ax, [gb1row]
    add ax, 2
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    ; Row 4
    mov ax, [gb1col]
    sub ax, 1
    push ax
    mov ax, [gb1row]
    add ax, 3
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    ; Row 5
    mov ax, [gb1col]
    push ax
    mov ax, [gb1row]
    add ax, 4
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    ; Row 6
    mov ax, [gb1col]
    add ax, 1
    push ax
    mov ax, [gb1row]
    add ax, 5
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w3len]
    call gprint
    
    ; Thread
    mov bl, [gthreadchar]
    mov bh, [gthreadcolor]
    
    mov ax, [gb1threadcol]
    push ax
    mov ax, [gb1threadrow]
    push ax
    call gposition 
    mov di, si    
    mov ax, bx
    mov cx, [gb1threadlen]
    call gthread
    
    ; Letter
    mov ax, [gb1lettercol]
    push ax
    mov ax, [gb1letterrow]
    push ax
    call gposition 
    mov di, si
    mov al, [gb1letterchar]
    mov ah, [gb1lettercolor]
    mov [es:di], ax
    
    ; BALLOON 2
    mov bl, [gb2char]
    mov bh, [gb2color]
    
    mov ax, [gb2col]
    push ax
    mov ax, [gb2row]
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    mov ax, [gb2col]
    sub ax, 1
    push ax
    mov ax, [gb2row]
    add ax, 1
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb2col]
    sub ax, 1
    push ax
    mov ax, [gb2row]
    add ax, 2
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb2col]
    sub ax, 1
    push ax
    mov ax, [gb2row]
    add ax, 3
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb2col]
    push ax
    mov ax, [gb2row]
    add ax, 4
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    mov ax, [gb2col]
    add ax, 1
    push ax
    mov ax, [gb2row]
    add ax, 5
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w3len]
    call gprint
    
    mov bl, [gthreadchar]
    mov bh, [gthreadcolor]
    
    mov ax, [gb2threadcol]
    push ax
    mov ax, [gb2threadrow]
    push ax
    call gposition 
    mov di, si    
    mov ax, bx
    mov cx, [gb1threadlen]
    call gthread
    
    mov ax, [gb2lettercol]
    push ax
    mov ax, [gb2letterrow]
    push ax
    call gposition 
    mov di, si
    mov al, [gb2letterchar]
    mov ah, [gb2lettercolor]
    mov [es:di], ax
    
    ; BALLOON 3
    mov bl, [gb3char]
    mov bh, [gb3color]
    
    mov ax, [gb3col]
    push ax
    mov ax, [gb3row]
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    mov ax, [gb3col]
    sub ax, 1
    push ax
    mov ax, [gb3row]
    add ax, 1
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb3col]
    sub ax, 1
    push ax
    mov ax, [gb3row]
    add ax, 2
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb3col]
    sub ax, 1
    push ax
    mov ax, [gb3row]
    add ax, 3
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb3col]
    push ax
    mov ax, [gb3row]
    add ax, 4
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    mov ax, [gb3col]
    add ax, 1
    push ax
    mov ax, [gb3row]
    add ax, 5
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w3len]
    call gprint
    
    mov bl, [gthreadchar]
    mov bh, [gthreadcolor]
    
    mov ax, [gb3threadcol]
    push ax
    mov ax, [gb3threadrow]
    push ax
    call gposition 
    mov di, si    
    mov ax, bx
    mov cx, [gb1threadlen]
    call gthread
    
    mov ax, [gb3lettercol]
    push ax
    mov ax, [gb3letterrow]
    push ax
    call gposition 
    mov di, si
    mov al, [gb3letterchar]
    mov ah, [gb3lettercolor]
    mov [es:di], ax
    
    ; BALLOON 4
    mov bl, [gb4char]
    mov bh, [gb4color]
    
    mov ax, [gb4col]
    push ax
    mov ax, [gb4row]
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    mov ax, [gb4col]
    sub ax, 1
    push ax
    mov ax, [gb4row]
    add ax, 1
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb4col]
    sub ax, 1
    push ax
    mov ax, [gb4row]
    add ax, 2
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb4col]
    sub ax, 1
    push ax
    mov ax, [gb4row]
    add ax, 3
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w2len]
    call gprint
    
    mov ax, [gb4col]
    push ax
    mov ax, [gb4row]
    add ax, 4
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w1len]
    call gprint
    
    mov ax, [gb4col]
    add ax, 1
    push ax
    mov ax, [gb4row]
    add ax, 5
    push ax
    call gposition           
    mov ax, bx
    mov cx, [gb1w3len]
    call gprint
    
    mov bl, [gthreadchar]
    mov bh, [gthreadcolor]
    
    mov ax, [gb4threadcol]
    push ax
    mov ax, [gb4threadrow]
    push ax
    call gposition 
    mov di, si    
    mov ax, bx
    mov cx, [gb1threadlen]
    call gthread
    
    mov ax, [gb4lettercol]
    push ax
    mov ax, [gb4letterrow]
    push ax
    call gposition 
    mov di, si
    mov al, [gb4letterchar]
    mov ah, [gb4lettercolor]
    mov [es:di], ax
    
    ret

    gclear_single_balloon1:
    push ax
    push bx
    push cx
    push dx
    call gplay_pop_sound
    mov bl, [gspacechar]
    mov bh, [gbgcolorbyte]
    
    mov dx, [gclearheight]
gclear_b1_single:
    mov ax, [gb1col]
    sub ax, 1
    push ax
    mov ax, [gb1row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b1_single
    
    mov word [gb1row], 25
    mov ax, [gb1row]
    add ax, [gletteroffset]
    mov [gb1letterrow], ax
    mov ax, [gb1row]
    add ax, [gthreadoffset]
    mov [gb1threadrow], ax
    call gget_random_letter
    mov [gb1letterchar], al
    
    add word [gcurrent_score], 10
    call gprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


gclear_single_balloon2:
    push ax
    push bx
    push cx
    push dx
    call gplay_pop_sound
    mov bl, [gspacechar]
    mov bh, [gbgcolorbyte]
    
    mov dx, [gclearheight]
gclear_b2_single:
    mov ax, [gb2col]
    sub ax, 1
    push ax
    mov ax, [gb2row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b2_single
    
    mov word [gb2row], 25
    mov ax, [gb2row]
    add ax, [gletteroffset]
    mov [gb2letterrow], ax
    mov ax, [gb2row]
    add ax, [gthreadoffset]
    mov [gb2threadrow], ax
    call gget_random_letter
    mov [gb2letterchar], al
    
    add word [gcurrent_score], 10
    call gprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


gclear_single_balloon3:
    push ax
    push bx
    push cx
    push dx
    call gplay_pop_sound
    mov bl, [gspacechar]
    mov bh, [gbgcolorbyte]
    
    mov dx, [gclearheight]
gclear_b3_single:
    mov ax, [gb3col]
    sub ax, 1
    push ax
    mov ax, [gb3row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b3_single
    
    mov word [gb3row], 25
    mov ax, [gb3row]
    add ax, [gletteroffset]
    mov [gb3letterrow], ax
    mov ax, [gb3row]
    add ax, [gthreadoffset]
    mov [gb3threadrow], ax
    call gget_random_letter
    mov [gb3letterchar], al
    
    add word [gcurrent_score], 10
    call gprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret


gclear_single_balloon4:
    push ax
    push bx
    push cx
    push dx
    call gplay_pop_sound
    mov bl, [gspacechar]
    mov bh, [gbgcolorbyte]
    
    mov dx, [gclearheight]
gclear_b4_single:
    mov ax, [gb4col]
    sub ax, 1
    push ax
    mov ax, [gb4row]
    add ax, dx
    sub ax, 1
    push ax
    call gposition
    mov ax, bx
    mov cx, [gclearwidth]
    call gprint
    dec dx
    jnz gclear_b4_single
    
    mov word [gb4row], 25
    mov ax, [gb4row]
    add ax, [gletteroffset]
    mov [gb4letterrow], ax
    mov ax, [gb4row]
    add ax, [gthreadoffset]
    mov [gb4threadrow], ax
    call gget_random_letter
    mov [gb4letterchar], al
    
    add word [gcurrent_score], 10
    call gprint_score_num

    pop dx
    pop cx
    pop bx
    pop ax
    ret

;;;;;;;;;;;; SCORE/TIME ---

; Prints  value in current_score next to score:
gprint_score_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    ; Calculate position: Row 1, Col (scorecol + scorelength + 1)
    mov ax, [gscorecol]
    add ax, [gscorelength]
    add ax, 1 ; Space
    push ax
    mov ax, [gscorerow]
    push ax
    call gposition
    mov di, si
    
    mov ax, [gvideomembase]
    mov es, ax
    
    mov ax, [gcurrent_score]
    mov bx, 10
    mov cx, 0
    
gget_digits:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne gget_digits
    
    mov ah, [gscoretextcolor]
gprint_digits:
    pop dx
    add dl, 0x30 ; convert to ascii
    mov al, dl
    mov [es:di], ax
    add di, 2
    loop gprint_digits
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Prints timer M:SS
gprint_time_num:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    ; Calculate position: Row 3, Col (timecol + timelength + 1)
    mov ax, [gtimecol]
    add ax, [gtimelength]
    add ax, 1
    push ax
    mov ax, [gtimerow]
    push ax
    call gposition
    mov di, si
    
    mov ax, [gvideomembase]
    mov es, ax
    
    ; Print Minute
    mov ax, [gtimer_min]
    add al, 0x30
    mov ah, [gtimetextcolor] ; Explicitly reload color (Cyan background)
    mov [es:di], ax
    add di, 2
    
    ; Print Colon
    mov al, ':'
    mov ah, [gtimetextcolor]
    mov [es:di], ax
    add di, 2
    
    ; Print Seconds (Tens place)
    mov ax, [gtimer_sec]
    xor dx, dx
    mov bx, 10
    div bx
    ; AX is quotient (tens), DX is remainder (ones)
    add al, 0x30
    mov ah, [gtimetextcolor]
    mov [es:di], ax
    add di, 2
    
    ; Print Seconds (Ones place)
    mov al, dl
    add al, 0x30
    mov ah, [gtimetextcolor]
    mov [es:di], ax
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
	
	
go_space:
    call draw_gpause_screen
	
