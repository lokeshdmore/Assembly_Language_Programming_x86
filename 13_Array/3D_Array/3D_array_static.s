/* =================================================================
 *	Code   : 3D Array Static
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 1st Sept 2026
 * ================================================================= */

.equ    MAX, 10     # alternative to '#define MAX 10'

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print_values:
    .string "[%d][%d][%d] value is:\t%d\n"

msg_main_enter_rows_columns:
    .string "Enter value of planes, rows & columns(< %d):\t"

msg_main_scan_row_column:
    .string "%d%d%d"

msg_main_enter_values:
    .string "Enter [%d][%d][%d] value:\t"

msg_main_entered_elements:
    .string "Entered elements are:\n"

msg_main_scan_value:
    .string "%d"

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

    subl    $4024, %esp

    pushl   $MAX
    pushl   $msg_main_enter_rows_columns
    call    printf
    addl    $8, %esp

    leal    -4(%ebp), %eax
    leal    -8(%ebp), %edx
    leal    -12(%ebp), %ecx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_scan_row_column
    call    scanf
    addl    $16, %esp

/* ======== scanning the values for the array starts here ======= */

/* = +-+-+-+- = FOR 1 Starts here = +-+-+-+- = */
    movl    $0, -16(%ebp)
    jmp     LABEL_SCAN_FOR1_CONDITION


LABEL_SCAN_FOR1:
/* --------- FOR 2 starts here -------- */
    movl    $0, -20(%ebp)
    jmp     LABEL_SCAN_FOR2_CONDITION

LABEL_SCAN_FOR2:
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

    # scanf("%d", &arr[iCounter1][iCounter2][iCounter3]);
    # *(*(*(arr + iCounter1 * no_of_rows * no_of_coln * sizeof(each_element)) + iCounter2 * no_of_coln * sizeof(int)) + iCounter3 * sizeof(int))
    movl    -8(%ebp), %eax      # %eax = iRows
    movl    -12(%ebp), %ecx     # %ecx = iColumns
    mull    %ecx                # %eax = iRows * iColumns
    
    movl    $4, %ecx            # ecx = 4 (size_of_each_element)
    mull    %ecx                # eax = iRows * iColumns * sizeof(int)
    
    movl    -16(%ebp), %ecx     # %ecx = iCounter1
    mull    %ecx                # size = iCounter1 * rows * columns 
    leal    -4024(%ebp), %ebx   # base addr of an array 
    addl    %eax, %ebx          # arr[iCounter1] i.e *(arr + iCounter1 * size)

    movl    -12(%ebp), %eax     # %eax = iColumns
    movl    $4, %ecx            # %ecx = size_of_element i.e. 4
    mull    %ecx                # size = iColumns * size_of_int
    movl    -20(%ebp), %ecx     # %ecx = iCounter2
    mull    %ecx                # iCounter2 * size (index * size)
    addl    %eax, %ebx          # (base_addr + index * size)

    movl    -24(%ebp), %eax     # %eax = iCounter3
    leal    (%ebx, %eax, 4), %ebx  #(base_addr + index * size)
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

    # printf("[%d][%d][%d] value is:\t%d\n",iCounter1, iCounter2, iCounter3,arr[iCounter1][iCounter2][iCounter3]);
    # *(*(*(arr + iCounter1 * no_of_rows * no_of_coln) + iCounter2 * no_of_coln * sizeof(int)) + iCounter3 * sizeof(int))
    movl    -8(%ebp), %eax      # %eax = iRows
    movl    -12(%ebp), %ecx     # %edx = iColumns
    mull    %ecx                # %eax = iRows * iColumns
    
    movl    $4, %ecx            # ecx = 4 (size_of_each_element)
    mull    %ecx                # eax = iRows * iColumns * sizeof(int)

    movl    -16(%ebp), %ecx     # %ecx = iCounter1
    mull    %ecx                # size = iCounter1 * rows * columns
    leal    -4024(%ebp), %ebx   # base addr of an array 
    addl    %eax, %ebx          # arr[iCounter1] i.e *(arr + iCounter1 * size)

    movl    -12(%ebp), %eax     # %eax = iColumns
    movl    $4, %ecx            # %ecx = size_of_element i.e. 4
    mull    %ecx                # size = iColumns * size_of_int
    movl    -20(%ebp), %ecx     # %ecx = iCounter2
    mull    %ecx                # iCounter2 * size (index * size)
    addl    %eax, %ebx          # (base_addr + index * size)

    movl    -24(%ebp), %eax     # %eax = iCounter3
    movl    (%ebx, %eax, 4), %ebx  #(base_addr + index * size)
    movl    -16(%ebp), %eax
    movl    -20(%ebp), %edx
    movl    -24(%ebp), %ecx
    pushl   %ebx
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

    pushl   $0
    call    exit
    
/* ==================== TEXT SECTION ENDS HERE ===================== */

