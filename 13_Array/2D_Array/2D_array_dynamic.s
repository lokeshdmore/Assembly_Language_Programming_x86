/* =================================================================
 *	Code   : 2D Array Dynamic
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 27th Aug 2026
 * ================================================================= */

.equ    NULL, 0

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print_values:
    .string "[%d][%d] value is:\t%d\n"

msg_main_enter_rows_columns:
    .string "Enter value of rows & columns:\t"

msg_main_scan_row_column:
    .string "%d%d"

msg_main_enter_values:
    .string "Enter [%d][%d] value : \t"

msg_main_entered_elements:
    .string "Entered elements are:\n"

msg_main_scan_value:
    .string "%d"

msg_main_print_mem_failed:
    .string "Memory allocation FAILED"


/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $20, %esp      # definition of iRows, iColumns, iCounter1, iCounter2, **pptr

    movl    $0, -20(%ebp)

    pushl   $msg_main_enter_rows_columns
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %ebx
    leal    -8(%ebp), %ecx
    pushl   %ecx
    pushl   %ebx
    pushl   $msg_main_scan_row_column
    call    scanf
    addl    $12, %esp

    /* --------- allocating the memory for pptr starts here ----------- */
    movl    -4(%ebp), %eax      # eax = iRows
    movl    $4, %ecx            # ecx = 4 (size of(int*))
    mull    %ecx    
    pushl   %edx
    pushl   %eax
    call    malloc
    addl    $8, %esp
    movl    %eax, -20(%ebp)
    cmpl    $0, %eax
    je      LABEL_MALLOC_FAILED

    /* ----------- allocating the memory for pptr ends here ----------- */

/* --------------------- allocating memory for pptr[iCounter1] and scan the values ---------------- */

/* ++++++++++++++++++++++ outside for loop starts here +++++++++++++++++++++++ */

    movl    $0, -12(%ebp)
    jmp     LABEL_SCAN_FOR1_CONDITION

LABEL_SCAN_FOR1:
    /* ----- allocate the memory for pptr[iCounter1] starts here ------- */
    movl    -8(%ebp), %eax      # eax = iColumns
    movl    $4, %ecx            # ecx = 4 (size of(int))
    mull    %ecx    
    pushl   %edx
    pushl   %eax
    call    malloc              # malloc(iColumns * sizeof(int));
    addl    $8, %esp
    movl    %eax, %ecx          # backup of eax 

    movl    -12(%ebp), %eax 
    movl    -20(%ebp), %ebx
    leal    (%ebx, %eax, 4), %ebx       # &pptr[iCounter1]
    movl    %ecx, (%ebx)
    cmpl    $0, %ebx
    je      LABEL_MALLOC_FAILED

    /* ----- allocate the memory for pptr[iCounter1] ends here ------- */

    /* ------ inside for loop starts here --------- */
    movl    $0, -16(%ebp)
    jmp     LABEL_SCAN_FOR2_CONDITION


LABEL_SCAN_FOR2:
    movl    -12(%ebp), %eax     # eax = iCounter1
    movl    -16(%ebp), %ecx     # ecx = iCounter2
    pushl   %ecx                # push iCounter2
    pushl   %eax                # push iCounter1
    pushl   $msg_main_enter_values
    call    printf
    addl    $12, %esp

    # &ppPtr[iCounter1][iCounter2]
    movl    -12(%ebp), %eax     # eax = iCounter1
    movl    -20(%ebp), %edx     # edx = pptr
    movl    (%edx, %eax, 4), %ebx      # *(pptr + iCounter1 * size)
    movl    -16(%ebp), %eax
    leal    (%ebx, %eax, 4), %ebx
    pushl   %ebx
    pushl   $msg_main_scan_value
    call    scanf
    addl    $8, %esp 

    addl    $1, -16(%ebp)

LABEL_SCAN_FOR2_CONDITION:
    movl    -16(%ebp), %eax     # eax = iCounter2
    movl    -8(%ebp), %edx      # edx = iColumns
    cmpl    %edx, %eax
    jl      LABEL_SCAN_FOR2

    /* ------ inside for loop ends here --------- */

    addl    $1, -12(%ebp)

LABEL_SCAN_FOR1_CONDITION:
    movl    -12(%ebp), %eax     # eax = iCounter1
    movl    -4(%ebp), %edx      # edx = iRows
    cmpl    %edx, %eax
    jl      LABEL_SCAN_FOR1


/* ++++++++++++++++++++++++ outside for loop ends here ++++++++++++++++++++++++ */


/* -------------- allocating memory for pptr[iCounter1] and scan the values ends here ------------- */


    pushl   $msg_main_entered_elements
    call    printf
    addl    $4, %esp 


/* ------------- printing the elements starts here ----------------- */
    movl    $0, -12(%ebp)
    jmp     LABEL_PRINT_FOR1_CONDITION

LABEL_PRINT_FOR1:
    movl    $0, -16(%ebp)
    jmp     LABEL_PRINT_FOR2_CONDITION

LABEL_PRINT_FOR2:
    # ppPtr[iCounter1][iCounter2]
    movl    -12(%ebp), %eax
    movl    -16(%ebp), %edx
    movl    -20(%ebp), %ecx
    movl    (%ecx, %eax, 4), %ebx     # (base_addr, index, sizeof(int*))
    movl    (%ebx, %edx, 4), %ecx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_values
    call    printf
    addl    $16, %esp

    
    addl    $1, -16(%ebp)

LABEL_PRINT_FOR2_CONDITION:
    movl    -16(%ebp), %eax
    movl    -8(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_PRINT_FOR2


    addl    $1, -12(%ebp)

LABEL_PRINT_FOR1_CONDITION:
    movl    -12(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_PRINT_FOR1

/* -------------- printing the elements ends here ------------------ */


/* --------------- allocated memory free stars here ----------------- */

    movl    $0, -12(%ebp)
    jmp     LABEL_MEM_FREE_FOR_CONDITION

LABEL_MEM_FREE_FOR:
    movl    -20(%ebp), %ebx     # edx = pptr
    leal    (%ebx, %eax, 4), %ebx
    pushl   (%ebx)
    call    free
    addl    $4, %esp 


    # pptr[iCounter1] = NULL
    movl    -20(%ebp), %ebx     # edx = pptr
    movl    -12(%ebp), %eax
    leal    (%ebx, %eax, 4), %ebx
    movl    $NULL, (%ebx)

    addl    $1, -12(%ebp)

LABEL_MEM_FREE_FOR_CONDITION:
    movl    -12(%ebp), %eax     # eax = iCounter1
    movl    -4(%ebp), %edx      # edx = iRows
    cmpl    %edx, %eax
    jl      LABEL_MEM_FREE_FOR

    # free(pptr)
    movl    -20(%ebp), %ebx
    pushl   %ebx
    call    free
    addl    $4, %esp

    movl    $NULL, -20(%ebp)

/* --------------- allocated memory free ends here ----------------- */
    pushl   $0
    call    exit


LABEL_MALLOC_FAILED:
    pushl   $msg_main_print_mem_failed
    call    puts
    pushl   $(-1)
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */

