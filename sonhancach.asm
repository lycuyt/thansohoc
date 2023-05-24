.model small
.stack 100h
.data
    hoten db "NGUYEN THI CAM LY$"  
    str db " :$"   
    date db "30-05-2003$"  
    mgs db 13,10,"SO NHAN CACH la $"   
    tmp db ?
    me db ? 
    sum db ?
    kq db ?  
    truoc db ?
    sauu db ?  
    check db ?
    check1 db ?
    check2 db ? 
    tt db ?
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, hoten
    int 21h
    
    mov ah,9
    lea dx, str
    int 21h
    
    mov ah,9 
    lea dx, date
    int 21h
    
    mov ah,9
    lea dx, mgs
    int 21h
    ; tinh chi so nhan cach, tinh phu am
    lea si, hoten
    mov cl,0
    lap:
        mov dl,[si]
        mov tmp,dl
        cmp tmp,'Y'
        je xuli
        call kiemtra
        cmp check,1 ; la nguyen am
        je con
        ; Y la truong hop dac biet, xet truoc va sau y la nguyen am hay phu am
        jne tiep 
        xuli:
            mov dl,tmp
            mov tt,dl
            
            call xuliY
            cmp check,1 ; la nguyen am
            je con
        
        
        tiep:
        
            call change
            mov dl, me
            add sum,dl
            ;add dl,'0'
            ;mov ah,2
            ;int 21h
         
        con:    
         inc si
         cmp [si],'$'
         je break
         jmp lap 
    break:
     mov ax,0
     mov al, sum
     call inra 
     mov dl, kq
     add dl, '0'
     mov ah, 2
     int 21h
    
    mov ah, 4ch
    int 21h 
    
    
    
main endp

    
change proc
      ; chuyen chu thanh so   
      ; truoc do phai nhet no vao tmp    
      cmp tmp,'A'
      je mot
      cmp tmp,'J'
      je mot
      cmp tmp,'S'
      je mot 
      
      cmp tmp,'B'
      je hai
      cmp tmp,'K'
      je hai
      cmp tmp,'T' 
      je hai
      
      cmp tmp,'C'
      je ba
      cmp tmp,'L'
      je ba
      cmp tmp,'U'
      je ba   
      
      cmp tmp,'D'
      je bon
      cmp tmp,'M'
      je bon
      cmp tmp,'V'
      je bon
      
      cmp tmp,'E'
      je nam
      cmp tmp,'N'
      je nam
      cmp tmp,'W'
      je nam
      
      cmp tmp,'F'
      je sau
      cmp tmp,'O'
      je sau
      cmp tmp,'X'
      je sau  
      
      cmp tmp,'G'
      je bay
      cmp tmp,'P'
      je bay
      cmp tmp,'Y'
      je bay
      
      cmp tmp,'H'
      je tam
      cmp tmp,'Q'
      je tam
      cmp tmp,'Z'
      je tam
      
      cmp tmp,'I'
      je chin
      cmp tmp,'R'
      je chin
      
      mov me,0 
      jmp tieptuc
      mot:
        mov me, 1
        jmp tieptuc
      hai:
        mov me, 2
        jmp tieptuc
      ba:
        mov me, 3
        jmp tieptuc
      bon:
        mov me, 4
        jmp tieptuc
      nam:
        mov me, 5
        jmp tieptuc
      sau:
        mov me, 6
        jmp tieptuc
      bay:
        mov me, 7
        jmp tieptuc
      tam:
        mov me, 8
        jmp tieptuc
      chin:
        mov me, 9
        jmp tieptuc
      tieptuc:
        
     RET
 change endp
kiemtra proc
    ; kiem tra tmp la nguyen am hay phu am, nguyen am tra ve 1, phu am tra ve 0
      
        cmp tmp,'A'
        je continue
        cmp tmp,'E'
        je continue
        cmp tmp,'U'
        je continue
        cmp tmp,'I'
        je continue
        cmp tmp,'O'
        je continue 
        ;cmp tmp,'$'
        ;je xxx
        mov check,0
        jmp het
        ;xxx: 
            ;mov check,2
            ;jmp het
       continue:
        mov check,1
       het:
            RET
kiemtra endp
       
inra proc 
        
        mov cx,0
        mov bx,10
        lap1:
            mov dx,0
            div bx
            push dx
            inc cx
            cmp ax,0
            jnz lap1
       
        
        
        lap2:
             
            ;mov ah,2
            pop dx
            ;add dl,'0'
            ;int 21h 
            add kq,dl
            loop lap2 
            
  ret
  
inra endp
xuliY proc
       ; xu li ki tu Y, check=0->phu am, check=1->nguyenam\
       mov dl, [si-1]
       mov truoc,dl
       mov dl,[si+1]
       mov sauu,dl
       
       mov al, truoc
       mov tmp,al
       call kiemtra
       mov al, check
       mov check1,al  
        
       mov al, sauu
       mov tmp,al
       call kiemtra
       mov al, check
       mov check2,al 
       
       cmp check1, 0; truoc la phu am
       je nguyenam
       jmp phuam
       
       nguyenam:
        cmp check2,0
        je ra1
        jne ra2
       phuam:
        cmp check2,1
        je ra2
        jne ra1
       ra1:
        mov check,1
        jmp en
       ra2:
        mov check,0
       en:
         mov dl,tt
         mov tmp,dl
       
        
        RET
xuliY endp        
            
end main      
      
      
      
      
        