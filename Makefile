CC = gcc
CFLAGS = -g -Wall -Iinc -mno-ms-bitfields
LDFLAGS =
SOURCES = src/main.c src/storage.c src/flash.c src/gif.c src/ansiGraphic2.1.c src/gifdec.c src/text.c src/ZX_Spectrum_8pt.c
INCLUDES = $(wildcard inc/*.h)
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(SOURCES)))
EXECUTABLE = launch
BUILD_DIR = build

all: $(SOURCES) ${INCLUDES} $(BUILD_DIR)/$(EXECUTABLE)

clean:
	-rm -fR $(BUILD_DIR) copy.gif
	
$(BUILD_DIR)/$(EXECUTABLE): $(OBJECTS) Makefile
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR):
	mkdir $@