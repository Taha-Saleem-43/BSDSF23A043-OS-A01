#include "../include/mystrfunctions.h"

// Return length of string
int mystrlen(const char* s) {
    int len = 0;
    while (s[len] != '\0') len++;
    return len;
}

// Copy src into dest, return length of dest
int mystrcpy(char* dest, const char* src) {
    int i = 0;
    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return i;
}

// Copy at most n chars, return number of chars copied
int mystrncpy(char* dest, const char* src, int n) {
    int i = 0;
    while (i < n && src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return i;
}

// Concatenate src at the end of dest, return length of dest
int mystrcat(char* dest, const char* src) {
    int i = 0, j = 0;
    while (dest[i] != '\0') i++;
    while (src[j] != '\0') {
        dest[i++] = src[j++];
    }
    dest[i] = '\0';
    return i;
}

