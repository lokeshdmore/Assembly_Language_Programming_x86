/* =================================================================
 *	Code   : 1_struct_hardcoded_local_global
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 6th Aug 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print1:
.string "obj1 is\n"

msg_main_print2:
.string "obj2 is\n"

msg_main_print_obj:
.string "chChar = %c, iNo = %d, shiNo = %hd\n\n"
/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

# struct demo obj1
.globl  obj1
.type   obj1,@object
.size   obj1, 12
.align  4
obj1:
    .ascii  "A"
    .zero   3
    .int    10
    .value  20

/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== TEXT SECTION ========================= */
.section .text

.globl  main
.type   main,@function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $12, %esp
    movl    $'B', -12(%ebp)
    movl    $30, -8(%ebp)
    movl    $40, -4(%ebp)

    pushl   $msg_main_print1
    call    printf
    addl    $4, %esp

    leal    obj1, %ebx
    xorl    %eax, %eax
    movb    (%ebx), %al 
    movl    4(%ebx), %edx
    xorl    %ecx, %ecx
    movw    8(%ebx), %cx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_obj
    call    printf
    addl    $16, %esp

    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

    leal    -12(%ebp), %ebx
    xorl    %eax, %eax
    movb    -12(%ebp), %al
    movl    -8(%ebp), %edx
    xorl    %ecx, %ecx
    movw    -4(%ebp), %cx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_obj
    call    printf
    addl    $16, %esp 

    pushl   $0
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */
