#include "_7seg.h"
void print_Number(int number){
char values[10]={0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
TRISB=0;
PORTB=values[number];
}

void Print_2digits_Number(uint16_t number){
   uint16_t ones;
   uint16_t tens;
   char values[10]={0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
    TRISD=0;
    ones=number%10;
    tens=number/10;
    PORTA|=0x10;
    PORTD=values[ones];
    delay_us(1500);
    PORTA=0;
    PORTA|=0x08;
    PORTD=values[tens];
    delay_us(1500);
    PORTA=0;
}