 #include "stdint.h"
#ifndef __EEPROM_H
#define __EEPROM_H
#define EEPROM_Address_R 0xA1
#define EEPROM_Address_W 0xA0
void EEPROM_Write(unsigned int add, unsigned char Data);
void EEPROM_Write_Page(unsigned int add, unsigned char* Data, unsigned char len);
unsigned char EEPROM_Read(unsigned int add);
void EEPROM_Read_Page(unsigned int add, unsigned char* Data, unsigned int len);
void EEPROM_Write_INT(unsigned int add, uint16_t Data);
uint16_t EEPROM_Read_INT(unsigned int add) ;
#endif