/* =================================================================
 *	Code   : 3D Array Dynamic
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd Sept 2026
 * ================================================================= */

.equ    NULL, 0     
/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print_values:
    .string "[%d][%d][%d] value is:\t%d\n"

msg_main_enter_rows_columns:
    .string "Enter value of planes, rows & columns:\t"

msg_main_scan_row_column:
    .string "%d%d%d"

msg_main_enter_values:
    .string "Enter [%d][%d][%d] value:\t"

msg_main_entered_elements:
    .string "Entered elements are:\n"

msg_main_scan_value:
    .string "%d"

msg_main_print_mem_failed:
    .string "Memory allocation FAILED"

msg_main_print_addr:
    .string "addr of element : %hd\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $28, %esp

    pushl   $msg_main_enter_rows_columns
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %eax
    leal    -8(%ebp), %edx
    leal    -12(%ebp), %ecx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_scan_row_column
    call    scanf
    addl    $16, %esp

/* ------- memory allocation for iPlanes starts here ------ */

    # pppPtr = (int ***) malloc(iPlanes * sizeof(int **));
    movl    -4(%ebp), %eax      # eax = iPlanes
    movl    $4, %ecx            # ecx = sizeof(int**)
    mull    %ecx 
    pushl   %eax
    call    malloc
    addl    $4, %esp 
    cmpl    $0, %eax
    je      LABEL_MALLOC_FAILED # if(NULL == ppptr)
    movl    %eax, -28(%ebp)

/* ------- memory allocation for iPlanes ends here ------ */

    
/* ======== scanning the values for the array starts here ======= */

/* = +-+-+-+- = FOR 1 Starts here = +-+-+-+- = */
    movl    $0, -16(%ebp)
    jmp     LABEL_SCAN_FOR1_CONDITION


LABEL_SCAN_FOR1:
    # pppPtr[iCounter1] = (int **) malloc(iRows * sizeof(int *));
    movl    -8(%ebp), %eax      # eax = iRows
    movl    $4, %ecx            # ecx = sizeof(int*)
    mull    %ecx
    pushl   %eax
    call    malloc
    addl    $4, %esp
    cmpl    $0, %eax
    je      LABEL_MALLOC_FAILED # if(malloc failed)
    movl    %eax, %edx          # backup of eax 

    movl    -28(%ebp), %ebx     # ppptr
    movl    -16(%ebp), %eax     # iCounter1
    leal    (%ebx, %eax, 4), %ebx
    movl     %edx, (%ebx)

/* --------- FOR 2 starts here -------- */
    movl    $0, -20(%ebp)
    jmp     LABEL_SCAN_FOR2_CONDITION

LABEL_SCAN_FOR2:
    # pppPtr[iCounter1][iCounter2] = (int *) malloc(iColumns * sizeof(int));
    movl    -12(%ebp), %eax      # eax = iColumns
    movl    $4, %ecx             # ecx = sizeof(int)
    mull    %ecx
    pushl   %eax
    call    malloc
    addl    $4, %esp
    cmpl    $0, %eax
    je      LABEL_MALLOC_FAILED # if(malloc failed)
    movl    %eax, %edx          # backup of eax 

    # pppPtr[iCounter1][iCounter2] => *(*(ppptr + iCounter1 * sizeof(int*)) + iCounter2 * sizeof(int))
    movl    -28(%ebp), %ebx     # base_addr
    movl    -16(%ebp), %eax     # iCounter1
    movl    (%ebx, %eax, 4), %ebx
    movl    -20(%ebp), %eax     # eax = iCounter2
    leal    (%ebx, %eax, 4), %ebx 
    movl    %edx, (%ebx)

/* +++++++++ FOR 3 starts here ++++++++ */
    movl    $0, -24(%ebp)
    jmp     LABEL_SCAN_FOR3_CONDITION

LABEL_SCAN_FOR3:
    # printf("Enter [%d][%d][%d] value:\t", iCounter1, iCounter2, iCounter3);
    movl    -16(%ebp), %eax
    movl    -20(%ebp), %edx
    movl    -24(%ebp), %ecx
    pushl   %ecx
    pushl   %edx
    pushl   %eax 
    pushl   $msg_main_enter_values
    call    printf
    addl    $16, %esp

    # scanf("%d", &pppPtr[iCounter1][iCounter2][iCounter3]);
    # *(*(*(pppPtr + iCounter1 * sizeof(int**)) + iCounter2 * sizeof(int*)) + iCounter3 * sizeof(int))
    movl    -16(%ebp), %eax     # eax = iCounter1
    movl    -28(%ebp), %ebx     # ebx = base_addr
    movl    (%ebx, %eax, 4), %ebx

    movl    -20(%ebp), %eax     # eax = iCounter2
    movl    (%ebx, %eax, 4), %ebx 
    
    movl    -24(%ebp), %eax     # eax = iCounter3
    leal    (%ebx, %eax, 4), %ebx 

    pushl   %ebx
    pushl   $msg_main_scan_value
    call    scanf  
    addl    $8, %esp    

    addl   $1, -24(%ebp)

LABEL_SCAN_FOR3_CONDITION:
    movl    -24(%ebp), %eax
    movl    -12(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_SCAN_FOR3

/* +++++++++ FOR 3 ends here ++++++++ */

    addl    $1, -20(%ebp)  

LABEL_SCAN_FOR2_CONDITION:
    movl    -20(%ebp), %eax
    movl    -8(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_SCAN_FOR2

/* --------- FOR 2 ends here -------- */

    addl    $1, -16(%ebp)

LABEL_SCAN_FOR1_CONDITION:
    movl    -16(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_SCAN_FOR1

/* = +-+-+-+- = FOR 1 ends here = +-+-+-+- = */


/* ========= scanning the values for the array ends here ======== */


    pushl   $msg_main_entered_elements
    call    printf
    addl    $4, %esp


/* ======== printing the values for the array starts here ======= */

/* = +-+-+-+- = FOR 1 Starts here = +-+-+-+- = */
    movl    $0, -16(%ebp)
    jmp     LABEL_PRINT_FOR1_CONDITION


LABEL_PRINT_FOR1:
/* --------- FOR 2 starts here -------- */
    movl    $0, -20(%ebp)
    jmp     LABEL_PRINT_FOR2_CONDITION

LABEL_PRINT_FOR2:
/* +++++++++ FOR 3 starts here ++++++++ */
    movl    $0, -24(%ebp)
    jmp     LABEL_PRINT_FOR3_CONDITION

LABEL_PRINT_FOR3:

    # printf("[%d][%d][%d] value is:\t%d\n",iCounter1, iCounter2, iCounter3,pppPtr[iCounter1][iCounter2][iCounter3]);
    # *(*(*(pppPtr + iCounter1 * sizeof(int**)) + iCounter2 * sizeof(int*)) + iCounter3 * sizeof(int))
    movl    -16(%ebp), %eax     # eax = iCounter1
    movl    -28(%ebp), %ebx     # ebx = base_addr
    movl    (%ebx, %eax, 4), %ebx

    movl    -20(%ebp), %eax     # eax = iCounter2
    movl    (%ebx, %eax, 4), %ebx 
    
    movl    -24(%ebp), %eax     # eax = iCounter3
    leal    (%ebx, %eax, 4), %ebx 
    movl    -16(%ebp), %eax
    movl    -20(%ebp), %edx
    movl    -24(%ebp), %ecx
    pushl   (%ebx)
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_values
    call    printf
    addl    $20, %esp    


    addl   $1, -24(%ebp)

LABEL_PRINT_FOR3_CONDITION:
    movl    -24(%ebp), %eax
    movl    -12(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_PRINT_FOR3

/* +++++++++ FOR 3 ends here ++++++++ */

    addl    $1, -20(%ebp)  

LABEL_PRINT_FOR2_CONDITION:
    movl    -20(%ebp), %eax
    movl    -8(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_PRINT_FOR2

/* --------- FOR 2 ends here -------- */

    addl    $1, -16(%ebp)

LABEL_PRINT_FOR1_CONDITION:
    movl    -16(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_PRINT_FOR1

/* = +-+-+-+- = FOR 1 ends here = +-+-+-+- = */


/* ========= printing the values for the array ends here ======== */

/* ========= memory free starts here ========= */


/* = +-+-+-+- = FOR 1 Starts here = +-+-+-+- = */
    movl    $0, -16(%ebp)
    jmp     LABEL_MEM_FREE_FOR1_CONDITION


LABEL_MEM_FREE_FOR1:
/* --------- FOR 2 starts here -------- */
    movl    $0, -20(%ebp)
    jmp     LABEL_MEM_FREE_FOR2_CONDITION

LABEL_MEM_FREE_FOR2:
    movl    -28(%ebp), %ebx         # pppPtr
    movl    -16(%ebp), %eax         # eax = iCounter1
    movl    (%ebx, %eax, 4), %ebx   # pppPtr[iCounter1]
    movl    -20(%ebp), %eax         # eax = iCounter2
    leal    (%ebx, %eax, 4), %ebx   # pppPtr[iCounter1][iCounter2]
    pushl   (%ebx)
    call    free
    addl    $4, %esp 

    # pppPtr[iCounter1][iCounter2] = NULL
    movl    -28(%ebp), %ebx         # pppPtr
    movl    -16(%ebp), %eax         # eax = iCounter1
    movl    (%ebx, %eax, 4), %ebx   # pppPtr[iCounter1]
    movl    -20(%ebp), %eax         # eax = iCounter2
    leal    (%ebx, %eax, 4), %ebx   # pppPtr[iCounter1][iCounter2]
    movl    $NULL, (%ebx)           # pppPtr[iCounter1][iCounter2] = NULL

    addl    $1, -20(%ebp)  

LABEL_MEM_FREE_FOR2_CONDITION:
    movl    -20(%ebp), %eax
    movl    -8(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_MEM_FREE_FOR2

/* --------- FOR 2 ends here -------- */

    movl    -28(%ebp), %ebx         # pppPtr
    movl    -16(%ebp), %eax         # eax = iCounter1
    leal    (%ebx, %eax, 4), %ebx   # pppPtr[iCounter1]
    pushl   (%ebx)
    call    free
    addl    $4, %esp 

    movl    -28(%ebp), %ebx         # pppPtr
    movl    -16(%ebp), %eax         # eax = iCounter1
    leal    (%ebx, %eax, 4), %ebx   # pppPtr[iCounter1]
    movl    $NULL, (%ebx)

    addl    $1, -16(%ebp)

LABEL_MEM_FREE_FOR1_CONDITION:
    movl    -16(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_MEM_FREE_FOR1

/* = +-+-+-+- = FOR 1 ends here = +-+-+-+- = */

    movl    -28(%ebp), %eax
    pushl   %eax
    call    free
    addl    $4, %esp 

/* ========= memory free ends here ========= */


    pushl   $0
    call    exit
    

LABEL_MALLOC_FAILED:
    pushl   $msg_main_print_mem_failed
    call    puts
    pushl   $(-1)
    call    exit
/* ==================== TEXT SECTION ENDS HERE ===================== */

