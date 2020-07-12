#include "TempSensor.h"
#include "stdint.h"
void ADC_Init(){
// channel AN0 ,clock FOSC/8
ADCON0=0x51;
// Right justfication , clock FOSC/8  ,with analog channels AN0,AN1,AN3
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