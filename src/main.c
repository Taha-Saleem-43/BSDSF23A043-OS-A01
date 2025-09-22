#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main(int argc, char* argv[]) {
    // Check if user provided a filename
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    printf("--- Testing String Functions ---\n");

    char str1[100] = "Hello";
    char str2[100] = "World";
    char buffer[100];

    printf("Length of '%s' = %d\n", str1, mystrlen(str1));

    mystrcpy(buffer, str1);
    printf("Copy: %s\n", buffer);

    mystrncpy(buffer, str2, 3);
    printf("Copy 3 chars: %s\n", buffer);

    mystrcat(str1, str2);
    printf("Concatenate: %s\n", str1);

    printf("\n--- Testing File Functions ---\n");

    FILE* fp = fopen(argv[1], "r");
    if (!fp) {
        printf("Could not open file %s\n", argv[1]);
        return 1;
    }

    int lines, words, chars;
    if (wordCount(fp, &lines, &words, &chars) == 0) {
        printf("Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);
    }

    char** matches;
    int matchCount = mygrep(fp, "test", &matches);
    if (matchCount >= 0) {
        printf("Found %d matching lines:\n", matchCount);
        for (int i = 0; i < matchCount; i++) {
            printf("%s", matches[i]);
            free(matches[i]);
        }
        free(matches);
    }

    fclose(fp);
    return 0;
}


