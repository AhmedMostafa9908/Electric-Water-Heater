
_print_Number:

;_7seg.c,2 :: 		void print_Number(int number){
;_7seg.c,3 :: 		char values[10]={0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
	MOVLW      63
	MOVWF      print_Number_values_L0+0
	MOVLW      6
	MOVWF      print_Number_values_L0+1
	MOVLW      91
	MOVWF      print_Number_values_L0+2
	MOVLW      79
	MOVWF      print_Number_values_L0+3
	MOVLW      102
	MOVWF      print_Number_values_L0+4
	MOVLW      109
	MOVWF      print_Number_values_L0+5
	MOVLW      125
	MOVWF      print_Number_values_L0+6
	MOVLW      7
	MOVWF      print_Number_values_L0+7
	MOVLW      127
	MOVWF      print_Number_values_L0+8
	MOVLW      111
	MOVWF      print_Number_values_L0+9
;_7seg.c,4 :: 		TRISB=0;
	CLRF       TRISB+0
;_7seg.c,5 :: 		PORTB=values[number];
	MOVF       FARG_print_Number_number+0, 0
	ADDLW      print_Number_values_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;_7seg.c,6 :: 		}
L_end_print_Number:
	RETURN
; end of _print_Number

_Print_2digits_Number:

;_7seg.c,8 :: 		void Print_2digits_Number(uint16_t number){
;_7seg.c,11 :: 		char values[10]={0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
	MOVLW      63
	MOVWF      Print_2digits_Number_values_L0+0
	MOVLW      6
	MOVWF      Print_2digits_Number_values_L0+1
	MOVLW      91
	MOVWF      Print_2digits_Number_values_L0+2
	MOVLW      79
	MOVWF      Print_2digits_Number_values_L0+3
	MOVLW      102
	MOVWF      Print_2digits_Number_values_L0+4
	MOVLW      109
	MOVWF      Print_2digits_Number_values_L0+5
	MOVLW      125
	MOVWF      Print_2digits_Number_values_L0+6
	MOVLW      7
	MOVWF      Print_2digits_Number_values_L0+7
	MOVLW      127
	MOVWF      Print_2digits_Number_values_L0+8
	MOVLW      111
	MOVWF      Print_2digits_Number_values_L0+9
;_7seg.c,12 :: 		TRISD=0;
	CLRF       TRISD+0
;_7seg.c,13 :: 		ones=number%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Print_2digits_Number_number+0, 0
	MOVWF      R0+0
	MOVF       FARG_Print_2digits_Number_number+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__Print_2digits_Number+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Print_2digits_Number+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Print_2digits_Number_number+0, 0
	MOVWF      R0+0
	MOVF       FARG_Print_2digits_Number_number+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
;_7seg.c,14 :: 		tens=number/10;
	MOVF       R0+0, 0
	MOVWF      Print_2digits_Number_tens_L0+0
	MOVF       R0+1, 0
	MOVWF      Print_2digits_Number_tens_L0+1
;_7seg.c,15 :: 		PORTA|=0x10;
	BSF        PORTA+0, 4
;_7seg.c,16 :: 		PORTD=values[ones];
	MOVF       FLOC__Print_2digits_Number+0, 0
	ADDLW      Print_2digits_Number_values_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;_7seg.c,17 :: 		delay_us(1500);
	MOVLW      4
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_Print_2digits_Number0:
	DECFSZ     R13+0, 1
	GOTO       L_Print_2digits_Number0
	DECFSZ     R12+0, 1
	GOTO       L_Print_2digits_Number0
	NOP
;_7seg.c,18 :: 		PORTA=0;
	CLRF       PORTA+0
;_7seg.c,19 :: 		PORTA|=0x08;
	BSF        PORTA+0, 3
;_7seg.c,20 :: 		PORTD=values[tens];
	MOVF       Print_2digits_Number_tens_L0+0, 0
	ADDLW      Print_2digits_Number_values_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;_7seg.c,21 :: 		delay_us(1500);
	MOVLW      4
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_Print_2digits_Number1:
	DECFSZ     R13+0, 1
	GOTO       L_Print_2digits_Number1
	DECFSZ     R12+0, 1
	GOTO       L_Print_2digits_Number1
	NOP
;_7seg.c,22 :: 		PORTA=0;
	CLRF       PORTA+0
;_7seg.c,23 :: 		}
L_end_Print_2digits_Number:
	RETURN
; end of _Print_2digits_Number
