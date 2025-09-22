# Compiler and Flags
CC = gcc
CFLAGS = -Iinclude -Wall

# Directories
SRC = src
OBJ = obj
BIN = bin

# Target
TARGET = $(BIN)/client

# Source and Object files
SOURCES = $(SRC)/main.c $(SRC)/mystrfunctions.c $(SRC)/myfilefunctions.c
OBJECTS = $(OBJ)/main.o $(OBJ)/mystrfunctions.o $(OBJ)/myfilefunctions.o

# Linking Rule
$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET)

# Compilation Rule
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Phony Targets
.PHONY: all clean

all: $(TARGET)

clean:
	rm -f $(OBJ)/*.o $(TARGET)

