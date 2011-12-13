TARGET = CarbonateJSON

CC = gcc
LD = $(CC)
CFLAGS = -isysroot /User/sysroot \
	 -std=gnu99 \
	 -Wall \
	 -I. \
	 -I.. \
	 -c
LDFLAGS = -isysroot /User/sysroot \
	  -w \
	  -dynamiclib \
	  -install_name /System/Library/Frameworks/$(TARGET).framework/$(TARGET) \
	  -lobjc \
	  -ljsonz \
	  -framework Foundation

OBJECTS = NSArray+CarbonateJSON.o NSDictionary+CarbonateJSON.o NSString+CarbonateJSON.o CJFunctions.o

all: $(TARGET)
	sudo cp $(TARGET) /System/Library/Frameworks/$(TARGET).framework/
	sudo cp $(TARGET) /User/sysroot/System/Library/Frameworks/$(TARGET).framework/

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJECTS)

%.o: %.m
	$(CC) $(CFLAGS) -o $@ $^

