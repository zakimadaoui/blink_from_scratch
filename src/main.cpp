#ifndef __AVR_ATmega328P__ //to get rid of  vscode linter errors (change this is MCU is changed)
#define __AVR_ATmega328P__ //to get rid of  vscode linter errors (change this is MCU is changed)
#endif
#include <avr/io.h>
#include <util/delay.h>
#include <stdbool.h>
#include "Arduino.h"

int main()
{

    // ================== PURE AVR ================
    //setup
    // DDRB |= 0b00100000;

    // //loop
    // while(true){
    //     PORTB |= 0b00100000;
    //     _delay_ms(3000);

    //     PORTB &= ~0b00100000;
    //     _delay_ms(3000);
    // }

    // ================== Arduino  ================

    pinMode(13, OUTPUT);
    while (1)
    {
        digitalWrite(13, 1);
        _delay_ms(500);
        digitalWrite(13, 0);
        _delay_ms(500);
    }
}