/*
 * File:   main.c
 * Author: Edwin Vans
 *
 * Created on October 15, 2023, 8:42 PM
 * 
 * Description: Simple 'Hello World' program to blink an LED connected to PIN D0
 */

#include <xc.h>

#define _XTAL_FREQ 32000000 // uC Crystal Frequency (32 MHz)

void main(void) {
    ANSELD = 0x00; // Set Port D to be digital
    TRISD = 0x00;  // Make Port D an output port
    
    while (1)
    {
        PORTDbits.RD0 = 1;  // Set PIN RD0 High  
        __delay_ms(500);    // Delay for 500 ms
        PORTDbits.RD0 = 0;  // Set PIN RD0 Low
        __delay_ms(500);    // Delay for 500 ms
    }
}