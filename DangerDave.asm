[org 0x0100] 
jmp start 
length: dw 160
width: dw 24
message: db 'SCORE: ' ; for now score is set to 0
l: dw 7
leftPosx: dw 3
leftPosy: dw 20
rightPosx: dw 9
rightPosy: dw 20
topPosx: db 6
topPosy: db 20
bottomPosx: db 6
bottomPosy: db 22
score: dw 0
message1 : db	'DANGEROUS DAVE'
len : dw 14
rule1: db 'Press Enter Key To Continue'  
l1: dw 27
rule2: db 'Press Escape To Exit'
l2 : dw 20
rule3: db ':) Collect As Many Goodies As Possible :)'  
l3 : dw 41
lengthr : dw 45
widthr : dw  11


printnum: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax  
 mov ax, [bp+4] 
 mov bx, 10  
 mov cx, 0 
nextdigit:
 mov dx, 0  
 div bx 
 add dl, 0x30 
 push dx  
 inc cx
 cmp ax, 0 
 jnz nextdigit 
 mov di, 1044
 nextpos: 
 pop dx 
 mov dh, 0x83
 mov [es:di], dx 
 add di, 2
 loop nextpos
 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax 
 pop es 
 pop bp 
 ret 2 
 
clrscr: 
 push es 
 push ax 
 push di
 mov ax, 0xb800 
 mov es, ax 
 mov di, 0
 
nextloc: 
 mov word [es:di], 0x0720
 add di, 2 
 cmp di, 4000
 jne nextloc
 pop di 
 pop ax 
 pop es 
 ret 
 
 printstring:
 push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di

 mov ax, 0xb800
 mov es, ax
 mov al, 80
 mul byte[bp+10]
 add ax, [bp+12]
 shl ax, 1
 mov di, ax
 mov si, [bp+6]
 mov cx, [bp+4]
 mov ah, [bp+8]

 nextch:	
 mov al, [si]
 mov[es:di], ax
 add di, 2
 add si, 1
 loop nextch

 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 10

rectangle: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push di 
 
 mov ax, 0xb800 
 mov es, ax
 mov al, 80
 mul byte [bp+10] 
 add ax, [bp+12] 
 shl ax, 1  
 mov di, ax 
 mov cx, [bp+6]
 mov ah, [bp+8]
 
 pl: 
 mov al, 42
 mov [es:di], ax
 add di, 2
 loop pl
 
 mov cx, [bp+4]
 add di, 158
 sub cx, 2
 
 pw:
 mov al, 42
 mov [es:di], ax
 add di, 160
 loop pw
 
 mov cx, [bp+6]
 sub cx, 1
 
 pl2: 
 mov al, 42
 mov [es:di], ax
 sub di, 2 
 loop pl2
 
 mov cx, [bp+4]
 
 pw2:
 mov al, 42
 mov [es:di], ax
 sub di, 160
 loop pw2
 
 pop di 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 10 
 
 printscore: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax 
 mov ax, [bp+4]
 mov bx, 10
 mov cx, 0
 
 nextDigit: 
 mov dx, 0
 div bx
 add dl, 0x30 
 push dx 
 inc cx 
 cmp ax, 0 
 jnz nextDigit 
 mov di, 176
 
 nextPos: 
 pop dx 
 mov dh, 0x40 
 mov [es:di], dx 
 add di, 2 
 loop nextPos
 
 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax 
 pop es 
 pop bp 
 ret 2
 
sleep: 
 push cx
 mov cx, 0xFFFF
 delay: 
 loop delay
 pop cx
 ret
 
theEnd:
 push es 
 push ax 
 push cx 
 push di
 push bx 
 push dx
 
 call clrscr
 mov ax, 34
 push ax
 mov ax, 6
 push ax
 mov ax, 0x03
 push ax
 mov ax, message
 push ax
 push word[l]
 call printstring
 
 push word[score]
 call printnum
 
 mov ax, 0 ; x position
 push ax  
 mov ax, 7 ; y position
 push ax 
 mov ax, 0x44
 push ax
 mov ax, 160
 push ax
 mov ax, 3
 push ax
 call drawrect
 
 mov ax, 0 ; x position
 push ax  
 mov ax, 15 ; y position
 push ax 
 mov ax, 0x44
 push ax
 mov ax, 160
 push ax
 mov ax, 3
 push ax
 call drawrect
 
 mov ax, 0 ; x position
 push ax  
 mov ax, 11 ; y position
 push ax 
 mov ax, 0x77
 push ax
 mov ax, 5
 push ax
 mov ax, 4
 push ax
 call drawrect
 
 mov ax, 6
 push ax
 mov ax, 12
 push ax
 mov ax, 0x0F ;attribute
 push ax
 call drawDave
 
 mov cx, 33
 mov dx, 6
 loop2:
 mov ax, dx ; x position
 push ax  
 mov ax, 12 ; y position
 push ax 
 mov ax, 0x07 ;attribute
 push ax
 call removeDave
 call sleep
 call sleep
 
 add dx, 2
 mov ax, dx
 push ax
 mov ax, 12
 push ax
 mov ax, 0x0F ;attribute
 push ax
 call drawDave
 call sleep
 call sleep
 loop loop2
 
 pop dx
 pop bx
 pop di
 pop cx
 pop ax
 pop es
 jmp end
 
drawDave: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push di 
 
 mov ax, 0xb800 
 mov es, ax
 mov al, 80
 mul byte [bp+6] 
 add ax, [bp+8] 
 shl ax, 1  
 mov di, ax 
 mov cx, 10
 mov ah, [bp+4]
  
 mov al, '\' 
 mov [es:di], ax
 add di, 2 
 mov al, '('
 mov [es:di], ax
 add di, 2 
 mov al, '-'
 mov [es:di], ax
 add di, 2 
 mov al, ','
 mov [es:di], ax
 add di, 2 
 mov al, '-'
 mov [es:di], ax
 add di, 2 
 mov al, ')'
 mov [es:di], ax
 add di, 2 
 mov al, '/'
 mov [es:di], ax
 
 add di, 154
 mov al, '|'
 
 mov [es:di], ax
 add di, 158
 mov al, '/'
 mov [es:di], ax
 add di, 4 
 mov al, '\'
 mov [es:di], ax
 
 pop di 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 6 
 
 removeDave: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push di 
 
 mov ax, 0xb800 
 mov es, ax
 mov al, 80
 mul byte [bp+6] 
 add ax, [bp+8] 
 shl ax, 1  
 mov di, ax 
 mov cx, 10
 mov ah, [bp+4]
  
 mov al, 0x20
 mov [es:di], ax
 add di, 2 
 mov [es:di], ax
 add di, 2 
 mov [es:di], ax
 add di, 2 
 mov [es:di], ax
 add di, 2 
 mov [es:di], ax
 add di, 2 
 mov [es:di], ax
 add di, 2 
 mov [es:di], ax
 
 add di, 154
 
 mov [es:di], ax
 add di, 158
 mov [es:di], ax
 add di, 4 
 mov [es:di], ax
 
 pop di 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 6 
 
removetrophy:
push es
push ax
push di
mov ax,0xb800
mov es,ax
mov di, 410

mov ah, 0x07
mov al, 0x20
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax

add di, 152
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax

add di, 154
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add word[score], 1500
pop di
pop ax
pop es
ret 
 
trophy:
push es
push ax
push di
mov ax,0xb800
mov es,ax
mov di, 410

mov ah, 0x0E
mov al, '_'
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax

add di, 152
mov al, '\'
mov word[es:di], ax
add di, 2
mov al, '_'
mov word[es:di], ax
add di, 2
mov al, '_'
mov word[es:di], ax
add di, 2
mov al, '_'
mov word[es:di], ax
add di, 2
mov al, '/'
mov word[es:di], ax

add di, 154
mov al, '_'
mov word[es:di], ax
add di, 2
mov al, '|'
mov word[es:di], ax
add di, 2
mov al, '_'
mov word[es:di], ax
pop di
pop ax
pop es
ret

printstr: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 mov ax, 0xb800 
 mov es, ax 
 mov di, 162
 mov si, [bp+6]  
 mov cx, [bp+4] 
 mov ah, 0x40 
 
nchar: 
 mov al, [si]  
 mov [es:di], ax 
 add di, 2 
 add si, 1 
 loop nchar
 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 4
 
removecircle:
push es
push ax
push di
mov ax,0xb800
mov es,ax
mov di, 646

mov ah, 0x07
mov al, 0x20
mov word[es:di], ax
add di, 158
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add di, 2
mov word[es:di], ax
add word[score], 750
pop di
pop ax
pop es
ret
 
circle:
push es
push ax
push di
mov ax,0xb800
mov es,ax
mov di, 646

mov ah, 0x0D
mov al, '_'
mov word[es:di], ax
add di, 158
mov al, '('
mov word[es:di], ax
add di, 2
mov al, '_'
mov word[es:di], ax
add di, 2
mov al, ')'
mov word[es:di], ax
pop di
pop ax
pop es
ret

removediamond: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push di 
 
 mov ax, 0xb800 
 mov es, ax
 mov al, 80
 mul byte [bp+4] 
 add ax, [bp+6] 
 shl ax, 1  
 mov di, ax 
 mov cx, 10
 mov ah, 0x07
  
 mov al, 0x20 ; underscore
 mov [es:di], ax
 add di, 2
 mov [es:di], ax ; underscore
 add di, 158
 mov [es:di], ax
 add di, 2
 mov [es:di], ax
 add word[score], 500
 
 pop di 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 4
 
drawdiamond: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push di 
 
 mov ax, 0xb800 
 mov es, ax
 mov al, 80
 mul byte [bp+6] 
 add ax, [bp+8] 
 shl ax, 1  
 mov di, ax 
 mov cx, 10
 mov ah, [bp+4]
  
 mov al, 0x5F ; underscore
 mov [es:di], ax
 add di, 2
 mov [es:di], ax ; underscore
 add di, 158
 mov al, 0x5C ; backslash
 mov [es:di], ax
 add di, 2
 mov al, 0x2F ;slash
 mov [es:di], ax
 
 pop di 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 6 
 
doorknob:
push es
push ax
push di
mov ax,0xb800
mov es,ax
mov di,3476

loc:
mov word[es:di],0x7E2A
pop di
pop ax
pop es
ret
  
drawlines: 
push bp
mov bp,sp
push es
push ax
push cx
push si
push di
push bx
mov bl,0x2A
mov ax,0xb800
mov es,ax
mov al,80
mul byte[bp+12]
add ax,[bp+10]
shl ax,1
mov cx,[bp+6]
mov di,ax
mov ah,[bp+8]
mov al,bl
nextchar: mov[es:di],ax
add di,2
loop nextchar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov al,80
mov bh,[bp+12]
add bh,[bp+4]
mul bh
add ax,[bp+10]
shl ax,1
mov cx,[bp+6]
mov di,ax

mov ah,[bp+8]
mov al,bl
nextchar2:
 mov[es:di],ax
add di,2
loop nextchar2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov al,80
mov bh,[bp+12]
add bh,1
mul bh
add ax,[bp+10]
shl ax,1
mov cx,[bp+6]
mov di,ax
mov ah, [bp+14];
mov al,bl

loop1: 
mov[es:di],ax

add di,2
loop loop1


pop bx
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 10

drawrect: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push di 
 
 mov ax, 0xb800 
 mov es, ax
 mov al, 80
 mul byte [bp+10] 
 add ax, [bp+12] 
 shl ax, 1  
 mov di, ax 
 mov cx, [bp+6]
 mov ah, [bp+8]
 
 printl: 
 mov al, 0x20
 mov [es:di], ax
 add di, 2
 loop printl
 
 mov cx, [bp+4]
 add di, 158
 sub cx, 2
 
 printw:
 mov al, 0x20
 mov [es:di], ax
 add di, 160
 loop printw
 
 mov cx, [bp+6]
 sub cx, 1
 
 printl2: 
 mov al, 0x20
 mov [es:di], ax
 sub di, 2 
 loop printl2
 
 mov cx, [bp+4]
 
 printw2:
 mov al, 0x20
 mov [es:di], ax
 sub di, 160
 loop printw2
 
 pop di 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 10 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 movement:
 push ax 
 push es 
 push bx
 push ds
 push bp
 push dx
 push si
 push di
 
 mov ax, 0xb800 
 mov es, ax ; point es to video memory 
 in al, 0x60 ; read a char from keyboard port 
 cmp al, 0x01 ; escape
 jne next
 call clrscr
 jmp end
 next:
 cmp al, 0x1C ; enter
 jne nextt
 jmp part2
 nextt:
 cmp al, 0x4B ; left arrow
 je leftMov 
 cmp al, 0x48 ;up
 jne next1
 jmp upMov
 next1:
 cmp al, 0x4D ; right
 jne next2
 jmp rightMov
 next2:
 cmp al, 0x50 ;down
 je DM
 jmp final_ret
 DM:
 jmp downMov 
 jmp final_ret
 
 leftMov:
 mov bx, [leftPosx]
 sub bx, 2
 
 ;;calculating new left position of dave
 mov al, 80
 mul byte[leftPosy]  
 add ax, bx
 shl ax, 1

 ;;reading character from video base at above calculated poistion and comparing it to check if we can move or not
 mov si, ax 
 mov dx, [es:si]
 
 cmp dx, 0x1120  ;blue tunnel
 je ret2
 cmp dx, 0x772A ;door
 je theEnd ; function to display end screen
 cmp dl, 0x2a  ;hurdles
 je ret2
 cmp dx, 0x4020 ;boundaries
 je ret2
 cmp dx, 0x0E5F ;trophy
 jne n1
 call removetrophy
 n1:

 jmp movDave1

 ret2:
 jmp ret1

 movDave1:
 mov ax, [leftPosx] ; x position
 push ax  
 mov ax, [leftPosy] ; y position
 push ax 
 mov ax, 0x07 ;attribute
 push ax
 call removeDave
 
 mov word[leftPosx], bx 
 push word[leftPosx]  
 push word[leftPosy] ; y position
 mov ax, 0x0F ;attribute
 push ax
 call drawDave
 
 ; updating old positions to new ones
 mov bx, 2
 sub word[rightPosx], bx
 sub word[topPosx], bx
 sub word[bottomPosx], bx
 
 mov al, 80
 mov bx,[leftPosy]  
 add bx, 1
 mul bl
 add ax, [leftPosx]
 shl ax, 1
 
 mov si, ax 
 mov dx, [es:si] 
 
 cmp dl, 0x5F  ;diamond
 jne skip1
 mov ax, [leftPosx]
 sub ax, 1
 push ax
 push bx
 call removediamond
 skip1:
 jmp return
 
 ret1:
 jmp return1
  
 rightMov:
 mov bx, [rightPosx]
 add bx, 2
 
 mov al, 80
 mul byte[rightPosy]  
 add ax, bx
 shl ax, 1 
  
 mov si, ax 
 mov dx, [es:si]
 
 ;;reading character from video base at above calculated poistion and comparing it to check if we can move or not
 cmp dx, 0x4020 ;border
 je return1
 cmp dl, 0x2a 
 je return1
 cmp dx, 0x0E5F ;trophy
 jne c
 call removetrophy
 c:
 cmp dl, 0x5F ; red diamond 045f
 jne movDave
 mov ax, [rightPosx]
 add ax, 2
 push ax
 push word[rightPosy]
 call removediamond
 jmp movDave
 
 return1:
 jmp return
 
 movDave:
 push word[leftPosx] 
 push word[leftPosy]
 mov ax, 0x07 ;attribute
 push ax
 call removeDave
 
 mov bx, 2
 add word[leftPosx], bx
 
 push word[leftPosx]  
 push word[leftPosy] ; y position
 mov ax, 0x0F ;attribute
 push ax
 call drawDave
 
 add word[rightPosx], bx
 add word[topPosx], bx
 add word[bottomPosx], bx
  
 mov al, 80
 mov bx,[rightPosy]  
 add bx, 1
 mul bl
 add ax, [rightPosx]
 shl ax, 1
 
 mov si, ax 
 mov dx, [es:si] 
 
 cmp dl, 0x5F  ;diamond
 jne skip2
 mov ax, [rightPosx]
 sub ax, 1
 push ax
 push bx
 call removediamond
 skip2:
 jmp return
 
 upMov: 
 mov bx, [leftPosy]
 sub bx, 1
 mov al, 80
 mul bl 
 add ax, [leftPosx]
 shl ax, 1
  
 mov si, ax 
 mov dx, [es:si]

 cmp dl, 0x2a  ;hurdles
 jne d1
 jmp return
 d1:
 cmp dx, 0x4020 ;boundaries
 jne d2
 jmp return
 
 d2:
 mov bx, [rightPosy]
 sub bx, 1
 mov al, 80
 mul bl 
 add ax, [rightPosx]
 shl ax, 1
  
 mov si, ax 
 mov dx, [es:si]

 cmp dl, 0x2a  ;hurdles
 jne e1
 jmp return
 e1:
 cmp dx, 0x4020 ;boundaries
 jne e2
 jmp return
 e2:
 mov bx, [leftPosy]
 sub bx, 3
 mov al, 80
 mul bl
 add ax, [leftPosx]
 shl ax, 1
  
 mov si, ax 
 mov dx, [es:si]
 cmp dl, 0x5F
 jne movDave2
 call removecircle
 
 movDave2:
 push word[leftPosx] ; x position
 push word[leftPosy] ; y position
 mov ax, 0x07 ;attribute
 push ax
 call removeDave
 
 mov bx, 3
 sub word[leftPosy], bx
  
 push word[leftPosx]  
 push word[leftPosy] ; y position
 mov ax, 0x0F ;attribute
 push ax
 call drawDave
 
 mov bx, 3
 sub word[rightPosy], bx
 sub word[topPosy], bx
 sub word[bottomPosy], bx
 jmp return
 
 downMov:
 mov bx, [leftPosy]
 add bx, 3
 
 mov al, 80
 mul bl
 add ax, [leftPosx]
 shl ax, 1
 
 mov si, ax 
 mov dx, [es:si]
 
 cmp dl, 0x2a  ;hurdles
 je ret3
 cmp dx, 0x4020 ;boundaries
 je ret3
 
 mov bx, [rightPosy]
 add bx, 3
 
 mov al, 80
 mul bl  
 add ax, [rightPosx]
 shl ax, 1
 
 mov si, ax 
 mov dx, [es:si]
 
 cmp dx, 0x062a  ;hurdles
 je ret3
 cmp dx, 0x4020 ;boundaries
 je ret3
 
 mov bx, [leftPosy]
 add bx, 3
 mov al, 80
 mul bl
 add ax, [leftPosx]
 shl ax, 1
  
 mov si, ax 
 mov dx, [es:si]
 cmp dl, 0x5F
 jne movDave3
 call removecircle
 jmp movDave3
 
 ret3:
 jmp return
 
 movDave3:
 mov ax, [leftPosx] ; x position
 push ax  
 mov ax, [leftPosy] ; y position
 push ax 
 mov ax, 0x07 ;attribute
 push ax
 call removeDave
 
 mov bx, 3
 add word[leftPosy], bx
  
 push word[leftPosx]  
 push word[leftPosy] ; y position
 mov ax, 0x0F ;attribute
 push ax
 call drawDave
 
 mov bx, 3
 add word[rightPosy], bx
 add word[topPosy], bx
 add word[bottomPosy], bx
 jmp return
 
 return:
 push word[score]
 call printscore
 final_ret:
 mov al, 0x20 
 out 0x20, al ; send EOI to PIC 
 pop di
 pop si
 pop dx
 pop bp
 pop ds
 pop bx
 pop es 
 pop ax 
 iret
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 start: 
 call clrscr
 
 xor ax, ax 
 mov es, ax ; point es to IVT base 
 cli ; disable interrupts 
 mov word [es:9*4], movement ; store offset at n*4 
 mov [es:9*4+2], cs ; store segment at n*4+2 
 sti 

 mov ax, 31
 push ax
 mov ax, 10
 push ax
 mov ax, 132
 push ax
 mov ax, message1
 push ax
 push word[len]
 call printstring

 mov ax, 184
 push ax
 mov ax, 10
 push ax
 mov ax, 4
 push ax
 mov ax,rule1
 push ax
 push word[l1]
 call printstring

 mov ax, 188
 push ax
 mov ax, 11
 push ax
 mov ax, 4
 push ax
 mov ax,rule2
 push ax
 push word[l2]
 call printstring

 mov ax, 177
 push ax
 mov ax, 12
 push ax
 mov ax, 4
 push ax
 mov ax,rule3
 push ax
 push word[l3]
 call printstring

 mov ax, 15 ; x position
 push ax  
 mov ax, 7 ; y position
 push ax 
 mov ax, 142 
 push ax
 push word [lengthr]
 push word [widthr] 
 call rectangle

 mov ax, 13 ; x position
 push ax  
 mov ax, 6 ; y position
 push ax 
 mov ax, 6
 push ax
 mov ax, 49
 push ax
 mov ax, 13
 push ax
 call rectangle

 mov ax, 11 ; x position
 push ax  
 mov ax, 5 ; y position
 push ax 
 mov ax, 142
 push ax
 mov ax, 53
 push ax
 mov ax, 15
 push ax
 call rectangle
 
 mov ah, 0 
 int 0x16
 
 part2:
 mov al, 0x20 
 out 0x20, al
 mov cx, 10
 
 l4:
 pop ax
 loop l4
 
 call clrscr
 mov ax, 0 ; x position
 push ax  
 mov ax, 0 ; y position
 push ax 
 mov ax, 0x40
 push ax
 push word [length]
 push word [width] 
 call drawrect
 
 mov ax, 75 ; x position
 push ax  
 mov ax, 2 ; y position
 push ax 
 mov ax, 0x84 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 0x84
 push ax ;attribute for centre line
 mov ax, 5; row
 push ax
 mov ax, 11;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 14 ; x position
 push ax  
 mov ax, 3 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 5; row
 push ax
 mov ax, 27;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 30 ; x position
 push ax  
 mov ax, 3 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 5; row
 push ax
 mov ax, 43;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 5; row
 push ax
 mov ax, 59 ;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 call trophy
 
 mov ax, 62 ; x position
 push ax  
 mov ax, 3 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 11; row
 push ax
 mov ax, 1 ;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 4 ; x position
 push ax  
 mov ax, 9 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 11; row
 push ax
 mov ax, 19 ;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 22 ; x position
 push ax  
 mov ax, 9 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 11; row
 push ax
 mov ax, 35 ;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 38 ; x position
 push ax  
 mov ax, 9 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 11; row
 push ax
 mov ax, 51 ;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 54 ; x position
 push ax  
 mov ax, 9 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 11; row
 push ax
 mov ax, 67 ;column
 push ax

 mov ax,6
 push ax
 mov ax,12
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 72 ; x position
 push ax  
 mov ax, 9 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 17; row
 push ax
 mov ax, 14 ;column
 push ax

 mov ax,6
 push ax
 mov ax,17
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 28 ; x position
 push ax  
 mov ax, 15 ; y position
 push ax 
 mov ax, 0x83 ;attribute for diamond
 push ax
 call drawdiamond
 
 mov ax, 17; row
 push ax
 mov ax, 43 ;column
 push ax

 mov ax,6
 push ax
 mov ax,25
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 20; row
 push ax
 mov ax, 43 ;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 
 mov ax, 20; row
 push ax
 mov ax, 43 ;column
 push ax

 mov ax,6
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 pop ax
 
 mov ax, 0x77
 push ax
 mov ax, 20; row
 push ax
 mov ax, 52 ;column
 push ax

 mov ax,0x77
 push ax
 mov ax,8
 push ax
 mov ax,2
 push ax
 call drawlines
 pop ax
 
 call doorknob
 call circle
 
 mov ax, message 
 push ax 
 push word [l]
 call printstr 
  
 mov ax, 0 ; x position
 push ax  
 mov ax, 20 ; y position
 push ax 
 mov ax, 0x11
 push ax
 mov ax, 2
 push ax
 mov ax, 3
 push ax
 call drawrect
 
 mov ax, 3 ; x position
 push ax  
 mov ax, 20 ; y position
 push ax 
 mov ax, 0x0F ;attribute
 push ax
 call drawDave
 
 ll1:
 mov ah, 0 ; service 0 – get keystroke 
 int 0x16
 jmp ll1
 
 end:
 mov cx, 9
 
 ll2:
 pop ax
 loop ll2
 
 mov ax, 0x4c00 ; terminate program 
 int 0x21