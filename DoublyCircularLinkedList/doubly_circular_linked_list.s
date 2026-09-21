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

msg_main_switch_print_data_not_found_at_pos:
    .string "Data found at %d position\n"

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
    

    /* ++++++++++++ switch case ends here +++++++++++++++ */                           

    loop    LABEL_OUTSIDE_WHILE


/* -------------------------- while loop ends here ------------------ */

    movl    $0, (%esp)
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */

