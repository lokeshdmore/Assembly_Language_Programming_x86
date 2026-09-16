/* =================================================================
 *	Code   : 2D Array Hardcoded
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 27th Aug 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print:
    .string "%d\n"

msg_main_enter_values:
    .string "Enter arr[%d][%d] value : \t"

msg_main_scan:
    .string "%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $48, %esp    #int arr[3][4]

    leal    -48(%ebp), %ebx
    pushl   %ebx
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    # fetching the address of (&arr[2][3])
    movl    $4, %eax
    movl    $4, %ecx
    mull    %ecx        # no of elements in one row * size of single element 
    movl    $2, %ecx
    mull    %ecx        # row no * size
    leal    -48(%ebp), %ebx     #   fetch base address
    addl    %eax, %ebx  # base_addr + index 

    movl    $3, %eax    # copy index into index regr
    leal    (%ebx, %eax, 4), %ebx
    pushl   %ebx
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp 

    pushl   $3
    pushl   $2
    pushl   $msg_main_enter_values
    call    printf
    addl    $12, %esp 

    # fetching the address of (&arr[2][3]) and push to the stack
    movl    $4, %eax
    movl    $4, %ecx
    mull    %ecx        # no of elements in one row * size of single element 
    movl    $2, %ecx
    mull    %ecx        # row no * size
    leal    -48(%ebp), %ebx     #   fetch base address
    addl    %eax, %ebx  # base_addr + index 

    movl    $3, %eax    # copy index into index regr
    leal    (%ebx, %eax, 4), %ebx
    pushl   %ebx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    # fetching the address of (&arr[2][3]) and derefence it and print it 
    movl    $4, %eax
    movl    $4, %ecx
    mull    %ecx        # no of elements in one row * size of single element 
    movl    $2, %ecx
    mull    %ecx        # row no * size
    leal    -48(%ebp), %ebx     #   fetch base address
    addl    %eax, %ebx  # base_addr + index 

    movl    $3, %eax    # copy index into index regr
    leal    (%ebx, %eax, 4), %ebx
    pushl   (%ebx)
    pushl   $msg_main_print 
    call    printf 
    addl    $8, %esp


    pushl   $0
    call    exit
    
/* ==================== TEXT SECTION ENDS HERE ===================== */
