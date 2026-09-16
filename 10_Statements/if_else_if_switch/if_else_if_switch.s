/* =================================================================
 *	Code   : if-else-if-switch
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print:
    .string "Enter numbers : \t"

msg_main_print_if:
    .string "Number is less than 2\n"

msg_main_print_else_if:
    .string "Number is Greater than 2\n"

msg_main_print_else:
    .string "Number is 2\n"

msg_main_scan:
    .string "%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution code
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $4, %esp

    pushl   $msg_main_print
    call    printf
    addl    $4, %esp 

    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp 


    #if logic
    movl    -4(%ebp), %eax 
    cmpl    $2, %eax
    jl      LABEL_IF_LESS_THAN
    je      LABEL_EQUAL    
    pushl   $msg_main_print_else_if
    call    printf
    addl    $4, %esp
    jmp     LABEL_EXIT

LABEL_IF_LESS_THAN:
    pushl   $msg_main_print_if
    call    printf
    addl    $4, %esp
    jmp     LABEL_EXIT

LABEL_EQUAL:
    pushl   $msg_main_print_else
    call    printf
    addl    $4, %esp

LABEL_EXIT:
    pushl   $0
    call    exit

    

/* ==================== TEXT SECTION ENDS HERE ===================== */
