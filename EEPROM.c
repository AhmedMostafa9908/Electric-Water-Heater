#include "EEPROM.h"
#include "I2C.h"
#include "stdint.h"
void EEPROM_Write(unsigned int add, unsigned char Data){
     I2C_Master_Start();
     I2C_Master_Write(EEPROM_Address_W);
     I2C_Master_Write(add>>8);
     I2C_Master_Write((unsigned char)add);
     I2C_Master_Write(Data);
     I2C_Master_Stop();

}
void EEPROM_Write_Page(unsigned int add, unsigned char* Data, unsigned char len){
     int i;
     I2C_Master_Start();
     I2C_Master_Write(EEPROM_Address_W);

     I2C_Master_Write(add>>8);
     I2C_Master_Write((unsigned char)add);
     for(i=0;i<len;i++){
       I2C_Master_Write(Data[i]);
     }
     I2C_Master_Stop();
}

void EEPROM_Write_INT(unsigned int add, uint16_t Data){
  I2C_Master_Start();
     I2C_Master_Write(EEPROM_Address_W);
      I2C_Master_Write(add>>8);
     I2C_Master_Write((unsigned char)add);
      I2C_Master_Write(Data>>8);
     I2C_Master_Write((unsigned char)Data);
     I2C_Master_Stop();
}

unsigned char EEPROM_Read(unsigned int add){
   unsigned char Data;
  I2C_Master_Start();
  // Wait Until EEPROM Is IDLE
  I2C_Master_Write(EEPROM_Address_W);
 I2C_Master_Write(add>>8);
  I2C_Master_Write((unsigned char)add);
  I2C_Master_RepeatedStart();
  I2C_Master_Write(EEPROM_Address_R);
  Data = I2C_Read_Byte();
  I2C_NACK();
  I2C_Master_Stop();
  return Data;
}



void EEPROM_Read_Page(unsigned int add, unsigned char* Data, unsigned int len){
    unsigned int i;
    I2C_Master_Start();
  // Wait Until EEPROM Is IDLE
I2C_Master_Write(EEPROM_Address_W);

  I2C_Master_Write(add>>8);
  I2C_Master_Write((unsigned char)add);
  I2C_Master_RepeatedStart();
  I2C_Master_Write(EEPROM_Address_R);
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
 I2C_Master_Write(EEPROM_Address_W);
 I2C_Master_Write(add>>8);
 I2C_Master_Write((unsigned char)add);
 I2C_Master_RepeatedStart();
 I2C_Master_Write(EEPROM_Address_R);
 Data=I2C_Read_Byte();
 I2C_ACK();
 Data2=I2C_Read_Byte();
 I2C_ACK();
 I2C_Master_Stop();
 return (Data<<8)+Data2;
}

