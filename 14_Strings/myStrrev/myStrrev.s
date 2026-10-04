/* =================================================================
 *	Code   : myStrrev
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 30th Sept 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_enter_string : 
	.string "Enter your string : "

	msg_main_print_updated_string : 
	.string "your Updated string : \"%s\"\n"

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

    subl    $272, %esp                                  # local variables with parameters and align to 16

    movl    $msg_main_enter_string, (%esp)              # printf("Enter your string : ");
    call    printf

    leal    -256(%ebp), %ebx                            # gets(str);
    movl    %ebx, (%esp)
    call    gets    

    # char* str = myStrrev(str1);
    leal    -256(%ebp), %eax                            # %eax = str
    movl    %eax, (%esp)
    call    myStrrev
    movl    %eax, -260(%ebp)                            # char* str = myStrrev(str1);


    # printf("your updated string is \"%s\"\n", str);
    leal    -256(%ebp), %ebx
    movl    $msg_main_print_updated_string, (%esp)
    movl    %ebx, 4(%esp)
    call    printf 

	movl    $0, (%esp)
	call    exit

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRREV FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

.globl  myStrrev
.type   myStrrev, @function
myStrrev:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp                       # variable + align with 16

    movl    $0, -4(%ebp)                    # int iCounter = 0;
 
    # int length = myStrlen(str);
    movl    8(%ebp), %eax                   # %eax = str
    movl    %eax, (%esp)
    call    myStrlen
    movl    %eax, %ecx                      # int length = myStrlen(str);

    movl    8(%ebp), %edi
    leal    (%edi, %ecx, 1), %edi
    subl    $1, %edi 
    movl    8(%ebp), %esi                   # 
    movl    $0, %eax                        # set the initial counter i.e. i = 0
    jmp     LABEL_WHILE_CONDITION

LABEL_WHILE:
    subl    $1, %ecx
    addl    $1, %eax 
    movb   (%edi), %dl
    movb    (%esi), %bl
    movb    %bl, (%edi)
    movb    %dl, (%esi)
    subl    $1, %edi
    addl    $1, %esi 


LABEL_WHILE_CONDITION:
    cmpl    %eax, %ecx
    jg     LABEL_WHILE

    movl    8(%ebp), %eax

    movl    %ebp, %esp
    popl    %ebp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRREV FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ==================== TEXT SECTION ENDS HERE ===================== */