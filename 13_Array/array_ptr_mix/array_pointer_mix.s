/* =================================================================
 *	Code   : All Mix Array Pointer Using Compilers Method
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 15th Sept 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print_arr:
.string "arr        = %-10d \t *arr        = %-10d \t &arr        = %-10d\n"

msg_main_print_p:
.string "p          = %-10d \t *p          = %-10d \t **p         = %-10d\n"

msg_main_print_before_ptr:
.string "ptr        = %-10d \t *ptr        = %-10d \t **ptr       = %-10d\n"

msg_main_print_after_ptr:
.string "ptr - p    = %d \t                 *ptr - arr  = %d \t         **ptr       = %d\n"

msg_main_print_elements:
.string "elements : %d\n"
/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

.globl  main
.type   main, @function
main:
    andl    $(-16), %esp
    pushl   %ebp
    movl    %esp, %ebp 

    subl    $64, %esp           # arr + p[] + argument + align = 64

/* ----- for loop to insert element into arr starts here ----- */

    movl    $0, %edx                    # zero out the element value
    movl    $0, %eax                    # loop starting value (int i=0)
    movl    $5, %ecx                    # loop terminating condn (n = 5)
LABEL_FOR_INSERT_ELEMENT:
    leal    -20(%ebp, %eax, 4), %ebx    # ebx = arr + i  
    addl    $10, %edx                   # increment edx by 10 at each iteration
    movl    %edx, (%ebx)                # store the element in arr[i]
    addl    $1, %eax                    # incrementing the counter
    loop    LABEL_FOR_INSERT_ELEMENT

/* ----- for loop for insert element into arr ends here ----- */




/* +++++ for loop to insert address into arr starts here +++++ */

    leal    -20(%ebp), %edx             # taking the starting addr of array 
    movl    $0, %eax
    movl    $5, %ecx
LABEL_FOR_INSERT_ADDRESS:
    leal    -40(%ebp,%eax, 4), %ebx
    movl    %edx, (%ebx)
    addl    $4, %edx 
    addl    $1, %eax 
    loop    LABEL_FOR_INSERT_ADDRESS

/* +++++ for loop for insert address into arr ends here ++++++ */

    leal    -40(%ebp), %ebx             # ebx = base address of p 
    movl    %ebx, -44(%ebp)             # int **ptr = p;

    # printf("arr = %-10d \t *arr = %-10d \t &arr     = %-10d\n", arr, *arr, &arr);
    movl    $msg_main_print_arr, (%esp)
    leal    -20(%ebp), %ebx
    movl    (%ebx), %ecx 
    movl    %ebx, 4(%esp)
    movl    %ecx, 8(%esp)
    movl    %ebx, 12(%esp)
    call    printf

    # printf("p   = %-10d \t *p   = %-10d   \t **p    = %-10d\n", p, *p, **p);
    leal    -40(%ebp), %ebx
    movl    (%ebx), %eax
    movl    (%eax), %edx
    movl    $msg_main_print_p, (%esp)
    movl    %ebx, 4(%esp)
    movl    %eax, 8(%esp)
    movl    %edx, 12(%esp)
    call    printf 

    # printf("ptr = %-10d \t *ptr = %-10d \t **ptr    = %-10d\n", ptr, *ptr, **ptr);
    movl    -44(%ebp), %ebx
    movl    (%ebx), %eax
    movl    (%eax), %edx
    movl    $msg_main_print_before_ptr, (%esp)
    movl    %ebx, 4(%esp)
    movl    %eax, 8(%esp)
    movl    %edx, 12(%esp)
    call    printf 


    # *ptr++
    movl    $1, %eax
    movl    -44(%ebp), %ebx
    leal    (%ebx, %eax, 4), %eax
    movl    %eax, -44(%ebp)

    # printf("ptr - p = %d \t *ptr - arr = %d \t **ptr = %d\n", ptr - p, *ptr - arr, **ptr);
    movl    $msg_main_print_after_ptr, (%esp)
    movl    -44(%ebp), %eax         # eax = ptr
    leal    -40(%ebp), %ebx         # ebx = p
    subl    %ebx, %eax
    movl    $4, %ecx
    divl    %ecx                    # eax = (ptr - p)/size    
    movl    %eax, 4(%esp)

    movl    -44(%ebp), %eax
    movl    (%eax), %eax            # *ptr
    leal    -20(%ebp), %ebx
    subl    %ebx, %eax              
    movl    $4, %ecx
    divl    %ecx                    # (*ptr - arr)/sizeof(int)
    movl    %eax, 8(%esp)

    movl    -44(%ebp), %eax
    movl    (%eax), %eax
    movl    (%eax), %eax
    movl    %eax, 12(%esp)
    call    printf

    # *++ptr
    movl    $1, %eax
    movl    -44(%ebp), %ebx
    leal    (%ebx, %eax, 4), %eax
    movl    %eax, -44(%ebp)
     
    # printf("ptr - p = %d \t *ptr - arr = %d \t **ptr = %d\n", ptr - p, *ptr - arr, **ptr);
    movl    $msg_main_print_after_ptr, (%esp)
    movl    -44(%ebp), %eax         # eax = ptr
    leal    -40(%ebp), %ebx         # ebx = p
    subl    %ebx, %eax
    movl    $4, %ecx
    divl    %ecx                    # eax = (ptr - p)/size    
    movl    %eax, 4(%esp)

    movl    -44(%ebp), %eax
    movl    (%eax), %eax            # *ptr
    leal    -20(%ebp), %ebx
    subl    %ebx, %eax              
    movl    $4, %ecx
    divl    %ecx                    # (*ptr - arr)/sizeof(int)
    movl    %eax, 8(%esp)

    movl    -44(%ebp), %eax
    movl    (%eax), %eax
    movl    (%eax), %eax
    movl    %eax, 12(%esp)
    call    printf

    # ++*ptr
    movl    -44(%ebp), %ebx         # ebx = ptr 
    movl    (%ebx), %eax            # eax = *ptr 
    movl    $1, %ecx        
    leal    (%eax, %ecx, 4), %eax   # eax = *ptr + 4
    movl    %eax, (%ebx)
    

    # printf("ptr - p = %d \t *ptr - arr = %d \t **ptr = %d\n", ptr - p, *ptr - arr, **ptr);
    movl    $msg_main_print_after_ptr, (%esp)
    movl    -44(%ebp), %eax         # eax = ptr
    leal    -40(%ebp), %ebx         # ebx = p
    subl    %ebx, %eax
    movl    $4, %ecx
    divl    %ecx                    # eax = (ptr - p)/size    
    movl    %eax, 4(%esp)

    movl    -44(%ebp), %eax
    movl    (%eax), %eax            # *ptr
    leal    -20(%ebp), %ebx
    subl    %ebx, %eax              
    movl    $4, %ecx
    divl    %ecx                    # (*ptr - arr)/sizeof(int)
    movl    %eax, 8(%esp)

    movl    -44(%ebp), %eax
    movl    (%eax), %eax
    movl    (%eax), %eax
    movl    %eax, 12(%esp)
    call    printf

    movl    $0, (%esp)
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */

