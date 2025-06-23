#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    // Step 1: Initialize two pointers to the head of the list
    node *slow_ptr = head;
    node *fast_ptr = head;

    // Step 2–4: Traverse the list with two pointers
    while (fast_ptr != NULL && fast_ptr->next != NULL) {
        slow_ptr = slow_ptr->next;           // move slow_ptr by one
        fast_ptr = fast_ptr->next->next;     // move fast_ptr by two

        // Step 4: If they meet, a cycle exists
        if (slow_ptr == fast_ptr) {
            return 1; // Cycle detected
        }
    }

    // If we reach the end of the list, there's no cycle
    return 0;
}