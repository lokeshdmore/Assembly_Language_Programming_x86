/* =================================================================
 *	Code   : Call By Address 01
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 5th Aug 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_enter_no:
    .string "Enter two numbers:\t"

msg_main_two_digit_scan:
    .string "%d%d"

msg_main_print_sum:
    .string "Sum is %d\n"

msg_main_print_diff:
    .string "diff is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

/* =========== main function execution code =========== */
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp

    pushl   $msg_main_enter_no
    call    printf
    addl    $4, %esp 
    
    leal    -4(%ebp), %eax
    leal    -8(%ebp), %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_two_digit_scan
    call    scanf
    addl    $12, %esp

    movl    -4(%ebp), %eax
    movl    -8(%ebp), %edx
    leal    -12(%ebp), %ecx
    leal    -16(%ebp), %ebx
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    call    sumDiff
    addl    $16, %esp

    movl    -12(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_print_sum
    call    printf
    addl    $8, %esp

    movl    -16(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_print_diff
    call    printf
    addl    $8, %esp

    pushl   $0
    call    exit 
/* ========== main function code ends here =========== */

/* =========== fun function execution code =========== */
.globl  sumDiff
.type   sumDiff, @function
sumDiff:
    pushl   %ebp
    movl    %esp, %ebp

    movl    8(%ebp), %eax
    movl    12(%ebp), %edx
    addl    %edx, %eax
    movl    16(%ebp), %ebx
    movl    %eax, (%ebx)

    movl    8(%ebp), %eax
    subl    %edx, %eax
    movl    20(%ebp), %ebx
    movl    %eax, (%ebx)

    popl    %ebp
    ret 
/* =========== fun function code ends here =========== */

/* ==================== TEXT SECTION ENDS HERE ===================== */

