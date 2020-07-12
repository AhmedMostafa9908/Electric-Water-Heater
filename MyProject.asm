
_main:

;MyProject.c,7 :: 		void main() {
;MyProject.c,13 :: 		int count=0;
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
	MOVLW      1
	MOVWF      main_x_L0+0
	MOVLW      0
	MOVWF      main_x_L0+1
;MyProject.c,20 :: 		I2C_Master_Init();
	CALL       _I2C_Master_Init+0
;MyProject.c,21 :: 		ADC_Init();
	CALL       _ADC_Init+0
;MyProject.c,22 :: 		TRISC2_bit=0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;MyProject.c,23 :: 		TRISC5_bit=0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;MyProject.c,24 :: 		TRISA3_bit=0;
	BCF        TRISA3_bit+0, BitPos(TRISA3_bit+0)
;MyProject.c,25 :: 		TRISA4_bit=0;
	BCF        TRISA4_bit+0, BitPos(TRISA4_bit+0)
;MyProject.c,27 :: 		TRISB=0x07;
	MOVLW      7
	MOVWF      TRISB+0
;MyProject.c,35 :: 		On_Off_flag=0;
	CLRF       main_On_Off_flag_L0+0
	CLRF       main_On_Off_flag_L0+1
;MyProject.c,39 :: 		EEPROM_Write_INT(0x4000, 60);
	MOVLW      0
	MOVWF      FARG_EEPROM_Write_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Write_INT_add+1
	MOVLW      60
	MOVWF      FARG_EEPROM_Write_INT_Data+0
	MOVLW      0
	MOVWF      FARG_EEPROM_Write_INT_Data+1
	CALL       _EEPROM_Write_INT+0
;MyProject.c,42 :: 		while(1){
L_main0:
;MyProject.c,44 :: 		if(PORTB ==0x06){
	MOVF       PORTB+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;MyProject.c,48 :: 		if( On_Off_flag==0){
	MOVLW      0
	XORWF      main_On_Off_flag_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main116
	MOVLW      0
	XORWF      main_On_Off_flag_L0+0, 0
L__main116:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;MyProject.c,49 :: 		Setting_temp=EEPROM_Read_INT(0x4000);
	MOVLW      0
	MOVWF      FARG_EEPROM_Read_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Read_INT_add+1
	CALL       _EEPROM_Read_INT+0
	MOVF       R0+0, 0
	MOVWF      main_Setting_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_Setting_temp_L0+1
;MyProject.c,51 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;MyProject.c,52 :: 		while(1){
L_main5:
;MyProject.c,56 :: 		while(Read_Temp()<(setting_temp+5)){
L_main7:
	CALL       _Read_Temp+0
	MOVLW      5
	ADDWF      main_Setting_temp_L0+0, 0
	MOVWF      R3+0
	MOVF       main_Setting_temp_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R3+1
	MOVF       R3+1, 0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main117
	MOVF       R3+0, 0
	SUBWF      R0+0, 0
L__main117:
	BTFSC      STATUS+0, 0
	GOTO       L_main8
;MyProject.c,57 :: 		count++;
	INCF       main_count_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_count_L0+1, 1
;MyProject.c,58 :: 		if(count>=10){
	MOVLW      128
	XORWF      main_count_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main118
	MOVLW      10
	SUBWF      main_count_L0+0, 0
L__main118:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
;MyProject.c,59 :: 		count=0;
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
;MyProject.c,60 :: 		PORTC=0;
	CLRF       PORTC+0
;MyProject.c,62 :: 		PORTC|=0x20;
	BSF        PORTC+0, 5
;MyProject.c,64 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,65 :: 		while(j<200){
L_main10:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main119
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main119:
	BTFSC      STATUS+0, 0
	GOTO       L_main11
;MyProject.c,66 :: 		Print_2digits_Number(Read_Temp());
	CALL       _Read_Temp+0
	MOVF       R0+0, 0
	MOVWF      FARG_Print_2digits_Number_number+0
	MOVF       R0+1, 0
	MOVWF      FARG_Print_2digits_Number_number+1
	CALL       _Print_2digits_Number+0
;MyProject.c,67 :: 		PORTB=0;
	CLRF       PORTB+0
;MyProject.c,68 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	NOP
;MyProject.c,69 :: 		if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;MyProject.c,70 :: 		x=0;
	CLRF       main_x_L0+0
	CLRF       main_x_L0+1
;MyProject.c,71 :: 		break;}
	GOTO       L_main11
L_main13:
;MyProject.c,72 :: 		else if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;MyProject.c,73 :: 		x=0;
	CLRF       main_x_L0+0
	CLRF       main_x_L0+1
;MyProject.c,74 :: 		break;}
	GOTO       L_main11
L_main15:
;MyProject.c,75 :: 		else if(PORTB==0x06){
	MOVF       PORTB+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;MyProject.c,76 :: 		x=0;
	CLRF       main_x_L0+0
	CLRF       main_x_L0+1
;MyProject.c,77 :: 		break;}
	GOTO       L_main11
L_main17:
;MyProject.c,78 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,79 :: 		}
	GOTO       L_main10
L_main11:
;MyProject.c,80 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,81 :: 		while(j<100){
L_main18:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main120
	MOVLW      100
	SUBWF      main_j_L0+0, 0
L__main120:
	BTFSC      STATUS+0, 0
	GOTO       L_main19
;MyProject.c,82 :: 		if(x==0){
	MOVLW      0
	XORWF      main_x_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main121
	MOVLW      0
	XORWF      main_x_L0+0, 0
L__main121:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;MyProject.c,83 :: 		x=1;
	MOVLW      1
	MOVWF      main_x_L0+0
	MOVLW      0
	MOVWF      main_x_L0+1
;MyProject.c,84 :: 		break;
	GOTO       L_main19
;MyProject.c,85 :: 		}
L_main20:
;MyProject.c,86 :: 		Print_2digits_Number(Read_Temp());
	CALL       _Read_Temp+0
	MOVF       R0+0, 0
	MOVWF      FARG_Print_2digits_Number_number+0
	MOVF       R0+1, 0
	MOVWF      FARG_Print_2digits_Number_number+1
	CALL       _Print_2digits_Number+0
;MyProject.c,87 :: 		PORTB|=0x10;
	BSF        PORTB+0, 4
;MyProject.c,88 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	NOP
;MyProject.c,89 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,90 :: 		}
	GOTO       L_main18
L_main19:
;MyProject.c,94 :: 		if(PORTB==0x06){
	MOVF       PORTB+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;MyProject.c,95 :: 		On_Off_flag=1;
	MOVLW      1
	MOVWF      main_On_Off_flag_L0+0
	MOVLW      0
	MOVWF      main_On_Off_flag_L0+1
;MyProject.c,96 :: 		break;}
	GOTO       L_main8
L_main22:
;MyProject.c,99 :: 		else if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;MyProject.c,100 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
	NOP
;MyProject.c,101 :: 		if(setting_temp<75){
	MOVLW      0
	SUBWF      main_Setting_temp_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main122
	MOVLW      75
	SUBWF      main_Setting_temp_L0+0, 0
L__main122:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;MyProject.c,102 :: 		EEPROM_Write_INT(0x4000, setting_temp+5);
	MOVLW      0
	MOVWF      FARG_EEPROM_Write_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Write_INT_add+1
	MOVLW      5
	ADDWF      main_Setting_temp_L0+0, 0
	MOVWF      FARG_EEPROM_Write_INT_Data+0
	MOVF       main_Setting_temp_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_EEPROM_Write_INT_Data+1
	CALL       _EEPROM_Write_INT+0
;MyProject.c,103 :: 		setting_temp=EEPROM_Read_INT(0x4000);
	MOVLW      0
	MOVWF      FARG_EEPROM_Read_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Read_INT_add+1
	CALL       _EEPROM_Read_INT+0
	MOVF       R0+0, 0
	MOVWF      main_Setting_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_Setting_temp_L0+1
;MyProject.c,104 :: 		i=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;MyProject.c,105 :: 		while(i<5){
L_main27:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main123
	MOVLW      5
	SUBWF      main_i_L0+0, 0
L__main123:
	BTFSC      STATUS+0, 0
	GOTO       L_main28
;MyProject.c,106 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,107 :: 		while(j<200){
L_main29:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main124
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main124:
	BTFSC      STATUS+0, 0
	GOTO       L_main30
;MyProject.c,108 :: 		PORTA=0;
	CLRF       PORTA+0
;MyProject.c,109 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	NOP
;MyProject.c,110 :: 		if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main32
;MyProject.c,111 :: 		break;}
	GOTO       L_main30
L_main32:
;MyProject.c,112 :: 		else if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;MyProject.c,113 :: 		break;}
	GOTO       L_main30
L_main34:
;MyProject.c,114 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,115 :: 		}
	GOTO       L_main29
L_main30:
;MyProject.c,116 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,117 :: 		while(j<200){
L_main35:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main125
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main125:
	BTFSC      STATUS+0, 0
	GOTO       L_main36
;MyProject.c,118 :: 		Print_2digits_Number(setting_temp);
	MOVF       main_Setting_temp_L0+0, 0
	MOVWF      FARG_Print_2digits_Number_number+0
	MOVF       main_Setting_temp_L0+1, 0
	MOVWF      FARG_Print_2digits_Number_number+1
	CALL       _Print_2digits_Number+0
;MyProject.c,119 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	NOP
;MyProject.c,120 :: 		if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main38
;MyProject.c,121 :: 		break;}
	GOTO       L_main36
L_main38:
;MyProject.c,122 :: 		else if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main40
;MyProject.c,123 :: 		break;}
	GOTO       L_main36
L_main40:
;MyProject.c,124 :: 		j++;}
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
	GOTO       L_main35
L_main36:
;MyProject.c,125 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;MyProject.c,126 :: 		if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main41
;MyProject.c,127 :: 		break;}
	GOTO       L_main28
L_main41:
;MyProject.c,128 :: 		else if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main43
;MyProject.c,129 :: 		break;}
	GOTO       L_main28
L_main43:
;MyProject.c,130 :: 		}
	GOTO       L_main27
L_main28:
;MyProject.c,131 :: 		}}
L_main26:
	GOTO       L_main44
L_main24:
;MyProject.c,134 :: 		else if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main45
;MyProject.c,135 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	DECFSZ     R11+0, 1
	GOTO       L_main46
	NOP
	NOP
;MyProject.c,136 :: 		if(setting_temp>35){
	MOVF       main_Setting_temp_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main126
	MOVF       main_Setting_temp_L0+0, 0
	SUBLW      35
L__main126:
	BTFSC      STATUS+0, 0
	GOTO       L_main47
;MyProject.c,137 :: 		EEPROM_Write_INT(0x4000, setting_temp-5);
	MOVLW      0
	MOVWF      FARG_EEPROM_Write_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Write_INT_add+1
	MOVLW      5
	SUBWF      main_Setting_temp_L0+0, 0
	MOVWF      FARG_EEPROM_Write_INT_Data+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      main_Setting_temp_L0+1, 0
	MOVWF      FARG_EEPROM_Write_INT_Data+1
	CALL       _EEPROM_Write_INT+0
;MyProject.c,138 :: 		setting_temp=EEPROM_Read_INT(0x4000);
	MOVLW      0
	MOVWF      FARG_EEPROM_Read_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Read_INT_add+1
	CALL       _EEPROM_Read_INT+0
	MOVF       R0+0, 0
	MOVWF      main_Setting_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_Setting_temp_L0+1
;MyProject.c,139 :: 		i=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;MyProject.c,140 :: 		while(i<5){
L_main48:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main127
	MOVLW      5
	SUBWF      main_i_L0+0, 0
L__main127:
	BTFSC      STATUS+0, 0
	GOTO       L_main49
;MyProject.c,141 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,142 :: 		while(j<200){
L_main50:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main128
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main128:
	BTFSC      STATUS+0, 0
	GOTO       L_main51
;MyProject.c,143 :: 		PORTA=0;
	CLRF       PORTA+0
;MyProject.c,144 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main52:
	DECFSZ     R13+0, 1
	GOTO       L_main52
	DECFSZ     R12+0, 1
	GOTO       L_main52
	NOP
;MyProject.c,145 :: 		if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main53
;MyProject.c,146 :: 		break;
	GOTO       L_main51
;MyProject.c,147 :: 		}
L_main53:
;MyProject.c,148 :: 		else if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main55
;MyProject.c,149 :: 		break;}
	GOTO       L_main51
L_main55:
;MyProject.c,150 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,151 :: 		}
	GOTO       L_main50
L_main51:
;MyProject.c,152 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,153 :: 		while(j<200){
L_main56:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main129
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main129:
	BTFSC      STATUS+0, 0
	GOTO       L_main57
;MyProject.c,154 :: 		Print_2digits_Number(setting_temp);
	MOVF       main_Setting_temp_L0+0, 0
	MOVWF      FARG_Print_2digits_Number_number+0
	MOVF       main_Setting_temp_L0+1, 0
	MOVWF      FARG_Print_2digits_Number_number+1
	CALL       _Print_2digits_Number+0
;MyProject.c,155 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main58:
	DECFSZ     R13+0, 1
	GOTO       L_main58
	DECFSZ     R12+0, 1
	GOTO       L_main58
	NOP
;MyProject.c,156 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,157 :: 		if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main59
;MyProject.c,158 :: 		break;
	GOTO       L_main57
;MyProject.c,159 :: 		}
L_main59:
;MyProject.c,160 :: 		else if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main61
;MyProject.c,161 :: 		break;}
	GOTO       L_main57
L_main61:
;MyProject.c,162 :: 		}
	GOTO       L_main56
L_main57:
;MyProject.c,163 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;MyProject.c,164 :: 		if(PORTB==0x03){
	MOVF       PORTB+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main62
;MyProject.c,165 :: 		break;
	GOTO       L_main49
;MyProject.c,166 :: 		}
L_main62:
;MyProject.c,167 :: 		else if(PORTB==0x05){
	MOVF       PORTB+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main64
;MyProject.c,168 :: 		break;}
	GOTO       L_main49
L_main64:
;MyProject.c,169 :: 		}
	GOTO       L_main48
L_main49:
;MyProject.c,170 :: 		}}
L_main47:
L_main45:
L_main44:
;MyProject.c,172 :: 		}}
L_main9:
	GOTO       L_main7
L_main8:
;MyProject.c,176 :: 		while(Read_Temp()>(setting_temp-5)){
L_main65:
	CALL       _Read_Temp+0
	MOVLW      5
	SUBWF      main_Setting_temp_L0+0, 0
	MOVWF      R3+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      main_Setting_temp_L0+1, 0
	MOVWF      R3+1
	MOVF       R0+1, 0
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main130
	MOVF       R0+0, 0
	SUBWF      R3+0, 0
L__main130:
	BTFSC      STATUS+0, 0
	GOTO       L_main66
;MyProject.c,177 :: 		count++;
	INCF       main_count_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_count_L0+1, 1
;MyProject.c,178 :: 		if(count>=10){
	MOVLW      128
	XORWF      main_count_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main131
	MOVLW      10
	SUBWF      main_count_L0+0, 0
L__main131:
	BTFSS      STATUS+0, 0
	GOTO       L_main67
;MyProject.c,179 :: 		count=0;
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
;MyProject.c,181 :: 		PORTC=0;
	CLRF       PORTC+0
;MyProject.c,182 :: 		PORTC|=0x04;
	BSF        PORTC+0, 2
;MyProject.c,184 :: 		PORTB|=0x10;
	BSF        PORTB+0, 4
;MyProject.c,185 :: 		Print_2digits_Number(Read_Temp());
	CALL       _Read_Temp+0
	MOVF       R0+0, 0
	MOVWF      FARG_Print_2digits_Number_number+0
	MOVF       R0+1, 0
	MOVWF      FARG_Print_2digits_Number_number+1
	CALL       _Print_2digits_Number+0
;MyProject.c,188 :: 		if(PORTB ==0x16){
	MOVF       PORTB+0, 0
	XORLW      22
	BTFSS      STATUS+0, 2
	GOTO       L_main68
;MyProject.c,189 :: 		On_Off_flag=1;
	MOVLW      1
	MOVWF      main_On_Off_flag_L0+0
	MOVLW      0
	MOVWF      main_On_Off_flag_L0+1
;MyProject.c,190 :: 		PORTB=0x00;
	CLRF       PORTB+0
;MyProject.c,191 :: 		break;}
	GOTO       L_main66
L_main68:
;MyProject.c,194 :: 		else if(PORTB==0x15){
	MOVF       PORTB+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main70
;MyProject.c,195 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main71:
	DECFSZ     R13+0, 1
	GOTO       L_main71
	DECFSZ     R12+0, 1
	GOTO       L_main71
	DECFSZ     R11+0, 1
	GOTO       L_main71
	NOP
	NOP
;MyProject.c,196 :: 		if(setting_temp<75){
	MOVLW      0
	SUBWF      main_Setting_temp_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main132
	MOVLW      75
	SUBWF      main_Setting_temp_L0+0, 0
L__main132:
	BTFSC      STATUS+0, 0
	GOTO       L_main72
;MyProject.c,198 :: 		setting_temp=setting_temp+5;
	MOVLW      5
	ADDWF      main_Setting_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       main_Setting_temp_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_Setting_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_Setting_temp_L0+1
;MyProject.c,199 :: 		EEPROM_Write_INT(0x4000, setting_temp);
	MOVLW      0
	MOVWF      FARG_EEPROM_Write_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Write_INT_add+1
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_INT_Data+0
	MOVF       R0+1, 0
	MOVWF      FARG_EEPROM_Write_INT_Data+1
	CALL       _EEPROM_Write_INT+0
;MyProject.c,200 :: 		i=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;MyProject.c,201 :: 		while(i<5){
L_main73:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main133
	MOVLW      5
	SUBWF      main_i_L0+0, 0
L__main133:
	BTFSC      STATUS+0, 0
	GOTO       L_main74
;MyProject.c,202 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,203 :: 		while(j<200){
L_main75:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main134
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main134:
	BTFSC      STATUS+0, 0
	GOTO       L_main76
;MyProject.c,204 :: 		PORTA=0;
	CLRF       PORTA+0
;MyProject.c,205 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main77:
	DECFSZ     R13+0, 1
	GOTO       L_main77
	DECFSZ     R12+0, 1
	GOTO       L_main77
	NOP
;MyProject.c,206 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,207 :: 		if(PORTB==0x15){
	MOVF       PORTB+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main78
;MyProject.c,208 :: 		break;}
	GOTO       L_main76
L_main78:
;MyProject.c,209 :: 		else if(PORTB==0x13){
	MOVF       PORTB+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L_main80
;MyProject.c,210 :: 		break;}
	GOTO       L_main76
L_main80:
;MyProject.c,211 :: 		}
	GOTO       L_main75
L_main76:
;MyProject.c,212 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,213 :: 		while(j<200){
L_main81:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main135
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main135:
	BTFSC      STATUS+0, 0
	GOTO       L_main82
;MyProject.c,214 :: 		Print_2digits_Number(setting_temp);
	MOVF       main_Setting_temp_L0+0, 0
	MOVWF      FARG_Print_2digits_Number_number+0
	MOVF       main_Setting_temp_L0+1, 0
	MOVWF      FARG_Print_2digits_Number_number+1
	CALL       _Print_2digits_Number+0
;MyProject.c,215 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main83:
	DECFSZ     R13+0, 1
	GOTO       L_main83
	DECFSZ     R12+0, 1
	GOTO       L_main83
	NOP
;MyProject.c,216 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,217 :: 		if(PORTB==0x15){
	MOVF       PORTB+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main84
;MyProject.c,218 :: 		break;}
	GOTO       L_main82
L_main84:
;MyProject.c,219 :: 		else if(PORTB==0x13){
	MOVF       PORTB+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L_main86
;MyProject.c,220 :: 		break;}
	GOTO       L_main82
L_main86:
;MyProject.c,221 :: 		}
	GOTO       L_main81
L_main82:
;MyProject.c,222 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;MyProject.c,223 :: 		if(PORTB==0x15){
	MOVF       PORTB+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main87
;MyProject.c,224 :: 		break;}
	GOTO       L_main74
L_main87:
;MyProject.c,225 :: 		else if(PORTB==0x13){
	MOVF       PORTB+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L_main89
;MyProject.c,226 :: 		break;}
	GOTO       L_main74
L_main89:
;MyProject.c,227 :: 		}
	GOTO       L_main73
L_main74:
;MyProject.c,228 :: 		}}
L_main72:
	GOTO       L_main90
L_main70:
;MyProject.c,231 :: 		else if(PORTB==0x13){
	MOVF       PORTB+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L_main91
;MyProject.c,232 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main92:
	DECFSZ     R13+0, 1
	GOTO       L_main92
	DECFSZ     R12+0, 1
	GOTO       L_main92
	DECFSZ     R11+0, 1
	GOTO       L_main92
	NOP
	NOP
;MyProject.c,233 :: 		if(setting_temp>35){
	MOVF       main_Setting_temp_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main136
	MOVF       main_Setting_temp_L0+0, 0
	SUBLW      35
L__main136:
	BTFSC      STATUS+0, 0
	GOTO       L_main93
;MyProject.c,234 :: 		setting_temp=setting_temp-5;
	MOVLW      5
	SUBWF      main_Setting_temp_L0+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      main_Setting_temp_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_Setting_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_Setting_temp_L0+1
;MyProject.c,235 :: 		EEPROM_Write_INT(0x4000, setting_temp);
	MOVLW      0
	MOVWF      FARG_EEPROM_Write_INT_add+0
	MOVLW      64
	MOVWF      FARG_EEPROM_Write_INT_add+1
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_INT_Data+0
	MOVF       R0+1, 0
	MOVWF      FARG_EEPROM_Write_INT_Data+1
	CALL       _EEPROM_Write_INT+0
;MyProject.c,236 :: 		i=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;MyProject.c,237 :: 		while(i<5){
L_main94:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main137
	MOVLW      5
	SUBWF      main_i_L0+0, 0
L__main137:
	BTFSC      STATUS+0, 0
	GOTO       L_main95
;MyProject.c,238 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,239 :: 		while(j<200){
L_main96:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main138
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main138:
	BTFSC      STATUS+0, 0
	GOTO       L_main97
;MyProject.c,240 :: 		PORTA=0;
	CLRF       PORTA+0
;MyProject.c,241 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main98:
	DECFSZ     R13+0, 1
	GOTO       L_main98
	DECFSZ     R12+0, 1
	GOTO       L_main98
	NOP
;MyProject.c,242 :: 		j++;
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,243 :: 		if(PORTB==0x15){
	MOVF       PORTB+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main99
;MyProject.c,244 :: 		break;}
	GOTO       L_main97
L_main99:
;MyProject.c,245 :: 		else if(PORTB==0x13){
	MOVF       PORTB+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L_main101
;MyProject.c,246 :: 		break;}
	GOTO       L_main97
L_main101:
;MyProject.c,247 :: 		}
	GOTO       L_main96
L_main97:
;MyProject.c,248 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,249 :: 		while(j<200){
L_main102:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main139
	MOVLW      200
	SUBWF      main_j_L0+0, 0
L__main139:
	BTFSC      STATUS+0, 0
	GOTO       L_main103
;MyProject.c,250 :: 		Print_2digits_Number(setting_temp);
	MOVF       main_Setting_temp_L0+0, 0
	MOVWF      FARG_Print_2digits_Number_number+0
	MOVF       main_Setting_temp_L0+1, 0
	MOVWF      FARG_Print_2digits_Number_number+1
	CALL       _Print_2digits_Number+0
;MyProject.c,251 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main104:
	DECFSZ     R13+0, 1
	GOTO       L_main104
	DECFSZ     R12+0, 1
	GOTO       L_main104
	NOP
;MyProject.c,252 :: 		if(PORTB==0x15){
	MOVF       PORTB+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main105
;MyProject.c,253 :: 		break;}
	GOTO       L_main103
L_main105:
;MyProject.c,254 :: 		else if(PORTB==0x13){
	MOVF       PORTB+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L_main107
;MyProject.c,255 :: 		break;}
	GOTO       L_main103
L_main107:
;MyProject.c,256 :: 		j++;}
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
	GOTO       L_main102
L_main103:
;MyProject.c,257 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;MyProject.c,258 :: 		if(PORTB==0x15){
	MOVF       PORTB+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_main108
;MyProject.c,259 :: 		break;}
	GOTO       L_main95
L_main108:
;MyProject.c,260 :: 		else if(PORTB==0x13){
	MOVF       PORTB+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L_main110
;MyProject.c,261 :: 		break;}
	GOTO       L_main95
L_main110:
;MyProject.c,262 :: 		}
	GOTO       L_main94
L_main95:
;MyProject.c,263 :: 		}}
L_main93:
L_main91:
L_main90:
;MyProject.c,266 :: 		}}
L_main67:
	GOTO       L_main65
L_main66:
;MyProject.c,268 :: 		if(PORTB ==0x06){
	MOVF       PORTB+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_main111
;MyProject.c,269 :: 		On_Off_flag=1;
	MOVLW      1
	MOVWF      main_On_Off_flag_L0+0
	MOVLW      0
	MOVWF      main_On_Off_flag_L0+1
;MyProject.c,270 :: 		break;}
	GOTO       L_main6
L_main111:
;MyProject.c,272 :: 		}}
	GOTO       L_main5
L_main6:
	GOTO       L_main112
L_main3:
;MyProject.c,275 :: 		else if( On_Off_flag=1){
	MOVLW      1
	MOVWF      main_On_Off_flag_L0+0
	MOVLW      0
	MOVWF      main_On_Off_flag_L0+1
;MyProject.c,277 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main114:
	DECFSZ     R13+0, 1
	GOTO       L_main114
	DECFSZ     R12+0, 1
	GOTO       L_main114
	DECFSZ     R11+0, 1
	GOTO       L_main114
	NOP
	NOP
;MyProject.c,279 :: 		PORTB &=0x0F;
	MOVLW      15
	ANDWF      PORTB+0, 1
;MyProject.c,281 :: 		PORTA &=0xE7;
	MOVLW      231
	ANDWF      PORTA+0, 1
;MyProject.c,283 :: 		PORTC&=0xDB;
	MOVLW      219
	ANDWF      PORTC+0, 1
;MyProject.c,284 :: 		On_Off_flag=0;
	CLRF       main_On_Off_flag_L0+0
	CLRF       main_On_Off_flag_L0+1
;MyProject.c,285 :: 		}
L_main112:
;MyProject.c,288 :: 		}}}
L_main2:
	GOTO       L_main0
L_end_main:
	GOTO       $+0
; end of _main
