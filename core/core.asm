bits 16 
init_array :
	push bx 
	push cx 
	push ds 
    xor bx,bx
    loop12 :
		mov si , [arr] ; array address
        mov  [si+bx], byte 0 
        inc bx
		mov ax , 2401
        cmp bx ,ax
        jl loop12
	
	
	mov si , [arr]
    mov bx , 1199
    mov byte [si+bx] ,   1
    mov bx , 1200
    mov byte [si+bx] ,   1
    mov bx , 1201
    mov byte [si+bx] ,   1
	
	
	mov si , [dir_arr]
    mov bx , 0
    mov byte [si+bx] ,   2
    mov bx , 1
    mov byte [si+bx] ,   2
	
	
	call put_obsatcles
	pop ds 
	pop cx 
	pop bx 
    ret




draw_frame :
    xor cx ,cx 	; x =1 
	;mov cx , 24
	loop44 : 
		xor di ,di  ; y = 0
		;mov di , 24
		loop55:   
			push di  ; di = 0
			push cx
			mov ax , 49  ; ax = 49
			mul di       ; ax = 0
			add ax , cx  ; ax = 0 + 1 = 1
			mov bx , ax  ; bx = 1
			mov si , word [arr]  
			mov al , byte [si+bx]  ; al = 1  
			cmp al , 1  ;  ; true
			jne loop555  ; 
		draw:
			push ax 
			mov ax , 4   ; ax = 4 
			mul di       ;  ax = 0
			mov bx , 2   ; bx = 2
			add ax , bx  ; ax = 2 
			
			mov si , ax  ; j = y*4+2  = dx = 2 
			mov ax , 4   ;  ax = 4
			mul cx       ;  ax = 2*1 = 2
			mov bx , 62  ;  bx = 62 
			add ax ,bx   ; i = x*4+62 ; ax = 64 
			pop bx 
			push ax 
			push si
			push 4
			push 4 
			push 0fh
			call draw_rectangle 
			add esp , 10 
			jmp endloop
			loop555:
				cmp al , 2 
				je draw 
			endloop:
				pop cx   ; cx =1 
				pop di   ; di = 0
				inc di   ; di = 1
				mov ax , 49 
				cmp di , ax  
				jl loop55
		inc cx 
		mov ax , 49 
		cmp cx ,ax 
		jl loop44
	ret
			

handle_input:
	
	mov ah , 01h ;check keyboard status
	int 16h 
	jz _none 
	
	mov ah , 10h  ; get pressed key
	int 16h
	
	;get the key in al 
	cmp al , 'w'
	je up 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cmp al ,  's'
	je down 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cmp al ,  'a' 
	je left 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
	cmp al ,  'd' 
	je right     
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ah = extend key scan code 
	cmp ah , 48h 
	je up 
	cmp ah , 50h 
	je down 
	cmp ah , 4bh 
	je left 
	cmp ah , 4dh 
	je right 
	jmp _none
	up : 
		mov byte bl , [direction]
		cmp bl , 1 
		je _ignore
		mov byte [direction] , 0 
		ret 
	down : 
		mov byte bl , [direction]
		cmp bl , 0
		je _ignore
		mov byte [direction] , 1 
		ret
	left : 
		mov byte bl , [direction]
		cmp bl , 3 
		je _ignore
		mov byte [direction] , 2 
		ret 
	right :
		mov byte bl , [direction]
		cmp bl , 2 
		je _ignore
		mov byte [direction] , 3 
		ret 
	_ignore:
	_none : 
		ret 

update :  
	mov al , byte [head_x]
	mov cl , byte [head_y]
	mov bl , byte [direction] 
	cmp bl , 0 
	je _movUp
	cmp bl , 1 
	je _movDown
	cmp bl , 2 
	je _movLeft
	cmp bl , 3 
	je _movRight 
	ret
	_movUp   : 
		cmp cl , 0  ; y = 0 
		je _tunUp 
		dec cl  	; y=y-1
		jmp return_update
	_movDown : 
		cmp cl , 48 ; y
		je _tunDwn
		inc cl  ; y = y+1
		jmp return_update
	_movLeft : 
		cmp al , 0 
		je _tunLeft
		dec al ; x=x-1
		jmp return_update  
	_movRight:  
		cmp al , 48 
		je _tunRight 
		inc al ; x=x+1
		jmp return_update 
	
	_tunUp : 
		mov cl , 48 
		jmp return_update  
	_tunDwn : 
		mov cl , 0 
		jmp return_update  
	_tunLeft : 
		mov al , 48 
		jmp return_update  
	_tunRight:
		mov al , 0 
		jmp return_update 
		
	return_update:  
		mov byte [head_x] , al 
		mov byte [head_y] , cl 
		push ax 
		push cx  
		
		mov byte bl , [direction] 
		
		mov si , [dir_arr]
		mov ax , [snakeLength] 
		dec ax 
		add si , ax 
		mov byte [si] , bl 
		
		call check
		
		pop cx 
		pop ax
		
		push ax 
		push cx 
		push 1 
		call set_value
		add esp , 6	 
		ret
	end_update:
		ret	
		
set_value : 
	mov byte cl , [esp+6]
	mov byte al , [esp+4]
	xor dx , dx 
	mov dx , [esp+2]
	xor ah , ah 
	xor ch , ch 
	mov bl , 49 
	mul bl 
	add ax , cx
	mov bx , ax  
	mov di , word [arr] ;word [si]
	mov  byte [di+bx] , dl
	ret
	
sleep : 
	mov si , 1
	mov bx , [46ch] 
	xor di  ,di 
	timer : 
		mov ax  , [46ch]
		sub ax , bx 
		cmp ax ,2 
		jl timer
		mov bx , [46ch]
		inc di 
		cmp di , si
		jl timer 
	ret
	

remove_tail : 
	xor cx , cx 
	xor bx , bx
	xor ax , ax
	mov cl , [tail_x]
	mov bl , [tail_y]
	
	push cx 
	push bx 
	push 0 
	call set_value
	add esp , 2 
	
	
	mov bx , [dir_arr]
	mov byte al , [bx]  
	
	pop bx 
	pop cx 
	
	cmp al , 0 
	je tail_up 
	cmp al , 1 
	je tail_down 
	cmp al , 2 
	je tail_left 
	cmp al , 3 
	je tail_right 
	jmp end_tail 
	tail_up : 
		cmp bl, 0 
		je tuntup 
		dec bl 
		jmp return_tail 
		
	tail_down : 
		cmp bl, 48 
		je tuntdown 
		inc bl 
		jmp return_tail 
	
	tail_left : 
		cmp cl, 0 
		je tuntleft 
		dec cl 
		jmp return_tail 
	
	tail_right : 
		cmp cl, 48 
		je tuntright 
		inc cl 
		jmp return_tail 
		
	tuntup: 
		mov bl , 48
		jmp return_tail
		
	tuntdown: 
		mov bl , 0
		jmp return_tail
	
	tuntleft: 
		mov cl , 48
		jmp return_tail
		
	tuntright: 
		mov cl , 0
		jmp return_tail 
		
	return_tail: 
		mov byte [tail_x] , cl 
		mov byte [tail_y] , bl 
		
		call shift_array 
	end_tail : 
		ret



print_decimal :   
	xor dx , dx 
	mov ax , [esp+2]  ; 1023
	mov bx , 10000 
	div bx  
	
	;mov al , ah
	mov bx , table 
	xlat
	mov ah , 0x0e 
	int 10h 
	
	mov ax , dx 
	xor dx , dx 
	mov bx , 1000 
	div bx 
	
	mov bx , table 
	xlat
	mov ah , 0x0e 
	int 10h 
	
	mov ax , dx
	xor dx , dx 
	mov bx  ,100 
	div bx 
	
	mov bx , table 
	xlat
	mov ah , 0x0e  
	int 10h 
	
	mov ax , dx 
	xor dx , dx 
	mov bx , 10 
	div bx 
	
	mov bx , table 
	xlat
	mov ah , 0x0e 
	int 10h  
	
	mov ax , dx 
	mov bx , table 
	xlat 
	mov ah , 0x0e 
	int 10h
	ret 
	
	
display_score : 
	mov al , 13 
	mov ah , 0x0e 
	int 10h 
	
	mov word ax , [score]
	push ax 
	call print_decimal 
	add esp , 2 
	
	ret
	
rng : 
	xor dx , dx
	mov ax ,[46ch] 
	mov bx , 49  
	div bx  
	xor dh , dh 
	xor ax , ax 
	mov ax , dx 
	ret 
	
rng2 : 
	xor dx , dx 
	mul al 
	mov bx , 49  
	div bx  
	xor dh , dh 
	xor ax , ax 
	mov ax , dx 
	ret 
	
get_value : 
	mov byte cl , [esp+4]  ;x 
	mov byte al , [esp+2]  ;y
	xor ah , ah 
	xor ch , ch
	mov bl , 49 
	mul bl 
	add ax , cx
	mov bx , ax  
	xor ax ,ax 
	mov di , word [arr] 
	mov  al , byte [di+bx] 
	ret
	
put_food : 
	xor cx , cx 
	xor bx , bx
	checkSnakeBody: 
		call rng  
		push ax	
		call rng2 
		mov cx , ax 
		pop bx 
		push bx 
		push cx 
		call get_value 
		pop cx 
		pop bx
		xor ah , ah
		cmp al , 1  
		je checkSnakeBody 
		cmp al , 2 
		je checkSnakeBody
	push bx
	push cx 
	push 2 
	call set_value  
	add esp , 6
	ret  

check :  
	push ax 
	push bx 
	push cx 
	push dx 
	push di 
	push si 

	xor bx , bx 
	xor ax , ax 
	xor cx , cx
	
	mov cl , [esp+16]  ; x  
	mov bl , [esp+14]  ; y
	
	push cx 
	push bx 
	call get_value 
	pop bx 
	pop cx
	
	xor ah , ah  
	cmp al , 1 
	je _dead 
	cmp al , 2 
	je _eat 
	jmp _mov 
	
	_dead : 
		mov word [gameState] , 1 
		call sleep
		call sleep
		call sleep 
		call sleep 
		call sleep 
		call Game_over
		jmp end_check 
	_eat  : 
		mov si , word [score] 
		inc si 
		mov word [score] , si 
		
		mov si ,word  [snakeLength] 
		inc si 
		mov word [snakeLength] , si 
		call put_food
		jmp end_check 
	_mov :
		call remove_tail 
	end_check :
		pop si 
		pop di 
		pop dx 
		pop cx 
		pop bx
		pop ax 
		ret 
	
shift_array :  
		xor si , si   
		mov si , 1
		shiftLoop: 
			mov bx , [dir_arr] 
			mov byte cl , [bx+si] 
			mov byte [bx+si-1] , cl 
			mov di , word [snakeLength]
			inc si 
			cmp si , di
			jl shiftLoop 
		ret  
		
put_obsatcles: 
	mov bx, [arr] 
	mov byte [bx+606] , 1 
	mov byte [bx+607] , 1 
	mov byte [bx+608] , 1 
	mov byte [bx+609] , 1 
	mov byte [bx+610] , 1 
	mov byte [bx+611] , 1 
	mov byte [bx+612] , 1 
	mov byte [bx+613] , 1 
	mov byte [bx+614] , 1 
	mov byte [bx+615] , 1 
	mov byte [bx+616] , 1 
	mov byte [bx+617] , 1 
	mov byte [bx+618] , 1 
	
	mov byte [bx+1782] , 1 
	mov byte [bx+1783] , 1 
	mov byte [bx+1784] , 1 
	mov byte [bx+1785] , 1 
	mov byte [bx+1786] , 1 
	mov byte [bx+1787] , 1 
	mov byte [bx+1788] , 1 
	mov byte [bx+1789] , 1 
	mov byte [bx+1790] , 1 
	mov byte [bx+1791] , 1 
	mov byte [bx+1792] , 1 
	mov byte [bx+1793] , 1 
	mov byte [bx+1794] , 1

	mov byte [bx+992]  , 1
	mov byte [bx+1041] , 1
	mov byte [bx+1090] , 1
	mov byte [bx+1139] , 1
	;mov byte [bx+1188] , 1
	mov byte [bx+1237] , 1
	mov byte [bx+1286] , 1
	mov byte [bx+1335] , 1
	
	mov byte [bx+1016] , 1
	mov byte [bx+1065] , 1
	mov byte [bx+1114] , 1
	mov byte [bx+1163] , 1
	mov byte [bx+1212] , 1
	mov byte [bx+1261] , 1
	mov byte [bx+1310] , 1
	mov byte [bx+1359] , 1
	ret
	
	
Game_over:  
	
	push 0 
	push 0 
	push 320                  ; clear screen 
	push 200 
	push 0 
	call draw_rectangle 
	add esp , 10 
	
	xor bx , bx 
	displaymsg: 
		mov byte al , [gameOverMsg+bx]  
		cmp al , 0
		jz return_it
		mov ah , 0x0e 
		int 10h  
		 inc bx 
		jmp displaymsg 
	return_it:
		mov word ax ,[score] 
		push ax 
		call print_decimal 
		add esp , 2  
		xor bx , bx
		displaymsg2 : 
			mov byte al , [pressRestart+bx]  
			cmp al , 0
			jz return_it2
			mov ah , 0x0e 
			int 10h  
			 inc bx 
			jmp displaymsg2   
	return_it2:
		mov ah , 10h 
		int 16h   
		
		db 0x0ea 
		dw 0xffff ; jmp far 0xffff (CTRL+ALT+DEL) 
		dw 0x0000 
		ret
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	