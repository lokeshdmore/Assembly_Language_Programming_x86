/* =================================================================
 *	Code   : 07_global_uninitialized_internal_Linkage (main.s)
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 02nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_printNo:
    .string "In main, Number is %d\n"

    msg_main_printAddr:
    .string "In main, Addr of Number is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== BSS SECTION ========================== */
.section .bss

.lcomm g_iNo, 4

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function execution code 

.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    movl    g_iNo, %eax 
    pushl   %eax 
    pushl   $msg_main_printNo
    call    printf
    addl    $8, %esp 

    movl    $g_iNo, %edx
    pushl   %edx 
    pushl   $msg_main_printAddr
    call    printf 
    addl    $8, %esp

    call    fun 

    pushl   $0
    call    exit 

/* ==================== TEXT SECTION ENDS HERE ===================== */

