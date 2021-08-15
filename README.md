# Blink an arduino from scratch (NO IDE)
If you're like me and would like to know what the Arduino IDE and PlatformIO do behind the scenes ?  
this repo documents how to write AVR code, compile it,link it and upload it to an atmega328p (on an Arduino Uno board) without the help of the Arduino IDE or similar.

During this process the following `toolchain` will be used:
- avr-libc (standard C libraries)
- avr-bin utils
- avr-gcc (C compiler for AVR MCUs) and avr-g++ (C++ compiler)
- avrdude (for uploading the code)
- make



