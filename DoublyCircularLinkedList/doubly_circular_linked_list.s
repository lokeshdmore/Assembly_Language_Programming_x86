/* =================================================================
 *	Code   : Doubly Circular Linked List
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 21st Sept 2026
 * ================================================================= */

.equ    NULL, 0        # equivalent to #define NULL 0

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
    movl    $msg_main_switch_print_insert_list_menu,(%esp)      # printf("\n1.InsertFirst\n2.InsertLast\n3.InsertAtPosition\n4.Back\n");
    call    printf

    movl    $msg_main_switch_enter_choice_again, (%esp)         # printf("Enter your choice again:\t");
    call    printf

    leal    -12(%ebp), %ebx                                     # scanf("%d", &iChoice);
    movl    $msg_main_scan_no, (%esp)
    movl    %ebx, 4(%esp)
    call    scanf

    movl    -12(%ebp), %eax
    
    cmpl    $4, %eax                                            # if(iChoice == 4)
    je      LABEL_CASE_1_BREAK

    cmpl    $0, %eax
    jle     LABEL_CASE_1_ENTER_VALID_CHOICE_TRUE
    
    cmpl    $3, %eax
    jle     LABEL_CASE_1_ENTER_VALID_CHOICE_FALSE

LABEL_CASE_1_ENTER_VALID_CHOICE_TRUE:
    movl    $msg_main_switch_enter_valid_choice, (%esp)
    call    printf
    jmp     LABEL_CASE_1_WHILE

LABEL_CASE_1_ENTER_VALID_CHOICE_FALSE:
    leal    -4(%ebp), %ebx
    movl    $msg_main_switch_enter_data_to_insert, (%esp)
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
        # call to the insertFirst() 
        jmp     LABEL_CASE_1_CASE_1_BREAK

    LABEL_CASE_1_CASE_2:
        # call to the insertLast()
        jmp     LABEL_CASE_1_CASE_1_BREAK

    LABEL_CASE_1_CASE_3:
      
    /* ------- inside case 1, inside switch case ends here ------ */


    LABEL_CASE_1_CASE_1_BREAK:
        # call to the display function here

    #loop    LABEL_CASE_1_WHILE


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


    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
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


    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
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


    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
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


    popl    %ebp 
    movl    %ebp, %esp
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


    popl    %ebp 
    movl    %ebp, %esp
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
    

    popl    %ebp 
    movl    %ebp, %esp
    ret 

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*        o=o=o=o=o=o=o=o=o=o=o=o=o=o=o COUNT NODE FUNCTION EXECUTION CODE ENDS HERE o=o=o=o=o=o=o=o=o=o=o=o=o=                       
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */




/* ==================== TEXT SECTION ENDS HERE ===================== */

