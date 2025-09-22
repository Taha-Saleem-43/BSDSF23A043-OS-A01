# Compiler and Flags
CC = gcc
CFLAGS = -Wall -Iinclude

# Directories
SRC = src
OBJ = obj
BIN = bin
LIB = lib

# Targets
STATIC_LIB = $(LIB)/libmyutils.a
DYNAMIC_LIB = $(LIB)/libmyutils.so
STATIC_TARGET = $(BIN)/client_static
DYNAMIC_TARGET = $(BIN)/client_dynamic

# Source and Object files
UTILS_SRC = $(SRC)/mystrfunctions.c $(SRC)/myfilefunctions.c
UTILS_OBJ = $(OBJ)/mystrfunctions.o $(OBJ)/myfilefunctions.o
MAIN_OBJ = $(OBJ)/main.o

# Default target
all: $(STATIC_TARGET) $(DYNAMIC_TARGET)

# -------- Static Build --------
$(STATIC_LIB): $(UTILS_OBJ)
	ar rcs $@ $^

$(STATIC_TARGET): $(MAIN_OBJ) $(STATIC_LIB)
	$(CC) $(MAIN_OBJ) -L$(LIB) -lmyutils -o $@

# -------- Dynamic Build --------
$(DYNAMIC_LIB): $(UTILS_OBJ)
	$(CC) -shared -o $@ $^

$(DYNAMIC_TARGET): $(MAIN_OBJ) $(DYNAMIC_LIB)
	$(CC) $(MAIN_OBJ) -L$(LIB) -lmyutils -o $@

# -------- Compilation Rules --------
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# -------- Phony Targets --------
.PHONY: all clean

clean:
	rm -f $(OBJ)/*.o $(BIN)/* $(LIB)/*

