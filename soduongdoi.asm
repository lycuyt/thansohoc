 .model small
 .stack 100h
 .data 
    hovaTen db 'NGUYEN THI CAM LY$'
    ngay db '30-05-2003$'
    crlf db 13,10,'$'
    haiCham db ':$'
    sodd db 'SO DUONG DOI la $'
    
 .code
 
 MAIN Proc
    mov ax,@data
    mov ds,ax 
    mov cx,0
    mov ah,9
    lea dx,hovaTen
    int 21h          ;in hoten
    lea dx ,haiCham
    int 21h          ;in 2 cham
    lea dx,ngay
    int 21h
    lea dx,crlf      ;xuong dong
    int 21h 
    lea dx,sodd      ;in sdd
    int 21h  
    mov ah,0
    lea si,ngay 
    lap:  
    cmp [si],36      ;neu la $ thi het lap
    je hetLap
    cmp [si],48      ;neu <0 va >9 thi ra
    jl  ra
    cmp [si],57
    jg ra 
    mov dl,[si]      ;neu 0<x<9 thi cl+=x
    sub dl,48
    add cl,dl
    ra:
    inc si           ;si++
    jmp lap
    hetLap:  
    cmp cl,10
    jge chuyenDoi     ;neu >=10 thi chuyen
    add cl,48
    mov dl,cl
    mov ah,2
    int 21h 
    mov ah,4ch
    int 21h
    chuyenDoi:
    mov al,cl
    mov dl,10
    div dl         ;ah=ax/10 al=ax%10 
    add al,ah       
    mov cl,al
    jmp hetLap