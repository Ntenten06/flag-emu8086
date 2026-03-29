.model small
.stack 100h

.data

.code
main proc
    mov ax, @data
    mov ds, ax

    ; เข้าโหมดกราฟิก
    mov ax, 0013h
    int 10h

    mov dx, 0          ; y = 0

y_loop:
    mov cx, 0          ; x = 0

x_loop:
    mov ah, 0Ch        ; วาด pixel

    ; =========================
    ; แบ่ง 3 ส่วนแนวตั้ง (320/3 ≈ 106)
    ; =========================
    
    cmp cx, 106
    jl green_part

    cmp cx, 212
    jl white_part

    jmp orange_part

green_part:
    mov al, 2          ; เขียว
    jmp draw_pixel

white_part:
    mov al, 15         ; ขาว
    jmp draw_pixel

orange_part:
    mov al, 6          ; ส้ม

draw_pixel:
    int 10h

    inc cx
    cmp cx, 320
    jl x_loop

    inc dx
    cmp dx, 200
    jl y_loop

    ; รอ key
    mov ah, 00h
    int 16h

    ; กลับ text mode
    mov ax, 0003h
    int 10h

    mov ah, 4Ch
    int 21h

main endp
end main