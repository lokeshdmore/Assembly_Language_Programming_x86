/* =================================================================
 *	Code   : myStrcpy
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 30th Sept 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_enter_first_string : 
	.string "Enter your first string : "

    msg_main_enter_second_string : 
	.string "Enter your second string : "

	msg_main_print_copied_string : 
	.string "your copied string is : \"%s\"\n"

    msg_string:
    .string "your string is : %s\n"

    msg_scan:
    .string "%s"

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

    subl    $400, %esp                              # local variables (char str1[256] + char str2[128] + arguments + align to 16)

    movl    $msg_main_enter_first_string, (%esp)          # printf("Enter your string : ");
    call    printf

    leal    -256(%ebp), %ebx                        # gets(str1);
    movl    %ebx, (%esp)
    call    gets    

    movl    $msg_main_enter_second_string, (%esp)          # printf("Enter your string : ");
    call    printf

    leal    -384(%ebp), %ebx                        # gets(str2);
    movl    %ebx, (%esp)
    call    gets    

    # char* str = myStrcpy(str1, str2);
    leal    -256(%ebp), %ebx
    leal    -384(%ebp), %ecx
    movl    %ebx, (%esp)
    movl    %ecx, 4(%esp)
    call    myStrcpy
    movl    %eax, -388(%ebp)                        # char *str = myStrcpy(str1, str2);

    movl    $msg_main_print_copied_string, (%esp)
    movl    %eax, 4(%esp)
    call    printf

	movl    $0, (%esp)
	call    exit

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRCPY FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

.globl  myStrcpy
.type   myStrcpy, @function
myStrcpy:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp               # variable + align with 16

    movl    $0, -4(%ebp)            # int iCounter1 = 0;
 
    movl    $0, %eax

    movl    8(%ebp), %edi
    movl    12(%ebp), %esi 
    movl    %edi, %ecx 
    jmp     LABEL_WHILE_CONDITION

LABEL_WHILE:
    movsb   

LABEL_WHILE_CONDITION:
    movl    (%esi), %edx 
    cmpl    $0,%edx 
    jne     LABEL_WHILE

    movl    $0, (%edi)

    movl    %ecx, 8(%ebp)
    movl    %ecx, %eax 

    movl    %ebp, %esp
    popl    %ebp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRCPY FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ==================== TEXT SECTION ENDS HERE ===================== */