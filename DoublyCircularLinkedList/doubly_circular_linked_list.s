/* =================================================================
 *	Code   : Doubly Circular Linked List
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 21st Sept 2026
 * ================================================================= */

.equ    NULL,             0         # equivalent to #define NULL 0
.equ    struct_list_size, 12        # sizeof(struct list)
/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print_menu:
    .string "\n1.Insert\n2.Delete\n3.Search\n4.Count\n5.Reverse Display\n6.Exit\n"

msg_main_enter_choice:
    .string "Enter your choice:\t"

msg_main_scan_no:
    .string "%d"

msg_main_switch_print_insert_list_menu:
    .string "\n1.InsertFirst\n2.InsertLast\n3.InsertAtPosition\n4.Back\n"

msg_main_switch_enter_choice_again:
    .string "Enter your choice again:\t"

msg_main_switch_enter_valid_choice:
    .string "Enter valid choice\n"

msg_main_switch_enter_data_to_insert:
    .string "Enter data to be insert:\t"

msg_main_switch_enter_position:
    .string "Enter position:\t"

msg_main_switch_empty_list:
    .string "Linked List Empty\n"

msg_main_switch_case2_empty_list:
    .string "Linked List Empty, Deletion impossible.\n"

msg_main_switch_print_delete_list_menu:
    .string "\n1.DeleteFirst\n2.DeleteLast\n3.DeleteAtPosition\n4.Back\n"

msg_main_switch_print_delete_data:
    .string "Deleted data is %d\n"

msg_main_switch_case3_empty_list:
    .string "Linked List Empty, Searching impossible.\n"

msg_main_switch_print_search_list_menu:
    .string "\n1.SearchFirstOccurance\n2.SearchLastOccurance\n3.SearchAllOccurances\n4.Back\n"

msg_main_switch_enter_data_to_search:
    .string "Enter data to be search:\t"

msg_main_switch_print_data_not_found:
    .string "Data not found\n"

msg_main_switch_print_data_found_at_pos:
    .string "Data found at %d position\n"

msg_main_switch_print_data_found_times:
    .string "Data found %d times\n"

msg_main_switch_print_total_node:
    .string "Total node present : %d\n"

msg_main_switch_print_bye:
    .string "Bye...\n"

msg_print_mem_failed:
    .string "memory allocation FAILED\n"

msg_print_invalid_position:
    .string "Position is invalid\n"

msg_display_print_list:
    .string "\nLinked list is:\n"

msg_print_empty:
    .string "EMPTY\n"

msg_print_arrow_data:
    .string "<-|%d|->"

msg_print_new_line:
    .string "\n"

msg_delete_print_all_node_deleted:
    .string "\nDeleted All Nodes Successfully\n"

msg_reverse_display_print_list:
    .string "\nReverse Linked list is:\n"



/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  main
.type   main, @function
main:
    andl    $(-16), %esp
    pushl   %ebp
    movl    %esp, %ebp 

    subl    $48, %esp                               # local variable, parameters and align with 16

    movl    $NULL, -16(%ebp)                        # struct list *pFirst = NULL 
    movl    $NULL, -20(%ebp)                        # struct list *pLast  = NULL 

/* ------------------------- while loop starts here ----------------- */

LABEL_OUTSIDE_WHILE:
    movl    $msg_main_print_menu, (%esp)            # printf("\n1.Insert\n2.Delete\n3.Search\n4.Count\n5.Reverse Display\n6.Exit\n" );
    call    printf

    movl    $msg_main_enter_choice, (%esp)          # printf("Enter your choice:\t");
    call    printf

    leal    -12(%ebp), %ebx                         # scanf("%d", &iChoice);
    movl    $msg_main_scan_no, (%esp)
    movl    %ebx, 4(%esp)
    call    scanf

    /* ++++++++++ switch case starts here +++++++++++++++ */
    movl    -12(%ebp), %eax
    cmpl    $1, %eax                                
    je      LABEL_CASE_1
    cmpl    $2, %eax
    je      LABEL_CASE_2
    cmpl    $3, %eax
    je      LABEL_CASE_3
    cmpl    $4, %eax
    je      LABEL_CASE_4
    cmpl    $5, %eax
    je      LABEL_CASE_5
    cmpl    $6, %eax
    je      LABEL_CASE_6
    jmp     LABEL_CASE_DEFAULT

LABEL_CASE_1:
    /* ----------- case 1 while starts here -------------- */
LABEL_CASE_1_WHILE:
    movl    $msg_main_switch_print_insert_list_menu,(%esp)              # printf("\n1.InsertFirst\n2.InsertLast\n3.InsertAtPosition\n4.Back\n");
    call    printf

    movl    $msg_main_switch_enter_choice_again, (%esp)                 # printf("Enter your choice again:\t");
    call    printf

    leal    -12(%ebp), %ebx                                             # scanf("%d", &iChoice);
    movl    $msg_main_scan_no, (%esp)
    movl    %ebx, 4(%esp)
    call    scanf

    movl    -12(%ebp), %eax                                             # %eax = iChoice
    
    cmpl    $4, %eax                                                    # if(iChoice == 4)
    je      LABEL_CASE_1_BREAK

    cmpl    $0, %eax
    jle     LABEL_CASE_1_VALID_CHOICE_IF
    
    cmpl    $3, %eax
    jle     LABEL_CASE_1_VALID_CHOICE_ELSE

LABEL_CASE_1_VALID_CHOICE_IF:
    movl    $msg_main_switch_enter_valid_choice, (%esp)
    call    printf
    jmp     LABEL_CASE_1_WHILE

LABEL_CASE_1_VALID_CHOICE_ELSE:
    movl    $msg_main_switch_enter_data_to_insert, (%esp)               # printf("Enter data to be insert:\t");
    call    printf 

    leal    -4(%ebp), %ebx                                              # scanf("%d", &iNo);
    movl    $msg_main_scan_no, (%esp)
    movl    %ebx, 4(%esp)
    call    scanf

    /* ------- inside case 1, inside switch case starts here ------ */
    movl    -12(%ebp), %eax
    cmpl    $1, %eax
    je      LABEL_CASE_1_CASE_1
    cmpl    $2, %eax
    je      LABEL_CASE_1_CASE_2
    cmpl    $3, %eax
    je      LABEL_CASE_1_CASE_3
    jmp     LABEL_CASE_1_CASE_1_BREAK
    
LABEL_CASE_1_CASE_1:
    # InsertFirst(&pFirst, &pLast, iNo);                        
    leal    -16(%ebp), %eax         
    leal    -20(%ebp), %edx
    movl    -4(%ebp), %ecx
    movl    %eax, (%esp)
    movl    %edx, 4(%esp)
    movl    %ecx, 8(%esp)
    call    InsertFirst                                     # InsertFirst(&pFirst, &pLast, iNo);

    jmp     LABEL_CASE_1_CASE_1_BREAK                       

LABEL_CASE_1_CASE_2:
    # InsertLast(&pFirst, &pLast, iNo);
    leal    -16(%ebp), %eax         
    leal    -20(%ebp), %edx
    movl    -4(%ebp), %ecx
    movl    %eax, (%esp)
    movl    %edx, 4(%esp)
    movl    %ecx, 8(%esp)
    call    InsertLast                                     # InsertLast(&pFirst, &pLast, iNo);

    jmp     LABEL_CASE_1_CASE_1_BREAK

LABEL_CASE_1_CASE_3:
      
    /* ------- inside case 1, inside switch case ends here ------ */

LABEL_CASE_1_CASE_1_BREAK:
    # call to the display function here
    movl    -16(%ebp), %eax                                 # Display(pFirst, pLast);
    movl    -20(%ebp), %edx
    movl    %eax, (%esp)
    movl    %edx, 4(%esp)
    call    Display

    jmp     LABEL_CASE_1_WHILE

    /* ------------- case 1 while ends here -------------- */

LABEL_CASE_1_BREAK:

    jmp     LABEL_OUTSIDE_WHILE

LABEL_CASE_2:
    movl    $msg_main_switch_print_data_found_at_pos, (%esp)
    movl    %eax, 4(%esp)
    call    printf
    jmp     LABEL_OUTSIDE_WHILE

LABEL_CASE_3:

    movl    $msg_main_switch_print_data_found_at_pos, (%esp)
    movl    %eax, 4(%esp)
    call    printf
    jmp     LABEL_OUTSIDE_WHILE

LABEL_CASE_4:

    movl    $msg_main_switch_print_data_found_at_pos, (%esp)
    movl    %eax, 4(%esp)
    call    printf
    jmp     LABEL_OUTSIDE_WHILE

LABEL_CASE_5:

    movl    $msg_main_switch_print_data_found_at_pos, (%esp)
    movl    %eax, 4(%esp)
    call    printf
    jmp     LABEL_OUTSIDE_WHILE

LABEL_CASE_6:

    movl    $msg_main_switch_print_data_found_at_pos, (%esp)
    movl    %eax, 4(%esp)
    call    printf
    jmp     LABEL_OUTSIDE_WHILE

LABEL_CASE_DEFAULT:

    movl    $msg_main_switch_print_data_found_at_pos, (%esp)
    movl    %eax, 4(%esp)
    call    printf
    jmp     LABEL_OUTSIDE_WHILE


    /* ++++++++++++ switch case ends here +++++++++++++++ */                           

    #loop    LABEL_OUTSIDE_WHILE


/* -------------------------- while loop ends here ------------------ */

    movl    $0, (%esp)
    call    exit

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o MAIN FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o INSERT LAST FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  InsertLast
.type   InsertLast, @function
InsertLast:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp                                               # variable + no of argument + align with 16

    movl    $NULL, -4(%ebp)                                         # struct list *pNewNode = NULL 

    # pNewNode = (struct List *)malloc(sizeof(struct List));
    movl    $struct_list_size, (%esp)
    call    malloc                                                  # malloc(sizeof(struct list))
    movl    %eax, -4(%ebp)                                          # pNewNode = malloc(struct list size)
    
    # if(NULL == pNewNode)
    cmpl    $0, %eax 
    jne     LABEL_INSERT_LAST_MEM_ALLOCATED
    movl    $msg_print_mem_failed, (%esp)                           # printf("memory allocation FAILED\n");
    call    printf
    jmp     LABEL_INSERT_LAST_EXIT

LABEL_INSERT_LAST_MEM_ALLOCATED:
    # pNewNode->iData = iNo;
    movl    -4(%ebp), %ebx                                          # %ebx = pNewNode
    movl    16(%ebp), %eax                                          # %eax = iNo
    movl    %eax, 4(%ebx)                                           # pNewNode->data = iNo 

    # if(NULL == *ppHead)
    movl    8(%ebp), %ebx                                           # %ebx = ppHead
    movl    (%ebx), %ecx                                            # %ebx = *ppHead
    cmpl    $0, %ecx
    jne     LABEL_INSERT_LAST_LIST_NOT_EMPTY
    
    # *ppHead = pNewNode;
    movl    -4(%ebp), %eax                                          # %eax = pNewNode
    movl    %eax, (%ebx)                                            # *ppHead = pNewNode

    # *ppTail = pNewNode
    movl    12(%ebp), %ecx                                          # %ecx = ppTail
    movl    %eax, (%ecx)                                            # *ppTail = pNewNode

    # (*ppTail)->pNext = *ppHead;
    movl    8(%ebp), %ebx
    movl    (%ebx), %eax                                            # %eax = *ppHead 
    movl    12(%ebp), %ecx                                          # %ecx = ppTail
    movl    %eax, 8(%ecx)                                           # (*ppTail)->pNext = *ppHead;


    # (*ppHead)->pPrev = *ppTail;
    movl    12(%ebp), %ebx
    movl    (%ebx), %eax                                            # %eax = *ppTail
    movl    8(%ebp), %ecx
    movl    %eax, 8(%ecx)                                           # (*ppHead)->pPrev = *ppTail;

    jmp     LABEL_INSERT_LAST_EXIT                                  # return  


LABEL_INSERT_LAST_LIST_NOT_EMPTY:

    # (*ppTail)->pNext = pNewNode;
    movl    -4(%ebp), %eax                                          # %eax = pNewNode
    movl    12(%ebp), %ebx                                          # %ebx = ppTail
    movl    (%ebx), %ebx                                            # %ebx = *ppTail 
    movl    %eax, 8(%ebx)                                           # (*ppTail)->pNext = pNewNode;

    # pNewNode->pPrev = *ppTail;
    movl    12(%ebp), %ebx                                          # %ebx = ppTail
    movl    (%ebx), %eax                                            # %eax = *ppTail                                           
    movl    -4(%ebp), %ecx                                          # %ecx = pNewNode
    movl    %eax, (%ecx)                                            # pNewNode->pPrev = *ppTail;

    # *ppTail = pNewNode;
    movl    -4(%ebp), %eax                                          # %eax = pNewNode
    movl    12(%ebp), %ebx                                          # %ebx = ppTail
    movl    (%ebx), %ebx 
    movl    %eax, (%ebx)                                            # *ppTail = pNewNode;

    # (*ppTail)->pNext = *ppHead;
    movl    8(%ebp), %ebx                                           # %ebx = ppHead
    movl    (%ebx), %eax                                            # %eax = *ppHead
    movl    12(%ebp), %ecx
    movl    (%ecx), %ecx 
    movl    %eax, 8(%ecx)                                           # (*ppTail)->pNext = *ppHead;

    # (*ppHead)->pPrev = *ppTail;
    movl    12(%ebp), %eax
    movl    (%eax), %eax                                            # %eax = *ppTail
    movl    8(%ebp), %ebx
    movl    %eax, (%ebx)                                            # (*ppHead)->pPrev = *ppTail;



LABEL_INSERT_LAST_EXIT:
    movl    %ebp, %esp
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o INSERT LAST FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */



/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o INSERT FIRST FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  InsertFirst
.type   InsertFirst, @function
InsertFirst:
    pushl   %ebp
    movl    %esp, %ebp
    
    subl    $16, %esp                                   # variable + no of argument + align with 16

    movl    $NULL, -4(%ebp)                             # struct list *pNewNode = NULL 

    movl    $struct_list_size, (%esp)                   # sizeof(struct list)
    call    malloc                                      # malloc(sizeof(struct list))
    movl    %eax, -4(%ebp)                              # pNewNode = malloc(sizeof(struct list))

    cmpl    $0, %eax                                    # if(NULL == pNewNode)
    jne     LABEL_MEM_ALLOCATED
    movl    $msg_print_mem_failed, (%esp)               # printf("memory allocation FAILED\n");
    call    printf
    jmp     LABEL_INSERT_FIRST_EXIT

LABEL_MEM_ALLOCATED:

    # pNewNode->iData = iNo;
    #movl    $1, %eax                                    # iCounter
    movl    -4(%ebp), %ebx                              # ebx = pNewNode
    #leal    (%ebx, %eax, 4), %ebx                       # ebx = pNewNode + 1 * sizeof(char*) (accesing the addr of second element of struct list)
    
    movl    16(%ebp), %eax                              # eax = iNo 
    movl    %eax, 4(%ebx)                               # pNewNode->iData = iNo

    # if(NULL == *ppHead)
    movl    8(%ebp), %ebx
    movl    (%ebx), %eax                                # *ppHead
    cmpl    $0, %eax                                    # if(NULL == *ppHead)
    jne     LABEL_LIST_NOT_EMPTY

    movl    -4(%ebp), %ecx                              # %ecx = pNewNode
    movl    %ecx, (%ebx)                                # *ppHead = pNewNode;

    movl    12(%ebp), %edx                              # edx = ppTail 
    movl    %ecx, (%edx)                                # ppTail = pNewNode

    movl    8(%ebp), %ebx
    movl    (%ebx), %eax                                # *ppHead 
    movl    12(%ebp), %edx
    movl    (%edx), %edx                                # *(ppTail)
    #movl    $2, %ecx
    #movl    %eax, (%edx, %ecx, 4)                       # (*ppTail)->pNext = *ppHead
    movl    %eax, 8(%edx)

    movl    (%ebx), %eax                                # (*ppHead)
    #movl    $0, %ecx        
    #movl    %edx, (%eax, %ecx, 4)                       # (*ppHead)->pPrev = *ppTail
    movl    %edx, (%eax)

    jmp     LABEL_INSERT_FIRST_EXIT                         



LABEL_LIST_NOT_EMPTY:
    # pNewNode->pNext = *ppHead;  
    #movl    $2, %eax                                    # iCounter
    movl    -4(%ebp), %ebx                              # ebx = pNewNode
    #leal    (%ebx, %eax, 4), %ebx                       # ebx = pNewNode->pNext
    leal    8(%ebx), %ebx
    movl    8(%ebp), %eax                               # ppHead
    movl    (%eax), %eax                                # *ppHead
    movl    %eax, (%ebx)                                # pNewNode->pNext = *ppHead

    # (*ppHead)->pPrev = pNewNode;
    #movl    $0, %ecx                    
    #leal    (%eax, %ecx, 4), %ecx                       # ecx = (*ppHead)->pPrev
    leal    (%eax), %ecx
    movl    -4(%ebp), %edx                              # edx = pNewNode
    movl    %edx, (%ecx)                                # (*ppHead)->pPrev = pNewNode

    # *ppHead = pNewNode;
    movl    -4(%ebp), %edx                              # edx = pNewNode
    movl    8(%ebp), %eax                               # ppHead
    movl    %edx, (%eax)                                # *ppHead = pNewNode

    # (*ppTail)->pNext = *ppHead;
    movl    8(%ebp), %eax                               # ppHead
    movl    (%eax), %eax                                # *ppHead
    movl    12(%ebp), %ebx                              # ppTail
    movl    (%ebx), %ebx                                # *ppTail 
    #movl    $2, %ecx 
    #leal    (%ebx, %ecx, 4), %ecx                       # *ppTail->pNext
    leal    8(%ebx), %ecx
    movl     %eax, (%ecx)                               # *ppTail->pNext = *ppHead

    # (*ppHead)->pPrev = *ppTail;
    #movl    $0, %ecx
    #leal    (%eax, %ecx, 4), %ecx                       # (*ppHead)->pPrev
    leal    (%eax), %ecx
    movl    %ebx, (%ecx)                                # (*ppHead)->pPrev = *ppTail


LABEL_INSERT_FIRST_EXIT:
    movl    %ebp, %esp
    popl    %ebp
    ret

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o INSERT FIRST FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o INSERT AT POS FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  InsertAtPosition
.type   InsertAtPosition, @function
InsertAtPosition:
    pushl   %ebp
    movl    %esp, %ebp
    

    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o INSERT AT POS FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */



/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE LAST FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  DeleteLast
.type   DeleteLast, @function
DeleteLast:
    pushl   %ebp
    movl    %esp, %ebp


    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE LAST FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */



/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE FIRST FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  DeleteFirst
.type   DeleteFirst, @function
DeleteFirst:
    pushl   %ebp
    movl    %esp, %ebp
    

    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE FIRST FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE AT POS FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  DeleteAtPosition
.type   DeleteAtPosition, @function
DeleteAtPosition:
    pushl   %ebp
    movl    %esp, %ebp
    

    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE AT POS FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE ALL NODES FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  DeleteAllNodes
.type   DeleteAllNodes, @function
DeleteAllNodes:
    pushl   %ebp
    movl    %esp, %ebp
    

    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DELETE ALL NODES FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o SEARCH LAST OCCURANCE FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  SearchLastOccurance
.type   SearchLastOccurance, @function
SearchLastOccurance:
    pushl   %ebp
    movl    %esp, %ebp


    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o SEARCH LAST OCCURANCE FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */



/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o SEARCH FIRST OCCURANCE FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  SearchFirstOccurance
.type   SearchFirstOccurance, @function
SearchFirstOccurance:
    pushl   %ebp
    movl    %esp, %ebp
    

    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o SEARCH FIRST OCCURANCE FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o SEARCH ALL OCCURANCES FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  SearchAllOccurances
.type   SearchAllOccurances, @function
SearchAllOccurances:
    pushl   %ebp
    movl    %esp, %ebp
    

    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o SEARCH ALL NODES OCCURANCES FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DISPLAY FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  Display
.type   Display, @function
Display:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp               # size of total no of argument + align with 16

    movl    $msg_display_print_list, (%esp)
    call    printf

    movl    8(%ebp), %ebx               # %ebx = pHead
    #movl    (%ebx), %ecx               # %eax = *pHead
    cmpl    $0, %ebx        
    jne     LABEL_DISPLAY_LIST
    movl    $msg_print_empty, (%esp)
    call    printf 
    jmp     LABEL_DISPLAY_EXIT

LABEL_DISPLAY_LIST:
    # printf("<-|%d|->", pHead->iData);
    #movl    $1, %eax
    movl    8(%ebp), %ebx                               # ebx = pHead
    #movl    (%ebx, %eax, 4), %eax                       # eax = pHead->data
    movl    4(%ebx), %eax
    movl    $msg_print_arrow_data, (%esp)
    movl    %eax, 4(%esp)
    call    printf

    #movl    $2, %eax 
    movl    8(%ebp), %ebx                               # ebx = pHead
    #movl    (%ebx, %eax, 4), %ecx                       # ecx = pHead->pNext
    movl    8(%ebx), %ecx
    movl    %ecx, 8(%ebp)                               

    #movl    $2, %eax
    movl    12(%ebp), %edx
    #movl    (%edx, %eax, 4), %edx                       # edx = pTail->pNext
    movl    8(%edx), %edx
    cmpl    %edx, %ecx
    jne     LABEL_DISPLAY_LIST


    movl    $msg_print_new_line, (%esp)
    call    printf


LABEL_DISPLAY_EXIT:
    movl    %ebp, %esp
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o DISPLAY FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o REVERSE DISPLAY FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  ReverseDisplay
.type   ReverseDisplay, @function
ReverseDisplay:
    pushl   %ebp
    movl    %esp, %ebp


    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o REVERSE DISPLAY FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o COUNT NODE FUNCTION EXECUTION CODE STARTS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
.globl  CountNode
.type   CountNode, @function
CountNode:
    pushl   %ebp
    movl    %esp, %ebp
    

    movl    %ebp, %esp    
    popl    %ebp 
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o COUNT NODE FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */




/* ==================== TEXT SECTION ENDS HERE ===================== */

