TARGET = HCJSON

CC = gcc
LD = $(CC)
CFLAGS = -isysroot /User/sysroot \
	 -Wall \
	 -I. \
	 -I.. \
	 -c \
	 -ffunction-sections -fdata-sections
LDFLAGS = -isysroot /User/sysroot \
	  -w \
	  -dynamiclib \
	  -fObjC \
	  -install_name /System/Library/Frameworks/$(TARGET).framework/$(TARGET) \
	  -lobjc \
	  -ljsonz \
	  -framework Foundation

OBJECTS = NSArray+HCJSON.o NSDictionary+HCJSON.o NSString+HCJSON.o HCJFunctions.o

all: $(TARGET)
	sudo cp $(TARGET) /System/Library/Frameworks/$(TARGET).framework/
	sudo cp $(TARGET) /User/sysroot/System/Library/Frameworks/$(TARGET).framework/

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJECTS)

static: $(OBJECTS)
	ar rcsv HCJSON.a $^

clean:
	rm *.o

%.o: %.m
	$(CC) $(CFLAGS) -o $@ $^
