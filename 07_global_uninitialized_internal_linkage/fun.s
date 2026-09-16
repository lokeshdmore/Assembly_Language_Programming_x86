/* =================================================================
 *	Code   : 07_global_uninitialized_internal_Linkage (fun.s)
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 02nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_fun_printNo:
    .string "In fun, Number is %d\n"

    msg_fun_printAddr:
    .string "In fun, Addr of Number is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== BSS SECTION ========================== */
.section .bss
    .lcomm g_iNo, 4

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text
# fun function() execution code
.globl  fun
.type   fun, @function
fun:
    pushl   %ebp
    movl    %esp, %ebp

    pushl   g_iNo
    pushl   $msg_fun_printNo
    call    printf
    addl    $8, %esp

    pushl   $g_iNo
    pushl   $msg_fun_printAddr
    call    printf
    addl    $8, %esp

    movl    %ebp, %esp 
    popl    %ebp 
    ret



/* ==================== TEXT SECTION ENDS HERE ===================== */
