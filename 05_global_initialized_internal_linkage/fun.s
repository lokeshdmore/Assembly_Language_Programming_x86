/* =================================================================
 *	Code   : 05_global_initialized_internal_linkage(fun.s)
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 02nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_fun_print:
    .string "in fun, iNo is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

# definition of static initialized variable 
.type   iNo, @object
.size   iNo, 4
.align  4, 4
iNo:
    .int    10

/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== TEXT SECTION ========================= */
.section .text

# fun function() execution Code
.globl  fun
.type   fun, @function
fun:
    pushl   %ebp
    movl    %esp, %ebp

    movl    iNo, %eax
    pushl   %eax
    pushl   $msg_fun_print
    call    printf
    addl    $8, %esp 

    movl    %ebp, %esp
    popl    %ebp
    ret 


/* ==================== TEXT SECTION ENDS HERE ===================== */

