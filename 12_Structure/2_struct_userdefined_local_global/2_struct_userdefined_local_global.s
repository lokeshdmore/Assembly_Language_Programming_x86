/* =================================================================
 *	Code   : 2_struct_userdefined_local_global
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 6th Aug 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print1:
.string "Enter obj1 values,\n"

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

msg_main_scan_chChar2:
.string "%c%c"

msg_main_scan_iNo2:
.string "%c%d"

msg_main_scan_shiNo2:
.string "%c%hd"

msg_main_print_obj1:
.string "obj1 is\n"

msg_main_print_obj2:
.string "obj2 is\n"

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

    subl    $13, %esp

/* ------- scanning obj1 -------- */

    pushl   $msg_main_print1
    call    printf
    addl    $4, %esp

    pushl   $msg_main_print_chChar
    call    printf
    addl    $4, %esp

    leal    obj1,%eax
    pushl   %eax
    pushl   $msg_main_scan_chChar1
    call    scanf
    addl    $8, %esp

    pushl   $msg_main_print_iNo
    call    printf
    addl    $4, %esp

    leal    obj1,%eax
    leal    4(%eax), %eax
    pushl   %eax
    pushl   $msg_main_scan_iNo1
    call    scanf
    addl    $8, %esp


    pushl   $msg_main_print_shiNo
    call    printf
    addl    $4, %esp

    leal    obj1, %eax
    leal    8(%eax), %eax
    pushl   %eax
    pushl   $msg_main_scan_shiNo1
    call    scanf
    addl    $8, %esp

/* ------- scanning obj1 ends here -------- */

/* ------- scanning obj2 -------- */
    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

    pushl   $msg_main_print_chChar
    call    printf
    addl    $4, %esp

    leal    -13(%ebp),%eax 
    leal    -12(%ebp),%edx
    pushl   %edx
    pushl   %eax 
    pushl   $msg_main_scan_chChar2
    call    scanf
    addl    $8, %esp

    pushl   $msg_main_print_iNo
    call    printf
    addl    $4, %esp

    leal    -13(%ebp),%eax 
    leal    -8(%ebp), %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_scan_iNo2
    call    scanf
    addl    $8, %esp

    pushl   $msg_main_print_shiNo
    call    printf
    addl    $4, %esp

    leal    -13(%ebp),%eax 
    leal    -4(%ebp), %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_scan_shiNo2
    call    scanf
    addl    $8, %esp

/* ------- scanning obj2 ends here -------- */


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

    pushl   $0
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */
