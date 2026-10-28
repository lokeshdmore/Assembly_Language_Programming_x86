/* =================================================================
 *	Code   : 1_FloatingPointValue
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 8th Oct 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print_fNo:
    .string "fNo1 = %f\t fNo2 = %f\n"

    msg_main_print_dNo:
    .string "dNo1 = %lf\t dNo2 = %lf\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

# float fNo1 = 57.33f;
.globl  fNo1
.type   fNo1, object
.size   fNo1, 4
.align  4
fNo1:
    .float  57.33                                       # float fNo1 = 57.33f;

# double dNo1 = 58963.546f;
.globl  dNo1
.type   dNo1, @object
.size   dNo1, 8
.align  8
dNo1:
    .double  58963.546                                  # double dNo1 = 58963.546f;

/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== BSS SECTION ========================== */
.section .bss
    .comm   fNo2, 4, 4                                  # float fNo2;
    .comm   dNo2, 8, 4                                  # float dNo2;

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text
.globl  main
.type   main, @function
main:
    andl    $(-16), %esp
    pushl   %ebp
    movl    %esp, %ebp
    
    subl    $32, %esp 

    # attempt 1 for printf fNo1 (x Failure x)
    #movl    fNo1, %eax
    #movl    fNo2, %edx
    #movl    $msg_main_print_fNo, (%esp)
    #movl    %eax, 4(%esp)
    #movl    %edx, 8(%esp)
    #call    printf 

    # attempt 2 (x Failure x) -> while, push to stack 8 bytes should be there, but we are using 4 bytes  
    #flds    fNo2                                       # load dNo2 from ram to fpu (st0)
    #flds    fNo1                                       # load dNo1 from ram to fpu (st0, prev st0->st1)
    #movl    $msg_main_print_dNo, (%esp)
    #fstps   4(%esp)                                    # store and pop st0 (i.e. dNo1) to 4(%esp)
    #fstps   8(%esp)                                    # store and pop st0 (i.e. dNo2) to 12(%esp)
    #call    printf

    # attempt 3 (succeded) -> here while push 8 bytes pushing should be there
    flds    fNo2                                        # load dNo2 from ram to fpu (st0)
    flds    fNo1                                        # load dNo1 from ram to fpu (st0, prev st0->st1)
    movl    $msg_main_print_dNo, (%esp)
    fstpl   4(%esp)                                     # store and pop st0 (i.e. dNo1) to 4(%esp)
    fstpl   12(%esp)                                    # store and pop st0 (i.e. dNo2) to 12(%esp)
    call    printf                              

    # attempt 1 (succeded ) -> without fpu stack registers
    #movl    $msg_main_print_dNo, (%esp)
    #movl    dNo1, %eax
    #movl    dNo1+4, %edx
    #movl    dNo2, %ecx
    #movl    dNo2+4, %ebx
    #movl    %eax, 4(%esp)
    #movl    %edx, 8(%esp)
    #movl    %ecx, 12(%esp)
    #movl    %ebx, 16(%esp)
    #call    printf

    # attempt 2 (succeded) -> with fpu stack registers
    fldl    dNo2                                        # load dNo2 from ram to fpu (st0)
    fldl    dNo1                                        # load dNo1 from ram to fpu (st0, prev st0->st1)
    movl    $msg_main_print_dNo, (%esp)
    fstpl   4(%esp)                                     # store and pop st0 (i.e. dNo1) to 4(%esp)
    fstpl   12(%esp)                                    # store and pop st0 (i.e. dNo2) to 12(%esp)
    call    printf

    # fNo2 = fNo2
    flds    fNo1
    fstps   fNo2
    fldl    dNo1
    fstpl   dNo2

    flds    fNo2                                        # load dNo2 from ram to fpu (st0)
    flds    fNo1                                        # load dNo1 from ram to fpu (st0, prev st0->st1)
    movl    $msg_main_print_dNo, (%esp)
    fstpl   4(%esp)                                     # store and pop st0 (i.e. dNo1) to 4(%esp)
    fstpl   12(%esp)                                    # store and pop st0 (i.e. dNo2) to 12(%esp)
    call    printf                              

    fldl    dNo2                                        # load dNo2 from ram to fpu (st0)
    fldl    dNo1                                        # load dNo1 from ram to fpu (st0, prev st0->st1)
    movl    $msg_main_print_dNo, (%esp)
    fstpl   4(%esp)                                     # store and pop st0 (i.e. dNo1) to 4(%esp)
    fstpl   12(%esp)                                    # store and pop st0 (i.e. dNo2) to 12(%esp)
    call    printf

    movl    $0, (%esp)
    call    exit 

/* ==================== TEXT SECTION ENDS HERE ===================== */

