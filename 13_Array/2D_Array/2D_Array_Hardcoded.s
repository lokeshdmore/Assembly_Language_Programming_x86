/* =================================================================
 *	Code   : 
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print:
    .string "%d\n"

msg_main_print_index:
    .string "Enter arr[%d] [%d] value : \t"
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

    subl    $48, %esp

    leal    -48(%ebp), %ebx
    pushl   %ebx
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    movl    $4, %eax
    movl    $4, %ecx
    mull    %ecx        # eax = 16
    movl    %eax, %ecx
    movl    $2, %eax
    mull    %ecx        # eax = 16 * 2 => 32
    leal    -48(%ebp), %ebx
    addl    %eax, %ebx  # base_addr + 32 

    movl    $3, %eax        
    leal    (%ebx, %eax, 4), %ebx   #(base_addr , index , size)
    pushl   %ebx
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp
    
    pushl   $3
    pushl   $2
    pushl   $msg_main_print_index
    call    printf
    addl    $12, %esp

    # &arr[2][3]
    movl    $4, %eax
    movl    $4, %ecx
    mull    %ecx        # eax = 16
    movl    %eax, %ecx
    movl    $2, %eax
    mull    %ecx        # eax = 16 * 2 => 32
    leal    -48(%ebp), %ebx
    addl    %eax, %ebx  # base_addr + 32 
    movl    $3, %eax        
    leal    (%ebx, %eax, 4), %ebx   #(base_addr , index , size)
    pushl   %ebx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    # arr[2][3]
    movl    $4, %eax
    movl    $4, %ecx
    mull    %ecx        # eax = 16
    movl    %eax, %ecx
    movl    $2, %eax
    mull    %ecx        # eax = 16 * 2 => 32
    leal    -48(%ebp), %ebx
    addl    %eax, %ebx  # base_addr + 32 
    movl    $3, %eax        
    leal    (%ebx, %eax, 4), %ebx   #(base_addr , index , size)
    pushl   (%ebx)
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp



    pushl   $0
    call    exit 


/* ==================== TEXT SECTION ENDS HERE ===================== */
