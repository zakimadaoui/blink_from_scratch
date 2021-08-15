# paths
ArduinoPath1=/usr/local/arduino/cores/arduino
ArduinoPath2=/usr/local/arduino/variants/standard 
hexPath=hex
objPath=obj
srcPath=src

#complier flags: 
#			-I'./include' for telling the compiler where to find the header files
CC=avr-gcc
CXX=avr-g++
CXXFLAGS=  -Os -DF_CPU=16000000UL -mmcu=atmega328p -I$(ArduinoPath1) -I$(ArduinoPath2)

# find the name+path of all needed c files 
srcFiles=$(wildcard ${srcPath}/*.cpp) 
ArduinoCFiles=$(wildcard ${ArduinoPath1}/*.c)
ArduinoCXXFiles=$(wildcard ${ArduinoPath1}/*.cpp)
ArduinoASMFiles=$(wildcard ${ArduinoPath1}/*.S)
# generate the names+path of all object files from the c and cpp files generated in the prev variables
OBJS=$(patsubst $(srcPath)/%.cpp, $(objPath)/%.cpp.o, $(srcFiles))
OBJS+=$(patsubst $(ArduinoPath1)/%.cpp, $(objPath)/%.cpp.o, $(ArduinoCXXFiles))
OBJS+=$(patsubst $(ArduinoPath1)/%.c, $(objPath)/%.c.o, $(ArduinoCFiles))
OBJS+=$(patsubst $(ArduinoPath1)/%.S, $(objPath)/%.S.o, $(ArduinoASMFiles))


# MCU config
baudrate=9600
uploadBaudRate=115200
ttyDevice=/dev/ttyACM0

all: compile_link
# all: main.hex

upload.%: %.hex
	avrdude -F -V -p m328p -c arduino -b $(uploadBaudRate) -P $(ttyDevice) -U flash:w:${hexPath}/$^

%.hex: compile_link
	avr-objcopy -O ihex -R .eeprom $(objPath)/main.out $(hexPath)/$@

compile_link: $(OBJS)
	echo linking...
	$(CXX) $(CXXFLAGS) $^ -o $(objPath)/main.out
	

# Rules for .cpp.o files for .cpp files in the src folder
${objPath}/%.cpp.o: $(srcPath)/%.cpp
	echo "compiling form $< to $@"
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Rules for .cpp.o files for arduino .cpp files
${objPath}/%.cpp.o: $(ArduinoPath1)/%.cpp
	echo "compiling form $< to $@"
	$(CXX) $(CXXFLAGS) -c $< -o $@
	
# Rules for .c.o files for arduino .c files
${objPath}/%.c.o: $(ArduinoPath1)/%.c 
	echo "compiling form $< to $@"
	$(CC) $(CXXFLAGS) -c $< -o $@
	
# Rules for .S.o files for arduino assembly '.S' files
${objPath}/%.S.o: $(ArduinoPath1)/%.S 
	echo "compiling form $< to $@"
	$(CC) $(CXXFLAGS) -c $< -o $@
	


clean:
	rm -r $(objPath)/* $(hexPath)/* 

printPaths:
	echo $(OBJS)

