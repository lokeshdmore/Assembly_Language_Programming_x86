/* =================================================================
 *	Code   : addition of floating point number
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 19th Oct 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print_fNo:
    .string "fNo1 = %f\nfNo2 = %f\n"

    msg_main_print_fAns1:
    .string "fAns1 = %f\t\n"

    msg_main_print_fAns2:
    .string "fAns2 = %f\t\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

# float fNo1 = 10.22f;
.globl  fNo1
.type   fNo1, object
.size   fNo1, 4
.align  4
fNo1:
    .float  10.22                                       # float fNo1 = 10.22f;

# float fNo2 = 20.22f;
.globl  fNo2
.type   fNo2, object
.size   fNo2, 4
.align  4
fNo1:
    .float  20.22                                       # float fNo2 = 20.22f;



/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== BSS SECTION ========================== */
.section .bss
    .comm   fAns1, 4, 4                                 # float fAns1;
    .comm   fAns2, 4, 4                                 # float fAns2;

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text
.globl  main
.type   main, @function
main:
    andl    $(-16), %esp
    pushl   %ebp
    movl    %esp, %ebp
    


    movl    $0, (%esp)
    call    exit 

/* ==================== TEXT SECTION ENDS HERE ===================== */

