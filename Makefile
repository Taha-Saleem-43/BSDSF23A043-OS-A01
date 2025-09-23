# ==============================
# Compiler and Flags
# ==============================
CC = gcc
CFLAGS = -Wall -Iinclude

# ==============================
# Directories
# ==============================
SRC = src
OBJ = obj
BIN = bin
LIB = lib
MAN = man/man3

# ==============================
# Targets
# ==============================
STATIC_LIB = $(LIB)/libmyutils.a
DYNAMIC_LIB = $(LIB)/libmyutils.so
STATIC_TARGET = $(BIN)/client_static
DYNAMIC_TARGET = $(BIN)/client_dynamic

# ==============================
# Sources and Objects
# ==============================
UTILS_SRC = $(SRC)/mystrfunctions.c $(SRC)/myfilefunctions.c
UTILS_OBJ = $(OBJ)/mystrfunctions.o $(OBJ)/myfilefunctions.o
MAIN_SRC  = $(SRC)/main.c
MAIN_OBJ  = $(OBJ)/main.o

# ==============================
# Default target
# ==============================
all: static dynamic

# ==============================
# Static Build
# ==============================
$(STATIC_LIB): $(UTILS_OBJ) | $(LIB)
	ar rcs $@ $^
	ranlib $@

$(STATIC_TARGET): $(MAIN_OBJ) $(STATIC_LIB) | $(BIN)
	# link directly to the .a file to guarantee static build
	$(CC) $(MAIN_OBJ) $(STATIC_LIB) -o $@

# ==============================
# Dynamic Build
# ==============================
$(DYNAMIC_LIB): $(UTILS_OBJ) | $(LIB)
	$(CC) -shared -o $@ $^

$(DYNAMIC_TARGET): $(MAIN_OBJ) $(DYNAMIC_LIB) | $(BIN)
	# use rpath so binary knows where to find .so
	$(CC) $(MAIN_OBJ) -L$(LIB) -lmyutils -Wl,-rpath=$(LIB) -o $@

# ==============================
# Compilation Rule
# ==============================
$(OBJ)/%.o: $(SRC)/%.c | $(OBJ)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# ==============================
# Directory creation
# ==============================
$(OBJ) $(BIN) $(LIB):
	mkdir -p $@

# ==============================
# Install Target
# ==============================
.PHONY: install
install: $(DYNAMIC_TARGET)
	install -d /usr/local/bin
	install -m 755 $(DYNAMIC_TARGET) /usr/local/bin/client
	install -d /usr/local/share/man/man3
	install -m 644 $(MAN)/* /usr/local/share/man/man3/
	mandb >/dev/null 2>&1 || true

# ==============================
# Phony Targets
# ==============================
.PHONY: all clean static dynamic

static: $(STATIC_TARGET)
dynamic: $(DYNAMIC_TARGET)

clean:
	rm -f $(OBJ)/*.o $(BIN)/* $(LIB)/*
