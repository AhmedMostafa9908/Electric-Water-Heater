#include "stdint.h"
#ifndef __I2C_H
#define __I2C_H
#define _XTAL_FREQ 16000000 // Fosc
#define I2C_BaudRate 100000 // I2C Baud Rate = 100 Kbps
void I2C_Master_Init();
void I2C_Master_Wait();
void I2C_Master_Start();
void I2C_Master_RepeatedStart();
void I2C_Master_Stop();
void I2C_ACK();
void I2C_NACK();
void I2C_Master_Write(unsigned char Data);
unsigned char I2C_Read_Byte(void);
#endif