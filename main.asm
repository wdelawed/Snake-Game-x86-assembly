BITS 16
mov sp, 0xA000
start:
    call start_graphics_mode
    call init_array  
	call put_food 
	MainLoop :  
		call display_score
		call draw_background 
		call draw_frame
		call sleep
		mov ax , [gameState]
		cmp ax , 0 
		jne MainLoop 
		call update
		call handle_input
		jmp MainLoop
    ret
	
	arr :        ; main game array (49,49) that represents  the screen 
    dw 0x9005
	head_x :     ; x coordinate of snake head 
		db 23
	head_y : 	 ; y coordinate of snake head 
		db 24 
	direction :  ;  direction that the snake is moving to
		db 2	 ;  0= up ; 1 = down ; 2 = left ; 3 = right
	tail_x :     ; x coordinate of snake tail 
		db 25    
	tail_y : 
		db 24	 ; y coordinate of snake tail 
	dir_arr : 
		dw 0x9a00  ; pointer to [dir_array] start 
	snakeLength  :  ; the length of the snake 
		dw 3
	table :        ; translation table used for printing hex and decimal score
		db "0123456789ABCDEF" 
	score :        ; the score of the player 
		dw 0 
	gameState  :   ; the state of the game 0 = playing 1 = gameOver 
		dw 0  ;0=playing 
	gameOverMsg: 
		db 10,10,10,10,10,10,10,10,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,"Game Over!",10,13
		db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,"Your Score",10,13 
		db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h ,0
	pressRestart: 
		db 10,13,20h,20h,20h,20h,20h,20h,20h,20h, "press aany key to restart" ,0
		