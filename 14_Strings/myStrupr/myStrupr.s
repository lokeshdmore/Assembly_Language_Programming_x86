/* =================================================================
 *	Code   : myStrupr
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 30th Sept 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_enter_string : 
	.string "Enter your string : "

	msg_main_print_replaced_string : 
	.string "your Updated string : %s\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl main
.type main,@function
main:
    andl    $(-16), %esp
	pushl   %ebp
	movl    %esp, %ebp

    subl    $272, %esp                          # local variables with parameters and align to 16

    movl    $msg_main_enter_string, (%esp)      # printf("Enter your string : ");
    call    printf

    leal    -256(%ebp), %ebx                      # gets(str);
    movl    %ebx, (%esp)
    call    gets    


    # char* str = myStrupr(str1);
    leal    -256(%ebp), %eax                        # %eax = str
    movl    %eax, (%esp)
    call    myStrupr
    movl    %eax, -260(%ebp)                         # char* str = myStrupr(str1);


    # printf("your updated string is \"%s\"\n", str);
    leal    -256(%ebp), %ebx
    movl    $msg_main_print_replaced_string, (%esp)
    movl    %ebx, 4(%esp)
    call    printf 

	movl $0, (%esp)
	call exit

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRSET FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

.globl  myStrupr
.type   myStrupr, @function
myStrupr:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp               # variable + align with 16

    movl    $0, -4(%ebp)            # int iCounter = 0;
 
    # int length = myStrlen(str);
    movl    8(%ebp), %eax                  # %eax = str
    movl    %eax, (%esp)
    call    myStrlen
    movl    %eax, %ecx                      # int length = myStrlen(str);

    movl    8(%ebp), %edi
    jmp     LABEL_WHILE_CONDITION

LABEL_WHILE:
    subl    $1, %ecx
    movb    (%edi), %dl
    cmpb    $97, %dl
    jl      LABEL_COUNTER
    cmpb    $122, %dl
    jg      LABEL_COUNTER
    subb    $32, %dl
    movb    %dl, (%edi)
 
LABEL_COUNTER:
    addl    $1, %edi   

LABEL_WHILE_CONDITION:
    cmpl    $0, %ecx
    jne     LABEL_WHILE
    

    movl    8(%ebp), %eax

    movl    %ebp, %esp
    popl    %ebp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRSET FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ==================== TEXT SECTION ENDS HERE ===================== */