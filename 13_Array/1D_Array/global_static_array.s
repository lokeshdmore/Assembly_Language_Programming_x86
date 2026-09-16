/* =================================================================
 *	Code   : Global Static Array
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 19th August 2026
 * ================================================================= */

.equ    MAX, 10     # alternative to #define MAX 10

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print1:
    .string "Enter value of n(< %d):\t"

msg_main_enter_value:
    .string "Enter %d value:\t"

msg_main_print_arr1:
    .string "arr1 is:\n"

msg_main_print_arr2:
    .string "arr2 is:\n"

msg_main_print_value:
    .string "%d value is:\t%d\n"

msg_main_scan:
    .string "%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

# initialization of int arr1[]
.globl  arr1
.type   arr1, @object
.size   arr1, 12
.align  4
arr1:
    .int    10
    .int    20
    .int    30


/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== BSS SECTION ========================== */
.section .bss
# initialization of int arr2[]
.comm   arr2, 12, 4

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function execution Code
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $8, %esp    # define iMax and iCounter

    pushl   $MAX
    pushl   $msg_main_print1
    call    printf
    addl    $8, %esp 

    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    /* ===== first for loop starts here ===== */
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR1_CONDITION

LABEL_FOR1:
    pushl   %eax
    pushl   $msg_main_enter_value
    call    printf
    addl    $8, %esp

    movl    -8(%ebp), %eax
    leal    arr2(,%eax,4), %edx
    pushl   %edx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    addl    $1, -8(%ebp)

LABEL_FOR1_CONDITION:
    movl    -8(%ebp), %eax  # iCounter 
    movl    -4(%ebp), %edx  # iMax
    cmpl    %edx, %eax
    jl      LABEL_FOR1

    /* ===== first for loop ends here ===== */

    /* ===== printing of first arr starts here ===== */
    
    pushl   $msg_main_print_arr1
    call    printf
    addl    $4, %esp

    /* === second for loop starts here === */
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR2_CONDITION

LABEL_FOR2:
    movl    arr1(,%eax,4), %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_value
    call    printf
    addl    $12, %esp

    addl    $1, -8(%ebp)


LABEL_FOR2_CONDITION:
    movl    -8(%ebp), %eax
    cmpl    $3, %eax
    jl      LABEL_FOR2

    /* === second for loop ends  here === */

    /* ===== printing of first arr ends here ===== */
    
    /* ===== printing of second arr starts here ===== */
    pushl   $msg_main_print_arr2
    call    printf
    addl    $4, %esp

    /* === third for loop starts here === */
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR3_CONDITION

LABEL_FOR3:
    movl    arr2(,%eax,4), %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_value
    call    printf
    addl    $12, %esp

    addl    $1, -8(%ebp)

LABEL_FOR3_CONDITION:
    movl    -8(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_FOR3

    /* === third for loop ends here === */

    /* ===== printing of second arr ends here ===== */

    pushl   $0
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */

