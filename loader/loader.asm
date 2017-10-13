[org 0x7c00] ; origin of addresses
mov [ BOOT_DRIVE ], dl ; BIOS stores our boot drive in DL , so it ’ s
; best to remember this for later.
xor si ,si
mov ds , si ;
mov bp , 0xA000 ; Here we set our stack safely out of the
mov sp , bp     ; way , at 0 xA000
mov bx , 0x7e00 ; Load 5 sectors to 0 x0000 ( ES ):0 x7e00 ( BX )
mov dh , 5 ; from the boot disk.
mov dl , [ BOOT_DRIVE ]
call diskload
%include "../main.asm"
%include "diskload.asm"

BOOT_DRIVE : db 0

%assign mysize 510-($-$$)
%warning my  size is mysize
times 510 -($-$$) db 0
dw 0xaa55  ; magic number 
%include "../core/core.asm"
%include "../graphics/graphics.asm"



