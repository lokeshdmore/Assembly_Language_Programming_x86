/* =================================================================
 *	Code   : Local Static  
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 29th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_call_fun1:
    .string "\nCalling fun1\n"

msg_main_call_fun2:
    .string "\nCalling fun2\n"

msg_fun1:
    .string "In fun1(), iNo = %d\n"

msg_fun2:
    .string "In fun2(), iNo = %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data
.type   iNo,@object
.size   iNo, 4
.align  4
iNo:
    .int 10

/* ===================== DATA SECTION ENDS HERE ==================== */


/* ========================== TEXT SECTION ========================= */
.section .text
.globl  main
.type   main, @function

#main() function execution code
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $4, %esp

    pushl   $msg_main_call_fun1
    call    printf
    addl    $4, %esp

    movl    $0, -4(%ebp)
    jmp     LABEL_FOR1_CONDITION

LABEL_FOR1:
    call    fun1

    addl    $1, -4(%ebp)


LABEL_FOR1_CONDITION:
    movl    -4(%ebp), %eax
    cmpl    $3, %eax
    jl      LABEL_FOR1

#calling fun2
    pushl   $msg_main_call_fun2
    call    printf
    addl    $4, %esp

    movl    $0, -4(%ebp)
    jmp     LABEL_FOR2_CONDITION

LABEL_FOR2:
    call    fun2
    addl    $1, -4(%ebp)

LABEL_FOR2_CONDITION:
    movl    -4(%ebp), %eax
    cmpl    $3, %eax
    jl      LABEL_FOR2

    pushl   $0
    call    exit

# fun1() function execution code
.globl  fun1
.type   fun1, @function
fun1:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $4, %esp
    movl    $10, -4(%ebp)
    addl    $1, -4(%ebp)

    movl    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_fun1
    call    printf
    addl    $8, %esp

    movl    %ebp, %esp
    popl    %ebp

    ret

# fun2() function execution code
.globl  fun2
.type   fun2, @function
fun2:
    pushl   %ebp
    movl    %esp, %ebp

    addl    $1, iNo
    pushl   iNo
    pushl   $msg_fun2
    call    printf
    addl    $8, %esp

    popl    %ebp
    ret 


/* ==================== TEXT SECTION ENDS HERE ===================== */

