#line 1 "C:/Users/future/Desktop/myproject/EEPROM.c"
#line 1 "c:/users/future/desktop/myproject/eeprom.h"
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
#line 4 "C:/Users/future/Desktop/myproject/EEPROM.c"
void EEPROM_Write(unsigned int add, unsigned char Data){
 I2C_Master_Start();
 I2C_Master_Write( 0xA0 );
 I2C_Master_Write(add>>8);
 I2C_Master_Write((unsigned char)add);
 I2C_Master_Write(Data);
 I2C_Master_Stop();

}
void EEPROM_Write_Page(unsigned int add, unsigned char* Data, unsigned char len){
 int i;
 I2C_Master_Start();
 I2C_Master_Write( 0xA0 );

 I2C_Master_Write(add>>8);
 I2C_Master_Write((unsigned char)add);
 for(i=0;i<len;i++){
 I2C_Master_Write(Data[i]);
 }
 I2C_Master_Stop();
}

void EEPROM_Write_INT(unsigned int add, uint16_t Data){
 I2C_Master_Start();
 I2C_Master_Write( 0xA0 );
 I2C_Master_Write(add>>8);
 I2C_Master_Write((unsigned char)add);
 I2C_Master_Write(Data>>8);
 I2C_Master_Write((unsigned char)Data);
 I2C_Master_Stop();
}

unsigned char EEPROM_Read(unsigned int add){
 unsigned char Data;
 I2C_Master_Start();

 I2C_Master_Write( 0xA0 );
 I2C_Master_Write(add>>8);
 I2C_Master_Write((unsigned char)add);
 I2C_Master_RepeatedStart();
 I2C_Master_Write( 0xA1 );
 Data = I2C_Read_Byte();
 I2C_NACK();
 I2C_Master_Stop();
 return Data;
}



void EEPROM_Read_Page(unsigned int add, unsigned char* Data, unsigned int len){
 unsigned int i;
 I2C_Master_Start();

I2C_Master_Write( 0xA0 );

 I2C_Master_Write(add>>8);
 I2C_Master_Write((unsigned char)add);
 I2C_Master_RepeatedStart();
 I2C_Master_Write( 0xA1 );
 for(i=0; i<len; i++)
 {
 Data[i] = I2C_Read_Byte();
 I2C_ACK();
 }
 I2C_Master_Stop();
}
uint16_t EEPROM_Read_INT(unsigned int add){
 uint16_t Data;
 uint16_t Data2;
 I2C_Master_Start();
 I2C_Master_Write( 0xA0 );
 I2C_Master_Write(add>>8);
 I2C_Master_Write((unsigned char)add);
 I2C_Master_RepeatedStart();
 I2C_Master_Write( 0xA1 );
 Data=I2C_Read_Byte();
 I2C_ACK();
 Data2=I2C_Read_Byte();
 I2C_ACK();
 I2C_Master_Stop();
 return (Data<<8)+Data2;
}
