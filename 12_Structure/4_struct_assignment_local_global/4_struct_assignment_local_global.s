/* =================================================================
 *	Code   : 4_struct_assignment_local_global
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 6th Aug 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print_chChar:
.string "Enter chChar\t:"

msg_main_scan_chChar1:
.string "%c"

msg_main_print_iNo:
.string "Enter iNo\t:"

msg_main_scan_iNo1:
.string "%d"

msg_main_print_shiNo:
.string "Enter shiNo\t:"

msg_main_scan_shiNo1:
.string "%hd"

msg_main_print2:
.string "Enter obj2 values,\n"

msg_main_print_obj1:
.string "obj1 is\n"

msg_main_print_obj2:
.string "obj2 is\n"

msg_main_print_obj3:
.string "obj3 is\n"

msg_main_print_obj:
.string "chChar = %c, iNo = %d, shiNo = %hd\n\n"
/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== BSS SECTION ========================== */
.section .bss

#struct demo obj1;
.comm   obj1, 12, 4

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text

.globl  main
.type   main,@function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $24, %esp   # struct demo obj2 , struct demo obj3

/* ------- scanning obj2 -------- */
    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

    pushl   $msg_main_print_chChar
    call    printf
    addl    $4, %esp

    leal    -12(%ebp),%eax
    pushl   %eax
    pushl   $msg_main_scan_chChar1
    call    scanf
    addl    $8, %esp

    pushl   $msg_main_print_iNo
    call    printf
    addl    $4, %esp

    leal    -8(%ebp),%eax
    pushl   %eax
    pushl   $msg_main_scan_iNo1
    call    scanf
    addl    $8, %esp


    pushl   $msg_main_print_shiNo
    call    printf
    addl    $4, %esp

    leal    -4(%ebp),%eax
    pushl   %eax
    pushl   $msg_main_scan_shiNo1
    call    scanf
    addl    $8, %esp

/* ------- scanning obj2 ends here -------- */
/* ============ print obj2 =========== */
    pushl   $msg_main_print_obj2
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

/* ========= assigning the values of one obj to another =========== */

    leal    obj1, %ebx          # obj1
    leal    -12(%ebp), %ecx     # obj2

    # obj1.chChar = obj2.chChar
    movl    (%ecx), %eax        # ethe jr direct [movl (%ecx), (%ebx)] kel tr error yetoy
    movl    %eax, (%ebx)        # mhanun, ekala deref krun dusrya register mdhye gheun value, dusryala derefer krun
                                # assign krnyacha try kelay

    # obj1.iNo = obj2.iNo  
    movl    4(%ecx), %eax
    movl    %eax, 4(%ebx)

    # obj1.shiNo = obj2.shiNo  
    movl    8(%ecx), %eax
    movl    %eax, 8(%ebx)
    /* ============================ */
    leal    -24(%ebp), %ebx
    # obj3.chChar = obj2.chChar
    movl    (%ecx), %eax
    movl    %eax, (%ebx)

    # obj3.iNo = obj2.iNo  
    movl    4(%ecx), %eax
    movl    %eax, 4(%ebx)

    # obj3.shiNo = obj2.shiNo  
    movl    8(%ecx), %eax
    movl    %eax, 8(%ebx)

/* ============ assigning the values of obj ends here ============ */


/* ============ print obj1 =========== */
    pushl   $msg_main_print_obj1
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

/* ============ print obj3 =========== */
    pushl   $msg_main_print_obj3
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


    pushl   $0
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */
