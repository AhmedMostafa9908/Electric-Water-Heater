#line 1 "C:/Users/future/Desktop/myproject/MyProject.c"
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
#line 1 "c:/users/future/desktop/myproject/tempsensor.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"
#line 5 "c:/users/future/desktop/myproject/tempsensor.h"
void ADC_Init();
uint16_t Read_Temp();
#line 1 "c:/users/future/desktop/myproject/eeprom.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"
#line 6 "c:/users/future/desktop/myproject/eeprom.h"
void EEPROM_Write(unsigned int add, unsigned char Data);
void EEPROM_Write_Page(unsigned int add, unsigned char* Data, unsigned char len);
unsigned char EEPROM_Read(unsigned int add);
void EEPROM_Read_Page(unsigned int add, unsigned char* Data, unsigned int len);
void EEPROM_Write_INT(unsigned int add, uint16_t Data);
uint16_t EEPROM_Read_INT(unsigned int add) ;
#line 1 "c:/users/future/desktop/myproject/i2c.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"
#line 6 "c:/users/future/desktop/myproject/i2c.h"
void I2C_Master_Init();
void I2C_Master_Wait();
void I2C_Master_Start();
void I2C_Master_RepeatedStart();
void I2C_Master_Stop();
void I2C_ACK();
void I2C_NACK();
void I2C_Master_Write(unsigned char Data);
unsigned char I2C_Read_Byte(void);
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"
#line 7 "C:/Users/future/Desktop/myproject/MyProject.c"
void main() {

 uint16_t Setting_temp;

 uint16_t temp;

 int count=0;
 int j;
 int i=0;
 int x=1;

 int On_Off_flag;

 I2C_Master_Init();
 ADC_Init();
 TRISC2_bit=0;
 TRISC5_bit=0;
 TRISA3_bit=0;
 TRISA4_bit=0;

 TRISB=0x07;







 On_Off_flag=0;



 EEPROM_Write_INT(0x4000, 60);


 while(1){

 if(PORTB ==0x06){



 if( On_Off_flag==0){
 Setting_temp=EEPROM_Read_INT(0x4000);

 delay_ms(300);
 while(1){



 while(Read_Temp()<(setting_temp+5)){
 count++;
 if(count>=10){
 count=0;
 PORTC=0;

 PORTC|=0x20;

 j=0;
 while(j<200){
 Print_2digits_Number(Read_Temp());
 PORTB=0;
 delay_ms(2);
 if(PORTB==0x05){
 x=0;
 break;}
 else if(PORTB==0x03){
 x=0;
 break;}
 else if(PORTB==0x06){
 x=0;
 break;}
 j++;
 }
 j=0;
 while(j<100){
 if(x==0){
 x=1;
 break;
 }
 Print_2digits_Number(Read_Temp());
 PORTB|=0x10;
 delay_ms(2);
 j++;
 }



 if(PORTB==0x06){
 On_Off_flag=1;
 break;}


 else if(PORTB==0x05){
 delay_ms(300);
 if(setting_temp<75){
 EEPROM_Write_INT(0x4000, setting_temp+5);
 setting_temp=EEPROM_Read_INT(0x4000);
 i=0;
 while(i<5){
 j=0;
 while(j<200){
 PORTA=0;
 delay_ms(2);
 if(PORTB==0x05){
 break;}
 else if(PORTB==0x03){
 break;}
 j++;
 }
 j=0;
 while(j<200){
 Print_2digits_Number(setting_temp);
 delay_ms(2);
 if(PORTB==0x05){
 break;}
 else if(PORTB==0x03){
 break;}
 j++;}
 i++;
 if(PORTB==0x05){
 break;}
 else if(PORTB==0x03){
 break;}
 }
 }}


 else if(PORTB==0x03){
 delay_ms(300);
 if(setting_temp>35){
 EEPROM_Write_INT(0x4000, setting_temp-5);
 setting_temp=EEPROM_Read_INT(0x4000);
 i=0;
 while(i<5){
 j=0;
 while(j<200){
 PORTA=0;
 delay_ms(2);
 if(PORTB==0x03){
 break;
 }
 else if(PORTB==0x05){
 break;}
 j++;
 }
 j=0;
 while(j<200){
 Print_2digits_Number(setting_temp);
 delay_ms(2);
 j++;
 if(PORTB==0x03){
 break;
 }
 else if(PORTB==0x05){
 break;}
 }
 i++;
 if(PORTB==0x03){
 break;
 }
 else if(PORTB==0x05){
 break;}
 }
 }}

 }}



 while(Read_Temp()>(setting_temp-5)){
 count++;
 if(count>=10){
 count=0;

 PORTC=0;
 PORTC|=0x04;

 PORTB|=0x10;
 Print_2digits_Number(Read_Temp());


 if(PORTB ==0x16){
 On_Off_flag=1;
 PORTB=0x00;
 break;}


 else if(PORTB==0x15){
 delay_ms(300);
 if(setting_temp<75){

 setting_temp=setting_temp+5;
 EEPROM_Write_INT(0x4000, setting_temp);
 i=0;
 while(i<5){
 j=0;
 while(j<200){
 PORTA=0;
 delay_ms(2);
 j++;
 if(PORTB==0x15){
 break;}
 else if(PORTB==0x13){
 break;}
 }
 j=0;
 while(j<200){
 Print_2digits_Number(setting_temp);
 delay_ms(2);
 j++;
 if(PORTB==0x15){
 break;}
 else if(PORTB==0x13){
 break;}
 }
 i++;
 if(PORTB==0x15){
 break;}
 else if(PORTB==0x13){
 break;}
 }
 }}


 else if(PORTB==0x13){
 delay_ms(300);
 if(setting_temp>35){
 setting_temp=setting_temp-5;
 EEPROM_Write_INT(0x4000, setting_temp);
 i=0;
 while(i<5){
 j=0;
 while(j<200){
 PORTA=0;
 delay_ms(2);
 j++;
 if(PORTB==0x15){
 break;}
 else if(PORTB==0x13){
 break;}
 }
 j=0;
 while(j<200){
 Print_2digits_Number(setting_temp);
 delay_ms(2);
 if(PORTB==0x15){
 break;}
 else if(PORTB==0x13){
 break;}
 j++;}
 i++;
 if(PORTB==0x15){
 break;}
 else if(PORTB==0x13){
 break;}
 }
 }}


 }}

 if(PORTB ==0x06){
 On_Off_flag=1;
 break;}

 }}


 else if( On_Off_flag=1){

 delay_ms(300);

 PORTB &=0x0F;

 PORTA &=0xE7;

 PORTC&=0xDB;
 On_Off_flag=0;
 }


 }}}
