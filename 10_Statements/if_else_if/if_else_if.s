/* =================================================================
 *	Code   : if-else-if
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print:
    .string "Enter numbers : \t"

msg_main_print_less:
    .string "Number is less than 2\n"

msg_main_print_greater:
    .string "Number is Greater than 2\n"

msg_main_print_equal:
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
    jge     LABEL_GREATER_OR_EQUAL 
    pushl   $msg_main_print_less
    call    printf
    addl    $4, %esp
    jmp     LABEL_EXIT

LABEL_GREATER_OR_EQUAL:
    je      LABEL_EQUAL
    pushl   $msg_main_print_greater
    call    printf
    addl    $4, %esp
    jmp     LABEL_EXIT  

LABEL_EQUAL:
    pushl   $msg_main_print_equal
    call    printf
    addl    $4, %esp

LABEL_EXIT:
    pushl   $0
    call    exit

    

/* ==================== TEXT SECTION ENDS HERE ===================== */
