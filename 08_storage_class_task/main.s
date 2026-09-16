/* =================================================================
 *	Code   : 08_storage_class_task (main.s)
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print1:
    .string "Enter two numbers: \t"

    msg_main_print2:
    .string "In main, %d %d %d\n"

    msg_main_scan:
    .string "%d%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

# iNo1 variable definition
.globl  iNo1
.type   iNo1, @object
.size   iNo1, 4
.align  4
iNo1:
    .int    10

/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== BSS SECTION ========================== */
.section .bss

# iNo2 variable definition
.comm iNo2, 4, 4

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution code 
.globl  main 
.type   main, @function
main:
    pushl   %ebp 
    movl    %esp, %ebp

    subl    $4, %esp

    pushl   $msg_main_print1
    call    printf
    addl    $4, %esp

    leal    iNo2, %eax
    leal    -4(%ebp), %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $12, %esp

    movl    iNo1, %eax
    movl    iNo2, %edx
    movl    -4(%ebp), %ebx
    pushl   %ebx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print2
    call    printf
    addl    $16, %esp

    call    fun1

    pushl   $0
    call    exit
    
/* ==================== TEXT SECTION ENDS HERE ===================== */

