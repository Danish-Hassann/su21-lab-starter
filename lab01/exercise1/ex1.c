#include <string.h>
#include "ex1.h"

/* Returns the number of times LETTER appears in STR.
There are two different ways to iterate through a string.
1st way hint: strlen() may be useful
2nd way hint: all strings end in a null terminator */
int num_occurrences(char *str, char letter) {
    int count = 0;
    while (*str != '\0') {            
        if (*str == letter) {
            count += 1;               
        }
        str++;                       
    }
    
    return count;                     
}

/* Populates DNA_SEQ with the number of times each nucleotide appears.
Each sequence will end with a NULL terminator and will have up to 20 nucleotides.
All letters will be upper case. */
void compute_nucleotide_occurrences(DNA_sequence *dna_seq) {
    char *ptr = dna_seq->sequence;
    dna_seq->A_count = num_occurrences(ptr, 'A'); 
    dna_seq->C_count = num_occurrences(ptr, 'C');
    dna_seq->G_count = num_occurrences(ptr, 'G');
    dna_seq->T_count = num_occurrences(ptr, 'T');
    return;
}