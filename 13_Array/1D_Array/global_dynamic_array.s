/* =================================================================
 *	Code   : Global Dynamic Array
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 19th August 2026
 * ================================================================= */

.equ    NULL, 0

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_enter_value_n:
    .string "Enter the value of n:\t"

msg_main_puts:
    .string "Memory Allocation FAILED"

msg_main_enter_value_iCounter:
    .string "Enter %d value:\t"

msg_main_print_elements:
    .string "Entered Elements Are : \n"

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

    subl    $12, %esp    # define iMax , iCounter, int *ptr

    movl    $NULL, -12(%ebp)    # *iptr = NULL

    pushl   $msg_main_enter_value_n
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    # pPtr = (int *) malloc (iMax * sizeof(int));
    movl    $4, %eax
    movl    -4(%ebp), %ecx
    mull    %ecx
    pushl   %edx
    pushl   %eax
    call    malloc
    addl    $8, %esp
    movl    %eax, -12(%ebp)

    # if(NULL == pPtr)
    cmpl    %eax, NULL
    je      LABEL_MEM_FAILED


    /* ===== first for loop starts here ===== */
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR1_CONDITION

LABEL_FOR1:
    pushl   %eax
    pushl   $msg_main_enter_value_iCounter
    call    printf
    addl    $8, %esp

    movl    -8(%ebp), %eax 
    movl    -12(%ebp), %ebx
    leal    (%ebx, %eax, 4), %edx
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
    
    pushl   $msg_main_print_elements
    call    printf
    addl    $4, %esp

    /* === second for loop starts here === */
    movl    $0, -8(%ebp)
    jmp     LABEL_FOR2_CONDITION

LABEL_FOR2:
    movl    -12(%ebp), %edx 
    movl    (%edx,%eax,4), %ecx
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

    /* === second for loop ends  here === */

    movl    -12(%ebp), %eax
    pushl   %eax
    call    free
    addl    $4, %esp
    movl    $NULL, -12(%ebp)

    /* ===== printing of first arr ends here ===== */

    pushl   $0
    call    exit

LABEL_MEM_FAILED:
    pushl   $msg_main_puts
    call    puts
    addl    $4, %esp

    pushl   $(-1)
    call    exit 
/* ==================== TEXT SECTION ENDS HERE ===================== */

