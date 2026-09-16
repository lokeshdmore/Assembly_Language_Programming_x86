/* =================================================================
 *	Code   : 2D Array Static
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 27th Aug 2026
 * ================================================================= */

.equ    MAX, 10     # alternative to '#define MAX 10'

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print_values:
    .string "[%d][%d] value is:\t%d\n"

msg_main_enter_rows_columns:
    .string "Enter value of rows & columns(< %d):\t"

msg_main_scan_row_column:
    .string "%d%d"

msg_main_enter_values:
    .string "Enter arr[%d][%d] value : \t"

msg_main_entered_elements:
    .string "Entered elements are:\n"

msg_main_scan_value:
    .string "%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $416, %esp      # definition of iRows, iColumns, iCounter1, iCounter2, arr[MAX][MAX]

    pushl   $MAX
    pushl   $msg_main_enter_rows_columns
    call    printf
    addl    $8, %esp

    leal    -4(%ebp), %ebx
    leal    -8(%ebp), %ecx
    pushl   %ecx
    pushl   %ebx
    pushl   $msg_main_scan_row_column
    call    scanf
    addl    $12, %esp 

/* ----------------------------- scanning the values ------------------------------- */

    movl    $0, -12(%ebp)   # iCounter1 = 0
    jmp     LABEL_SCAN_FOR1_CONDITION

LABEL_SCAN_FOR1:

    /* +++++++++++++++++++++++ second for loop for columns +++++++++++++++++++++++++ */
        movl    $0, -16(%ebp)
        jmp     LABEL_SCAN_FOR2_CONDITION

    LABEL_SCAN_FOR2:
        
        # printf("Enter [%d][%d] value:\t", iCounter1, iCounter2);
        movl    -12(%ebp), %eax
        movl    -16(%ebp), %edx
        pushl   %edx
        pushl   %eax
        pushl   $msg_main_enter_values
        call    printf
        addl    $12, %esp 

        # scanf("%d", &arr[iCounter1][iCounter2]);
        movl    -8(%ebp), %eax      # eax = iColumns (no of elements in 1 row)
        movl    $4, %ecx            # ecx = 4 (size of each element in 1 row)
        mull    %ecx                # size = iColumns * 4
        movl    -12(%ebp), %ecx     # ecx = iCounter1
        mull    %ecx                # iCounter1 * size 
        leal    -416(%ebp), %ebx    # fetch the base address
        addl    %eax, %ebx          # base_addr + offset
        movl    -16(%ebp), %eax     # eax = iCounter2 (index)
        leal    (%ebx, %eax, 4), %ebx     # (base_addr, index, size)   
        pushl   %ebx
        pushl   $msg_main_scan_value
        call    scanf
        addl    $8, %esp 

        addl    $1, -16(%ebp)       # iCounter2++

    LABEL_SCAN_FOR2_CONDITION:
        movl    -16(%ebp), %eax     # eax = iCounter2
        movl    -8(%ebp), %edx      # edx = iColumns
        cmpl    %edx, %eax 
        jl      LABEL_SCAN_FOR2

    /* ++++++++++++++++ second for loop for columns ends here  +++++++++++++++++++++ */

    addl    $1, -12(%ebp)       # iCounter1++

LABEL_SCAN_FOR1_CONDITION:
    movl    -12(%ebp), %eax     # eax = iCounter1 
    movl    -4(%ebp), %edx      # edx = iRows
    cmpl    %edx, %eax
    jl      LABEL_SCAN_FOR1

/* ---------------------------- values scanning ends here -------------------------- */

    pushl   $msg_main_entered_elements
    call    printf
    addl    $4, %esp

/* ----------------------------- printing the values ------------------------------- */

    movl    $0, -12(%ebp)   # iCounter1 = 0
    jmp     LABEL_PRINT_FOR1_CONDITION

LABEL_PRINT_FOR1:

    /* +++++++++++++++++++++++ second for loop for columns +++++++++++++++++++++++++ */
        movl    $0, -16(%ebp)
        jmp     LABEL_PRINT_FOR2_CONDITION

    LABEL_PRINT_FOR2:
        
        # printf("[%d][%d] value is:\t%d\n", iCounter1, iCounter2, arr[iCounter1][iCounter2]);
        movl    -8(%ebp), %eax      # eax = iColumns (no of elements in 1 row)
        movl    $4, %ecx            # ecx = 4 (size of each element in 1 row)
        mull    %ecx                # size = iColumns * 4
        movl    -12(%ebp), %ecx     # ecx = iCounter1
        mull    %ecx                # iCounter1 * size 
        leal    -416(%ebp), %ebx    # fetch the base address
        addl    %eax, %ebx          # base_addr + offset
        movl    -16(%ebp), %eax     # eax = iCounter2 (index)
        movl    (%ebx, %eax, 4), %ebx     # (base_addr, index, size)   
        pushl   %ebx
        pushl   %eax
        pushl   %ecx
        pushl   $msg_main_print_values
        call    printf
        addl    $16, %esp 

        addl    $1, -16(%ebp)       # iCounter2++

    LABEL_PRINT_FOR2_CONDITION:
        movl    -16(%ebp), %eax     # eax = iCounter2
        movl    -8(%ebp), %edx      # edx = iColumns
        cmpl    %edx, %eax 
        jl      LABEL_PRINT_FOR2

    /* ++++++++++++++++ second for loop for columns ends here  +++++++++++++++++++++ */

    addl    $1, -12(%ebp)       # iCounter1++

LABEL_PRINT_FOR1_CONDITION:
    movl    -12(%ebp), %eax     # eax = iCounter1 
    movl    -4(%ebp), %edx      # edx = iRows
    cmpl    %edx, %eax
    jl      LABEL_PRINT_FOR1

/* ---------------------------- values printing ends here -------------------------- */    

    pushl   $0
    call    exit
    
/* ==================== TEXT SECTION ENDS HERE ===================== */

