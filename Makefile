# Compiler and Flags
CC = gcc
CFLAGS = -Wall -Iinclude

# Directories
SRC = src
OBJ = obj
BIN = bin
LIB = lib
MAN = man/man3
MANDIR = /usr/local/share/man

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
$(STATIC_LIB): $(UTILS_OBJ) | $(LIB)
	ar rcs $@ $^

$(STATIC_TARGET): $(MAIN_OBJ) $(STATIC_LIB) | $(BIN)
	$(CC) $(MAIN_OBJ) -L$(LIB) -lmyutils -o $@

# -------- Dynamic Build --------
$(DYNAMIC_LIB): $(UTILS_OBJ) | $(LIB)
	$(CC) -shared -o $@ $^

$(DYNAMIC_TARGET): $(MAIN_OBJ) $(DYNAMIC_LIB) | $(BIN)
	$(CC) $(MAIN_OBJ) -L$(LIB) -lmyutils -Wl,-rpath=$(LIB) -o $@

# -------- Compilation Rules --------
$(OBJ)/%.o: $(SRC)/%.c | $(OBJ)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# -------- Directory creation --------
$(OBJ) $(BIN) $(LIB):
	mkdir -p $@

# -------- Install Target --------
.PHONY: install
install: $(DYNAMIC_TARGET)
	install -d /usr/local/bin
	install -m 755 $(DYNAMIC_TARGET) /usr/local/bin/client_dynamic
	install -m 755 $(DYNAMIC_TARGET) /usr/local/bin/client_static
	install -d /usr/local/share/man/man1
	install -m 644 man/man3/*.1 /usr/local/share/man/man1/

# -------- Phony Targets --------
.PHONY: all clean

clean:
	rm -f $(OBJ)/*.o $(BIN)/* $(LIB)/*

