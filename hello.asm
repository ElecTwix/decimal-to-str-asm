section .data

section .bss
  string_buffer: resb 32

section .text
  global _start

_start:
  mov edi, string_buffer
  mov eax, 123 ;; the decimal that will printed out
  add edi, 32

  ;; 10 for std endline
  mov byte [edi], 10
  dec edi

  mov cl, 1

  call loop

loop:
  inc cl ;; total char
  mov bx, 10 ;; reset
  div bx ;; divide eax by bx
  add dx, 48 ;; giving offset
  mov [edi], dl ;; set buffer
  xor dx, dx ;; reseting dx
  dec edi ;; dec adress for reverse str
  cmp al, BYTE 0
  jne loop
 
  inc cl

  mov edx, ecx
  mov ecx, edi

  jmp print

print:
  mov eax,4            ; The system call for write (sys_write)
  mov ebx,1            ; File descriptor 1 - standard output
  ;ecx is adress of buffer 
  ;edx is len
  int 80h              ; Call the kernel

  jmp exit


exit:
  mov eax,1            ; The system call for exit (sys_exit)
  mov ebx,0            ; Exit with return code of 0 (no error)
  int 80h
