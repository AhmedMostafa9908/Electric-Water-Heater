#line 1 "C:/Users/future/Desktop/myproject/_7seg.c"
#line 1 "c:/users/future/desktop/myproject/_7seg.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 4 "c:/users/future/desktop/myproject/_7seg.h"
 void print_Number(int number);
 void Print_2digits_Number(uint16_t number);
#line 2 "C:/Users/future/Desktop/myproject/_7seg.c"
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
