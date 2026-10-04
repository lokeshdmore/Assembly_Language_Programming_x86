/* =================================================================
 *	Code   : myStrncat using rep 
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

    msg_scan_no:
    .string "%d"

    msg_main_enter_no_char:
    .string "Enter the no of character to concetenate: "

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

    subl    $416, %esp                                      # local variables (char str1[256] + char str2[128] + arguments + align to 16)

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

    movl    $msg_main_enter_no_char, (%esp)
    call    printf

    leal    -392(%ebp), %ebx
    movl    $msg_scan_no, (%esp)
    movl    %ebx, 4(%esp)
    call    scanf

    # char* str = myStrncat(str1, str2, no);
    leal    -256(%ebp), %ebx
    leal    -384(%ebp), %ecx
    movl    -392(%ebp), %edx
    movl    %ebx, (%esp)
    movl    %ecx, 4(%esp)
    movl    %edx, 8(%esp)
    call    myStrncat
    movl    %eax, -388(%ebp)                               # char *str = myStrncat(str1, str2, no);

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

.globl  myStrncat
.type   myStrncat, @function
myStrncat:
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

    movl    16(%ebp), %ecx                  

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