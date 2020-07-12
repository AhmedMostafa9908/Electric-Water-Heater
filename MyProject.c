#include "_7seg.h"
#include "TempSensor.h"
#include "EEPROM.h"
#include "I2C.h"
#include "stdint.h"

void main() {
         // This is the setting temp
         uint16_t Setting_temp;
         // This is current temp
         uint16_t temp;
         // This counter to count 10 times of temp saturation
 int count=0;
         int j;
         int i=0;
         int x=1;
         // In On_state the flag=0 & In Off_state the flag=1
         int On_Off_flag;
         //Iinitialization
         I2C_Master_Init();
         ADC_Init();
         TRISC2_bit=0;
         TRISC5_bit=0;
         TRISA3_bit=0;
         TRISA4_bit=0;

        TRISB=0x07;
         
         // ON/OFF button RB0
         // Up  button RB1
         // Down button RB2
         // we will use RB4 as Heating and cooling led

         // we will begin with off state so the flag will equal to 0 as when we click the button we go to on state
           On_Off_flag=0;

         // at begining the set temp=60 C
         //we will use address 0x4000 to store all setting temp
         EEPROM_Write_INT(0x4000, 60);
         
         
         while(1){

        if(PORTB ==0x06){
        // here we click on RB0

        // ON state
        if( On_Off_flag==0){
        Setting_temp=EEPROM_Read_INT(0x4000);
        // to make sure that I had removed my finger from the button
        delay_ms(300);
        while(1){


        //heating process
        while(Read_Temp()<(setting_temp+5)){
        count++;
        if(count>=10){
        count=0;
        PORTC=0;
        // heating element on
        PORTC|=0x20;
        //led blinking
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


        //Condition for going to off state
        if(PORTB==0x06){
        On_Off_flag=1;
        break;}
        
        //Up button is pressed
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
        
        //Down button is pressed
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


        // cooling process
        while(Read_Temp()>(setting_temp-5)){
        count++;
        if(count>=10){
        count=0;
        //Fan is On
        PORTC=0;
        PORTC|=0x04;
        // led is on
        PORTB|=0x10;
        Print_2digits_Number(Read_Temp());
        
        //Condition for going to off state
        if(PORTB ==0x16){
        On_Off_flag=1;
        PORTB=0x00;
         break;}
         
        //Up button is pressed
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

        //Down button is pressed
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
        //Condition for going to off state
        if(PORTB ==0x06){
        On_Off_flag=1;
        break;}

        }}
        
        // Off state
        else if( On_Off_flag=1){
        // to make sure that I had removed my finger from the button
        delay_ms(300);
        //Turning off led
        PORTB &=0x0F;
        //Turning off 7_seg
        PORTA &=0xE7;
        // Turning off fan & heating element
        PORTC&=0xDB;
         On_Off_flag=0;
        }
        
        
        }}}