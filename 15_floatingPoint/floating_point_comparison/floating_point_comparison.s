/* =================================================================
 *	Code   : Floating Point Comparison
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 14th Oct 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_enter_floating_no:
    .string "Enter two floating point numbers :\t"

msg_main_scan_no:
    .string "%f%f"

msg_main_print_fno1_lesser:
    .string "fNo1 is less than fNo2\n"

msg_main_print_fNo1_greater:
    .string "fNo1 is greater than fNo2\n"

msg_main_print_values_equal:
    .string "Values are equal\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=        */               
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  main
.type   main, @function
main:
    andl    $(-16), %esp
    pushl   %ebp
    movl    %esp, %ebp

    subl    $32, %esp

    # printf("Enter two floating point numbers:\\t");
    movl    $msg_main_enter_floating_no, (%esp)
    call    printf

    # scanf("%f%f", &fNo1, &fNo2);
    leal    -8(%ebp), %edx
    leal    -12(%ebp), %ecx
    movl    $msg_main_scan_no, (%esp)
    movl    %edx, 4(%esp)
    movl    %ecx, 8(%esp)
    call    scanf

    movl    -8(%ebp), %eax
    movl    -12(%ebp), %edx
    movl    %eax, (%esp)
    movl    %edx, 4(%esp)
    call    compare
    movl    %eax, -4(%ebp)

    cmpl    $(-1), %eax
    jne     LABEL_ELSE_IF
    movl    $msg_main_print_fno1_lesser, (%esp)
    call    puts 
    jmp     LABEL_EXIT

LABEL_ELSE_IF:
    cmpl    $1, %eax
    jne     LABEL_ELSE
    movl    $msg_main_print_fNo1_greater, (%esp)
    call    puts 
    jmp     LABEL_EXIT


LABEL_ELSE:
    movl    $msg_main_print_values_equal, (%esp)
    call    puts 

LABEL_EXIT:
    movl    $0, (%esp)
    call    exit

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o COMPARE FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

.globl  compare
.type   compare, @function
compare:
    pushl   %ebp
    movl    %esp, %ebp

    flds    12(%ebp)                      # fNo2 = st1
    flds    8(%ebp)                       # fNo1 = st0
    fcompp
    fstsw                                 # (fstsw - status write) : store/retrieve floating point status register from fpu to ax  
    sahf                                  # store AH to flags register (ax regr mdhun fkt compare cha regr flag mdhye store krto )
    jae     LABEL_GREATER_EQUAL
    movl    $(-1), %eax
    jmp     COMPARE_EXIT

LABEL_GREATER_EQUAL:
    jz     LABEL_EQUAL
    movl    $(1), %eax
    jmp     COMPARE_EXIT

LABEL_EQUAL:
    movl    $(0), %eax

COMPARE_EXIT:
    popl    %ebp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o COMPARE FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ==================== TEXT SECTION ENDS HERE ===================== */

