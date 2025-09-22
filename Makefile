# Compiler and Flags
CC = gcc
CFLAGS = -Iinclude -Wall

# Directories
SRC = src
OBJ = obj
BIN = bin
LIB = lib

# Targets
TARGET = $(BIN)/client_static
STATIC_LIB = $(LIB)/libmyutils.a

# Sources and Objects
LIB_SOURCES = $(SRC)/mystrfunctions.c $(SRC)/myfilefunctions.c
LIB_OBJECTS = $(OBJ)/mystrfunctions.o $(OBJ)/myfilefunctions.o

MAIN_SOURCE = $(SRC)/main.c
MAIN_OBJECT = $(OBJ)/main.o

# Linking Rule (link main with static lib)
$(TARGET): $(MAIN_OBJECT) $(STATIC_LIB)
	$(CC) $(MAIN_OBJECT) -L$(LIB) -lmyutils -o $(TARGET)

# Build static library
$(STATIC_LIB): $(LIB_OBJECTS)
	ar rcs $@ $(LIB_OBJECTS)
	ranlib $@

# Compilation Rule
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Phony Targets
.PHONY: all clean

all: $(TARGET)

clean:
	rm -f $(OBJ)/*.o $(TARGET) $(STATIC_LIB)

