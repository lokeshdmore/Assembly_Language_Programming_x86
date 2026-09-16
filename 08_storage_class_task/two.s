/* =================================================================
 *	Code   : 08_storage_class_task (two.s)
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_fun1_print1:
    .string "Enter Number: \t"

    msg_fun1_print2:
    .string "In fun1, iNo1 is %d & iNo2 is %d\n"

    msg_fun2_print:
    .string "In static fun2\n"

    msg_fun1_scan:
    .string "%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

# iNo2 variable definition
.type   iNo2, @object
.size   iNo2, 4
.align  4
iNo2:
    .int    40

/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== BSS SECTION ========================== */
.section .bss
.lcomm  iNo1, 4

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text

#fun1 function() execution code
.globl  fun1
.type   fun1, @function
fun1:
    pushl   %ebp
    movl    %esp, %ebp

    pushl   $msg_fun1_print1
    call    printf
    addl    $4, %esp

    leal    iNo1, %eax
    pushl   %eax
    pushl   $msg_fun1_scan
    call    scanf
    addl    $8, %esp

    movl    iNo1, %eax
    movl    iNo2, %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_fun1_print2
    call    printf
    addl    $12, %esp

    call    fun2

    popl    %ebp
    ret

# fun2 function() execution code    
.type   fun2, @function
fun2:
    pushl   %ebp
    movl    %esp, %ebp

    pushl   $msg_fun2_print
    call    printf
    addl    $4, %esp

    popl    %ebp
    ret 

/* ==================== TEXT SECTION ENDS HERE ===================== */


