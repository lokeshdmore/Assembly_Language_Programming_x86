/* =================================================================
 *	Code   : Statements_combined_task.s 
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 30th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
msg_main_print_menu:
    .string "\n1.Addition\n2.Subtraction\n3.Multiplication\n4.Division\n5.Exit\n"

msg_main_print_choice:
    .string "Enter your choice:\t"

msg_main_enter_no:
    .string "Enter two numbers:\t"

msg_main_print_default:
    .string "Enter valid choice\n"

msg_main_print_answer:
    .string "Answer is %d\n\n"

msg_main_print_more_choice:
    .string "Are you want to enter more choice?(1/0):\t"

msg_main_one_digit_scan:
    .string "%d"

msg_main_two_digit_scan:
    .string "%d%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

/* =============== main function code =================== */
.globl main
.type  main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp

    #do_while_loop
LABEL_DO:

    pushl   $msg_main_print_menu
    call    printf
    addl    $4, %esp 

    pushl   $msg_main_print_choice
    call    printf
    addl    $4, %esp 
    
    leal   -16(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_one_digit_scan
    call    scanf
    addl    $8, %esp

    # if(iCh > 0 && iCh < 5)
    movl    -16(%ebp), %eax
    cmpl    $0, %eax
    jle     LABEL_SWITCH_CASE
    movl    -16(%ebp), %eax

    cmpl    $5, %eax
    jge     LABEL_SWITCH_CASE

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

LABEL_SWITCH_CASE:
    movl    -16(%esp), %eax

    cmpl    $1, %eax
    je      LABEL_CASE_1
    
    cmpl    $2, %eax
    je      LABEL_CASE_2

    cmpl    $3, %eax
    je      LABEL_CASE_3

    cmpl    $4, %eax
    je      LABEL_CASE_4

    cmpl    $5, %eax
    je      LABEL_CASE_5

    jmp     LABEL_CASE_DEFAULT


LABEL_CASE_1:
    movl    -4(%ebp), %eax
    movl    -8(%ebp), %edx
    pushl   %edx
    pushl   %eax
    call    addition
    addl    $8, %esp 
    movl    %eax, -12(%ebp)
    jmp     LABEL_ANSWER 


LABEL_CASE_2:
    movl    -4(%ebp), %eax
    movl    -8(%ebp), %edx
    pushl   %edx
    pushl   %eax
    call    subtraction
    addl    $8, %esp 
    movl    %eax, -12(%ebp)
    jmp     LABEL_ANSWER 


LABEL_CASE_3:

    jmp     LABEL_ANSWER 


LABEL_CASE_4:

    jmp     LABEL_ANSWER 

LABEL_CASE_5:
    jmp     LABEL_EXIT

LABEL_CASE_DEFAULT:
    pushl   $msg_main_print_default
    call    printf
    addl    $4, %esp
    movl    $1, -16(%esp)
    jmp     LABEL_WHILE_CONDITION


LABEL_ANSWER:
# outside of switch case 
    movl    %eax, -12(%ebp)
    pushl   %eax
    pushl   $msg_main_print_answer
    call    printf
    addl    $8, %esp 

    pushl   $msg_main_print_more_choice
    call    printf
    addl    $4, %esp

    leal   -16(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_one_digit_scan
    call    scanf
    addl    $8, %esp

LABEL_WHILE_CONDITION:
    movl    -16(%esp), %eax
    cmpl    $1, %eax
    je      LABEL_DO  

LABEL_EXIT:
    pushl   $0
    call    exit
/* ============ main fun code ends here ================= */

/* ================ addition function code ============== */
.globl addition
.type  addition, @function
addition:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp

    movl    8(%ebp), %eax
    movl    12(%ebp), %edx
    addl    %edx, %eax

    movl    %eax, -4(%esp)
    movl    %ebp, %esp  
    popl    %ebp
    ret
/* =========== addition fun code ends here ============== */

/* ============= subtraction function code ============== */
.globl subtraction
.type  subtraction, @function
subtraction:
    pushl   %ebp
    movl    %esp, %ebp
    movl    8(%ebp), %eax
    movl    12(%ebp), %edx
    subl    %edx, %eax 
    movl    %ebp, %esp
    popl    %ebp
    ret
/* ========= subtraction fun code ends here ============= */

/* ============ multiplication function code ============ */
.globl multiplication
.type  multiplication, @function
multiplication:
    pushl   %ebp
    movl    %esp, %ebp


    movl    %ebp, %esp
    popl    %ebp
    ret
/* ========= multiplication fun code ends here ========= */


/* ================ division function code ============= */
.globl division
.type  division, @function
division:
    pushl   %ebp
    movl    %esp, %ebp


    movl    %ebp, %esp
    popl    %ebp
    ret
/* ============= division fun code ends here =========== */

/* ==================== TEXT SECTION ENDS HERE ===================== */

