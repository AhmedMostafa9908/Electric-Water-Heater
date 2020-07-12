
_ADC_Init:

;TempSensor.c,3 :: 		void ADC_Init(){
;TempSensor.c,5 :: 		ADCON0=0x51;
	MOVLW      81
	MOVWF      ADCON0+0
;TempSensor.c,7 :: 		ADCON1=0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;TempSensor.c,8 :: 		}
L_end_ADC_Init:
	RETURN
; end of _ADC_Init

_Read_Temp:

;TempSensor.c,9 :: 		uint16_t Read_Temp(){
;TempSensor.c,11 :: 		delay_us(30);
	MOVLW      19
	MOVWF      R13+0
L_Read_Temp0:
	DECFSZ     R13+0, 1
	GOTO       L_Read_Temp0
	NOP
	NOP
;TempSensor.c,12 :: 		GO_DONE_bit=1;
	BSF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;TempSensor.c,13 :: 		while(GO_DONE_bit==1);
L_Read_Temp1:
	BTFSS      GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
	GOTO       L_Read_Temp2
	GOTO       L_Read_Temp1
L_Read_Temp2:
;TempSensor.c,14 :: 		result=(ADRESH<<8)+ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
;TempSensor.c,15 :: 		return result *.488;
	CALL       _word2double+0
	MOVLW      35
	MOVWF      R4+0
	MOVLW      219
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2word+0
;TempSensor.c,16 :: 		}
L_end_Read_Temp:
	RETURN
; end of _Read_Temp
