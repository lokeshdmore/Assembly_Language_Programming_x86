/* =================================================================
 *	Code   : 3_struct_comparison_local_global
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

msg_main_print3:
.string "obj3 is\n"

msg_main_print_obj1_2_comparison:
.string "obj1 & obj2 comparison is "

msg_main_print_obj2_3_comparison:
.string "obj2 & obj3 comparison is "

msg_main_print_equal:
.string "Equal\n\n"

msg_main_print_not_equal:
.string "not equal\n\n"

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

    subl    $24, %esp

    movl    $'B', -12(%ebp)
    movl    $30, -8(%ebp)
    movl    $40, -4(%ebp)

    movl    $'B', -24(%ebp)
    movl    $30, -20(%ebp)
    movl    $40, -16(%ebp)

/* ============ print obj1 =========== */
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
/* ====== print obj1 ends here ======= */

/* ============ print obj2 =========== */
    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

    leal    -12(%ebp), %ebx
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
/* ====== print obj2 ends here ======= */

/* ============ print obj3 =========== */
    pushl   $msg_main_print3
    call    printf
    addl    $4, %esp

    leal    -24(%ebp), %ebx
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
/* ====== print obj3 ends here ======= */

/* ============ first comparison starts here =============== */

    pushl   $msg_main_print_obj1_2_comparison
    call    printf
    addl    $4, %esp

#if(obj1.chChar == obj2.chChar && obj1.iNo == obj2.iNo && obj1.shiNo == obj2.shiNo)
    leal    obj1, %ebx          # copy addr of obj1 into ebx
    leal    -12(%ebp), %ecx     # copy addr of obj2 into ecx

    # obj1.chChar == obj2.chChar
    #xorl    %eax, %eax
    movb    (%ebx), %al         # al = obj1.chChar
    
    #xorl    %edx, %edx 
    movb    (%ecx), %ah         # ah = obj2.chChar
    
    cmpb    %ah, %al 
    jne     LABEL_NOT_EQUAL1

    # obj1.iNo == obj2.iNo
    movl    4(%ebx), %eax       # eax = obj1.iNo
    movl    4(%ecx), %edx       # edx = obj2,iNo
    cmpl    %eax, %edx
    jne     LABEL_NOT_EQUAL1

    # obj1.shiNo == obj2.shiNo
    #xorl    %eax, %eax
    movw    (%ebx), %ax         # ax = obj1.shiNo
    
    #xorl    %edx, %edx 
    movw    (%ecx), %dx         # dx = obj2.shiNo
    
    cmpw    %dx, %ax
    jne     LABEL_NOT_EQUAL1
 
    pushl   $msg_main_print_equal
    call    printf
    addl    $4, %esp
    jmp     LABEL_2ND_COMPARISON

LABEL_NOT_EQUAL1:
    pushl   $msg_main_print_not_equal
    call    printf
    addl    $4, %esp
/* ============ first comparison ends here =============== */


/* ============ second comparison starts here =============== */

#if(obj3.chChar == obj2.chChar && obj3.iNo == obj2.iNo && obj3.shiNo == obj2.shiNo)
LABEL_2ND_COMPARISON:

    pushl   $msg_main_print_obj2_3_comparison
    call    printf
    addl    $4, %esp

    leal    -12(%ebp), %ebx     # obj2
    leal    -24(%ebp), %ecx     # obj3

    # obj3.chChar == obj2.chChar
    xorl    %eax, %eax
    movl    (%ebx), %eax        # eax = obj2.char
    
    xorl    %edx, %edx 
    movl    (%ecx), %edx        # edx = obj3.char
    
    cmpl    %eax, %edx 
    jne     LABEL_NOT_EQUAL2

    # obj3.iNo == obj2.iNo
    movl    4(%ebx), %eax       # eax = obj2.iNo
    movl    4(%ecx), %edx       # edx = obj3,iNo
    cmpl    %eax, %edx
    jne     LABEL_NOT_EQUAL2

    # obj3.shiNo == obj2.shiNo
    xorl    %eax, %eax
    movl    8(%ebx), %eax        # eax = obj2.shiNo
    
    xorl    %edx, %edx 
    movl    8(%ecx), %edx        # edx = obj3.shiNo
    
    cmpl    %eax, %edx 
    jne     LABEL_NOT_EQUAL2
    
    pushl   $msg_main_print_equal
    call    printf
    addl    $4, %esp

    jmp     LABEL_EXIT

LABEL_NOT_EQUAL2:
    pushl   $msg_main_print_not_equal
    call    printf
    addl    $4, %esp

/* ============ second comparison ends here =============== */



LABEL_EXIT:
    pushl   $0
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */
