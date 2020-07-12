#line 1 "C:/Users/future/Desktop/myproject/I2C.c"
#line 1 "c:/users/future/desktop/myproject/i2c.h"
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
#line 3 "C:/Users/future/Desktop/myproject/I2C.c"
void I2C_Master_Init()
{
TRISC3_bit=1;
TRISC4_bit=1;
SSPADD=( 16000000 /(4*100000)) - 1;
SSPCON=0x28;
SSPCON2 = 0x00;
SSPSTAT = 0x00;
}
void I2C_Master_Wait(){
 while ((SSPSTAT & 0x04) || (SSPCON2 & 0x1F));
}
void I2C_Master_Start(){
 I2C_Master_Wait();
 SEN_bit=1;

}
void I2C_Master_RepeatedStart(){

 RSEN_bit=1;
 I2C_Master_Wait();
}
void I2C_Master_Stop(){
 I2C_Master_Wait();
 PEN_bit=1;

}
void I2C_ACK(){

 ACKDT_bit=0;
 ACKEN_bit=1;
 I2C_Master_Wait();
}
void I2C_NACK(){

 ACKDT_bit=1;
 ACKEN_bit=1;
 I2C_Master_Wait();
}
void I2C_Master_Write(unsigned char Data){
 I2C_Master_Wait();
 SSPBUF = Data;
 I2C_Master_Wait();

}
unsigned char I2C_Read_Byte(void){
 RCEN_bit=1;
 while(!SSPIF_bit);
 SSPIF_bit = 0;
 I2C_NACK();
 return SSPBUF;

}
