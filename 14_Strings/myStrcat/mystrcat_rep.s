/* =================================================================
 *	Code   : myStrcat using while
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

	msg_main_print_concetenate_string : 
	.string "your concetenate string is : \"%s\"\n"

    msg_string:
    .string "your string is : %d\n"

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

    subl    $400, %esp                                      # local variables (char str1[256] + char str2[128] + arguments + align to 16)

    movl    $msg_main_enter_first_string, (%esp)            # printf("Enter your string : ");
    call    printf

    leal    -256(%ebp), %ebx                                # gets(str1);
    movl    %ebx, (%esp)
    call    gets    

    movl    $msg_main_enter_second_string, (%esp)           # printf("Enter your string : ");
    call    printf

    leal    -384(%ebp), %ebx                                # gets(str2);
    movl    %ebx, (%esp)
    call    gets    

    # char* str = myStrcat(str1, str2);
    leal    -256(%ebp), %ebx
    leal    -384(%ebp), %ecx
    movl    %ebx, (%esp)
    movl    %ecx, 4(%esp)
    call    myStrcat
    movl    %eax, -388(%ebp)                                # char *str = myStrcat(str1, str2);

    movl    $msg_main_print_concetenate_string, (%esp)
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

.globl  myStrcat
.type   myStrcat, @function
myStrcat:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp               # variable + align with 16
   
    # int length = myStrlen(str);
    movl    8(%ebp), %eax                  # %eax = str
    movl    %eax, (%esp)
    call    myStrlen
    movl    %eax, %ecx                      # int length = myStrlen(str);

    movl    8(%ebp), %edi

    leal    (%edi, %ecx, 1), %edi
    movl    %edi, -4(%ebp)                  # %edi = last element of str1

    # int length = myStrlen(str2);
    movl    12(%ebp), %eax                  # %eax = str
    movl    %eax, (%esp)
    call    myStrlen
    movl    %eax, %ecx                      # int length = myStrlen(str2);

    movl    -4(%ebp), %edi
    movl    12(%ebp), %esi
 
    rep     movsb

    movb    $0, (%edi)

    movl    8(%ebp), %eax 


    movl    %ebp, %esp
    popl    %ebp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRCPY FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ==================== TEXT SECTION ENDS HERE ===================== */