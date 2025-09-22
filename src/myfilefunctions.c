
#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

// Count lines, words, and characters in a file
int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (!file) return -1;

    *lines = *words = *chars = 0;
    int c, inWord = 0;

    while ((c = fgetc(file)) != EOF) {
        (*chars)++;
        if (c == '\n') (*lines)++;
        if (c == ' ' || c == '\n' || c == '\t') {
            inWord = 0;
        } else if (!inWord) {
            inWord = 1;
            (*words)++;
        }
    }

    rewind(file);
    return 0;
}

// Search for lines containing search_str and store in matches array
int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp || !search_str) return -1;

    char buffer[256];
    int count = 0, capacity = 5;
    *matches = malloc(capacity * sizeof(char*));

    while (fgets(buffer, sizeof(buffer), fp)) {
        if (strstr(buffer, search_str)) {
            if (count >= capacity) {
                capacity *= 2;
                *matches = realloc(*matches, capacity * sizeof(char*));
            }
            (*matches)[count++] = strdup(buffer);
        }
    }

    rewind(fp);
    return count;
}

