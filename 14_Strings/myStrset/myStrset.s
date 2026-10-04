/* =================================================================
 *	Code   : myStrset
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 30th Sept 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_enter_string : 
	.string "Enter your string : "

    msg_main_enter_replacing_char:
    .string "Enter Your Replacing Char : "

	msg_main_print_replaced_string : 
	.string "your replaced string : %s\n"

    msg_scan_string:
    .string "%s"

    msg_scan_char:
    .string "%c"
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

    movl   $msg_main_enter_replacing_char, (%esp)
    call    printf

    leal    -260(%ebp), %eax
    movl    $msg_scan_char, (%esp)
    movl    %eax, 4(%esp) 
    call    scanf

    # char* str = myStrset(str1, ch);
    leal    -256(%ebp), %eax                        # %eax = str
    movl    -260(%ebp), %edx                        # %edx = ch
    movl    %eax, (%esp)
    movl    %edx, 4(%esp)
    call    myStrset
    movl    %eax, -264(%ebp)                         # char* str = myStrset(str1, ch);


    # printf("your replaced string is \"%s\"\n", str);
    leal    -256(%ebp), %ebx
    movl    $msg_main_print_replaced_string, (%esp)
    movl    %eax, 4(%esp)
    call    printf 

	movl $0, (%esp)
	call exit

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRSET FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

.globl  myStrset
.type   myStrset, @function
myStrset:
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

    #leal    (%edi, %ecx, 1), %edi

    movb    12(%ebp), %al 
    rep     stosb

    movl    8(%ebp), %eax

    movl    %ebp, %esp
    popl    %ebp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MY_STRSET FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ==================== TEXT SECTION ENDS HERE ===================== */