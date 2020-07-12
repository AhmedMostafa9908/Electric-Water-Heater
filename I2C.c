#include "I2C.h"
#include "stdint.h"
void I2C_Master_Init()
{
TRISC3_bit=1;
TRISC4_bit=1;  // sets C3 & C4 as high impedence inputs
SSPADD=(_XTAL_FREQ/(4*100000)) - 1;    // value to make boud rate 100k bit/s
SSPCON=0x28;   // master mode , enable MSSP
SSPCON2 = 0x00;
SSPSTAT = 0x00;
}
void I2C_Master_Wait(){
 while ((SSPSTAT & 0x04) || (SSPCON2 & 0x1F));
}
void I2C_Master_Start(){
  I2C_Master_Wait();
  SEN_bit=1;   // Write 1 in SE

}
void I2C_Master_RepeatedStart(){

  RSEN_bit=1;      //Write 1 in RSEN
  I2C_Master_Wait();
}
void I2C_Master_Stop(){
 I2C_Master_Wait();
 PEN_bit=1;   // write 1 in PE

}
void I2C_ACK(){

  ACKDT_bit=0;     // the signal is ACk
  ACKEN_bit=1;     // send ACk
  I2C_Master_Wait();
}
void I2C_NACK(){

  ACKDT_bit=1;      // THe signal is NACk
  ACKEN_bit=1; //send NACK
  I2C_Master_Wait();
}
void I2C_Master_Write(unsigned char Data){
  I2C_Master_Wait();
  SSPBUF = Data;
  I2C_Master_Wait();  //to till me the slave recive the data and send Ack

}
unsigned char I2C_Read_Byte(void){
    RCEN_bit=1; // enable master recive
    while(!SSPIF_bit);   // Wait Until Completion
    SSPIF_bit = 0;
    I2C_NACK();       // Clear The Interrupt Flag Bit
    return SSPBUF;

}