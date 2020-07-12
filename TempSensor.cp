#line 1 "C:/Users/future/Desktop/myproject/TempSensor.c"
#line 1 "c:/users/future/desktop/myproject/tempsensor.h"
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
#line 5 "c:/users/future/desktop/myproject/tempsensor.h"
void ADC_Init();
uint16_t Read_Temp();
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"
#line 3 "C:/Users/future/Desktop/myproject/TempSensor.c"
void ADC_Init(){

ADCON0=0x51;

ADCON1=0x80;
}
uint16_t Read_Temp(){
 uint16_t result;
 delay_us(30);
GO_DONE_bit=1;
while(GO_DONE_bit==1);
result=(ADRESH<<8)+ADRESL;
 return result *.488;
}
