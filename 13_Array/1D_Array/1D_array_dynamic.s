/* =================================================================
 *	Code   : 1D Dynamic Array
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 19th August 2026
 * ================================================================= */

.equ    NULL, 0

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

msg_main_puts:
    .string "Memory Allocation FAILED"

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

    subl    $12, %esp
    movl    $NULL, -12(%ebp)

    pushl   $msg_main_enter_value_n
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    movl    $4, %eax
    movl    -4(%ebp), %ecx
    mull    %ecx
    pushl   %edx
    pushl   %eax
    call    malloc
    addl    $8, %esp
    movl    %eax, -12(%ebp)

    cmpl    $NULL, %eax 
    je      LABEL_MEM_FAILED

    # for loop 1 starts here
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR1_CONDITION

LABEL_FOR1:
    pushl   %eax
    pushl   $msg_main_enter_value_element
    call    printf
    addl    $8, %esp

    movl    -8(%ebp), %eax 
    movl    -12(%ebp), %edx
    leal    (%edx, %eax, 4), %ecx 
    pushl   %ecx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp 

    addl    $1, -8(%ebp)

LABEL_FOR1_CONDITION:
    movl    -8(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_FOR1

    # for loop 1 ends here

    pushl   $msg_main_entered_elements
    call    printf
    addl    $4, %esp

    # for loop 2 starts here
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR2_CONDITION

LABEL_FOR2:
    movl    -12(%ebp), %edx
    movl    (%edx, %eax, 4), %ecx
    pushl   %ecx
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

    # free(pPtr)
    movl    -12(%ebp), %eax
    pushl   %eax
    call    free
    movl    $NULL, -12(%ebp)

    pushl   $0
    call    exit


LABEL_MEM_FAILED:
    pushl   $msg_main_puts
    call    puts
    addl    $4, %esp
    pushl   $(-1)
    call    exit 

/* ==================== TEXT SECTION ENDS HERE ===================== */

