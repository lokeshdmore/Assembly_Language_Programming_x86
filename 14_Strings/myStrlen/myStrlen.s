/* =================================================================
 *	Code   : myStrlen
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 30th Sept 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_enter_string : 
	.string "Enter your string : "

	msg_main_print_length : 
	.string "your string : %s has length of %d bytes\n"

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

    subl    $48, (%esp)                         # local variables with parameters and align to 16

    movl    $msg_main_enter_string, (%esp)      # printf("Enter your string : ");
    call    printf

    leal    -30(%ebp), %ebx                      # gets(str);
    movl    %ebx, (%esp)
    call    gets    

    # int length = myStrlen(str);
    movl    -30(%ebp), %eax                      # %eax = str
    movl    %eax, (%esp)
    call    myStrlen
    movl    %eax, -34(%ebp)                     # int length = myStrlen(str);

    # printf("your string : %s has length of %d bytes\n", str, length);
    movl    -30(%ebp), %ebx
    movl    $msg_main_print_length, (%esp)
    movl    %ebx, 4(%esp)
    movl    %eax, 8(%esp)
    call    printf 

	movl $0, (%esp)
	call exit

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRLEN FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

.globl  myStrlen
.type   myStrlen, @function
myStrlen:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, (%esp)             # variable + align with 16

    movl    $0, -4(%ebp)            # int length = 0;

    movl    $0, %eax
    movl    8(%ebp), %esi           # %ebx = str 
    movsb   
    jmp     LABEL_WHILE_CONDITION

LABEL_WHILE:
    inc     %eax                    # increment the counter 
    
LABEL_WHILE_CONDITION:
    cmpl    $0,%edi
    jne     LABEL_WHILE

    movl    %eax, -4(%ebp)

    movl    %ebp, %esp
    popl    %ebp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRLEN FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ==================== TEXT SECTION ENDS HERE ===================== */