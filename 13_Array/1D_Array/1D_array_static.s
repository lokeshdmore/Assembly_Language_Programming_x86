/* =================================================================
 *	Code   : 1D Static Array
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 19th August 2026
 * ================================================================= */

.equ    MAX, 10     # alternative to #define MAX 10

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_enter_value_n:
    .string "Enter value of n(< %d):\t"

msg_main_enter_value_element:
    .string "Enter %d value:\t"

msg_main_entered_elements:
    .string "Entered elements are:\n"

msg_main_print_value:
    .string "%d value is:\t%d\n"

msg_main_scan:
    .string "%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function execution Code
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $48, %esp

    pushl   $MAX
    pushl   $msg_main_enter_value_n
    call    printf
    addl    $8, %esp

    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    # for loop 1 started from here 
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR1_CONDITION

LABEL_FOR1:
    pushl   %eax
    pushl   $msg_main_enter_value_element
    call    printf
    addl    $8, %esp

    movl    -8(%ebp), %eax
    leal    -48(%ebp, %eax, 4), %edx 
    pushl   %edx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp 

    addl    $1, -8(%ebp)

LABEL_FOR1_CONDITION:
    movl    -8(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_FOR1
    
    # for loop 1 ends from here 

    pushl   $msg_main_entered_elements
    call    printf
    addl    $4, %esp

    # for loop 2 started from here
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR2_CONDITION

LABEL_FOR2:
    movl    -48(%ebp, %eax, 4), %edx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_value
    call    printf
    addl    $12, %esp

    addl    $1, -8(%ebp)
    

LABEL_FOR2_CONDITION:
    movl    -8(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_FOR2

    pushl   $0
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */

