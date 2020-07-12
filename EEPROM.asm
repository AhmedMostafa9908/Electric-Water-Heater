
_EEPROM_Write:

;EEPROM.c,4 :: 		void EEPROM_Write(unsigned int add, unsigned char Data){
;EEPROM.c,5 :: 		I2C_Master_Start();
	CALL       _I2C_Master_Start+0
;EEPROM.c,6 :: 		I2C_Master_Write(EEPROM_Address_W);
	MOVLW      160
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,7 :: 		I2C_Master_Write(add>>8);
	MOVF       FARG_EEPROM_Write_add+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,8 :: 		I2C_Master_Write((unsigned char)add);
	MOVF       FARG_EEPROM_Write_add+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,9 :: 		I2C_Master_Write(Data);
	MOVF       FARG_EEPROM_Write_Data+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,10 :: 		I2C_Master_Stop();
	CALL       _I2C_Master_Stop+0
;EEPROM.c,12 :: 		}
L_end_EEPROM_Write:
	RETURN
; end of _EEPROM_Write

_EEPROM_Write_Page:

;EEPROM.c,13 :: 		void EEPROM_Write_Page(unsigned int add, unsigned char* Data, unsigned char len){
;EEPROM.c,15 :: 		I2C_Master_Start();
	CALL       _I2C_Master_Start+0
;EEPROM.c,16 :: 		I2C_Master_Write(EEPROM_Address_W);
	MOVLW      160
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,18 :: 		I2C_Master_Write(add>>8);
	MOVF       FARG_EEPROM_Write_Page_add+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,19 :: 		I2C_Master_Write((unsigned char)add);
	MOVF       FARG_EEPROM_Write_Page_add+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,20 :: 		for(i=0;i<len;i++){
	CLRF       EEPROM_Write_Page_i_L0+0
	CLRF       EEPROM_Write_Page_i_L0+1
L_EEPROM_Write_Page0:
	MOVLW      128
	XORWF      EEPROM_Write_Page_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__EEPROM_Write_Page8
	MOVF       FARG_EEPROM_Write_Page_len+0, 0
	SUBWF      EEPROM_Write_Page_i_L0+0, 0
L__EEPROM_Write_Page8:
	BTFSC      STATUS+0, 0
	GOTO       L_EEPROM_Write_Page1
;EEPROM.c,21 :: 		I2C_Master_Write(Data[i]);
	MOVF       EEPROM_Write_Page_i_L0+0, 0
	ADDWF      FARG_EEPROM_Write_Page_Data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,20 :: 		for(i=0;i<len;i++){
	INCF       EEPROM_Write_Page_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       EEPROM_Write_Page_i_L0+1, 1
;EEPROM.c,22 :: 		}
	GOTO       L_EEPROM_Write_Page0
L_EEPROM_Write_Page1:
;EEPROM.c,23 :: 		I2C_Master_Stop();
	CALL       _I2C_Master_Stop+0
;EEPROM.c,24 :: 		}
L_end_EEPROM_Write_Page:
	RETURN
; end of _EEPROM_Write_Page

_EEPROM_Write_INT:

;EEPROM.c,26 :: 		void EEPROM_Write_INT(unsigned int add, uint16_t Data){
;EEPROM.c,27 :: 		I2C_Master_Start();
	CALL       _I2C_Master_Start+0
;EEPROM.c,28 :: 		I2C_Master_Write(EEPROM_Address_W);
	MOVLW      160
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,29 :: 		I2C_Master_Write(add>>8);
	MOVF       FARG_EEPROM_Write_INT_add+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,30 :: 		I2C_Master_Write((unsigned char)add);
	MOVF       FARG_EEPROM_Write_INT_add+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,31 :: 		I2C_Master_Write(Data>>8);
	MOVF       FARG_EEPROM_Write_INT_Data+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,32 :: 		I2C_Master_Write((unsigned char)Data);
	MOVF       FARG_EEPROM_Write_INT_Data+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,33 :: 		I2C_Master_Stop();
	CALL       _I2C_Master_Stop+0
;EEPROM.c,34 :: 		}
L_end_EEPROM_Write_INT:
	RETURN
; end of _EEPROM_Write_INT

_EEPROM_Read:

;EEPROM.c,36 :: 		unsigned char EEPROM_Read(unsigned int add){
;EEPROM.c,38 :: 		I2C_Master_Start();
	CALL       _I2C_Master_Start+0
;EEPROM.c,40 :: 		I2C_Master_Write(EEPROM_Address_W);
	MOVLW      160
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,41 :: 		I2C_Master_Write(add>>8);
	MOVF       FARG_EEPROM_Read_add+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,42 :: 		I2C_Master_Write((unsigned char)add);
	MOVF       FARG_EEPROM_Read_add+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,43 :: 		I2C_Master_RepeatedStart();
	CALL       _I2C_Master_RepeatedStart+0
;EEPROM.c,44 :: 		I2C_Master_Write(EEPROM_Address_R);
	MOVLW      161
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,45 :: 		Data = I2C_Read_Byte();
	CALL       _I2C_Read_Byte+0
	MOVF       R0+0, 0
	MOVWF      EEPROM_Read_Data_L0+0
;EEPROM.c,46 :: 		I2C_NACK();
	CALL       _I2C_NACK+0
;EEPROM.c,47 :: 		I2C_Master_Stop();
	CALL       _I2C_Master_Stop+0
;EEPROM.c,48 :: 		return Data;
	MOVF       EEPROM_Read_Data_L0+0, 0
	MOVWF      R0+0
;EEPROM.c,49 :: 		}
L_end_EEPROM_Read:
	RETURN
; end of _EEPROM_Read

_EEPROM_Read_Page:

;EEPROM.c,53 :: 		void EEPROM_Read_Page(unsigned int add, unsigned char* Data, unsigned int len){
;EEPROM.c,55 :: 		I2C_Master_Start();
	CALL       _I2C_Master_Start+0
;EEPROM.c,57 :: 		I2C_Master_Write(EEPROM_Address_W);
	MOVLW      160
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,59 :: 		I2C_Master_Write(add>>8);
	MOVF       FARG_EEPROM_Read_Page_add+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,60 :: 		I2C_Master_Write((unsigned char)add);
	MOVF       FARG_EEPROM_Read_Page_add+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,61 :: 		I2C_Master_RepeatedStart();
	CALL       _I2C_Master_RepeatedStart+0
;EEPROM.c,62 :: 		I2C_Master_Write(EEPROM_Address_R);
	MOVLW      161
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,63 :: 		for(i=0; i<len; i++)
	CLRF       EEPROM_Read_Page_i_L0+0
	CLRF       EEPROM_Read_Page_i_L0+1
L_EEPROM_Read_Page3:
	MOVF       FARG_EEPROM_Read_Page_len+1, 0
	SUBWF      EEPROM_Read_Page_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__EEPROM_Read_Page12
	MOVF       FARG_EEPROM_Read_Page_len+0, 0
	SUBWF      EEPROM_Read_Page_i_L0+0, 0
L__EEPROM_Read_Page12:
	BTFSC      STATUS+0, 0
	GOTO       L_EEPROM_Read_Page4
;EEPROM.c,65 :: 		Data[i] = I2C_Read_Byte();
	MOVF       EEPROM_Read_Page_i_L0+0, 0
	ADDWF      FARG_EEPROM_Read_Page_Data+0, 0
	MOVWF      FLOC__EEPROM_Read_Page+0
	CALL       _I2C_Read_Byte+0
	MOVF       FLOC__EEPROM_Read_Page+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;EEPROM.c,66 :: 		I2C_ACK();
	CALL       _I2C_ACK+0
;EEPROM.c,63 :: 		for(i=0; i<len; i++)
	INCF       EEPROM_Read_Page_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       EEPROM_Read_Page_i_L0+1, 1
;EEPROM.c,67 :: 		}
	GOTO       L_EEPROM_Read_Page3
L_EEPROM_Read_Page4:
;EEPROM.c,68 :: 		I2C_Master_Stop();
	CALL       _I2C_Master_Stop+0
;EEPROM.c,69 :: 		}
L_end_EEPROM_Read_Page:
	RETURN
; end of _EEPROM_Read_Page

_EEPROM_Read_INT:

;EEPROM.c,70 :: 		uint16_t EEPROM_Read_INT(unsigned int add){
;EEPROM.c,73 :: 		I2C_Master_Start();
	CALL       _I2C_Master_Start+0
;EEPROM.c,74 :: 		I2C_Master_Write(EEPROM_Address_W);
	MOVLW      160
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,75 :: 		I2C_Master_Write(add>>8);
	MOVF       FARG_EEPROM_Read_INT_add+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,76 :: 		I2C_Master_Write((unsigned char)add);
	MOVF       FARG_EEPROM_Read_INT_add+0, 0
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,77 :: 		I2C_Master_RepeatedStart();
	CALL       _I2C_Master_RepeatedStart+0
;EEPROM.c,78 :: 		I2C_Master_Write(EEPROM_Address_R);
	MOVLW      161
	MOVWF      FARG_I2C_Master_Write_Data+0
	CALL       _I2C_Master_Write+0
;EEPROM.c,79 :: 		Data=I2C_Read_Byte();
	CALL       _I2C_Read_Byte+0
	MOVF       R0+0, 0
	MOVWF      EEPROM_Read_INT_Data_L0+0
	CLRF       EEPROM_Read_INT_Data_L0+1
;EEPROM.c,80 :: 		I2C_ACK();
	CALL       _I2C_ACK+0
;EEPROM.c,81 :: 		Data2=I2C_Read_Byte();
	CALL       _I2C_Read_Byte+0
	MOVF       R0+0, 0
	MOVWF      EEPROM_Read_INT_Data2_L0+0
	CLRF       EEPROM_Read_INT_Data2_L0+1
;EEPROM.c,82 :: 		I2C_ACK();
	CALL       _I2C_ACK+0
;EEPROM.c,83 :: 		I2C_Master_Stop();
	CALL       _I2C_Master_Stop+0
;EEPROM.c,84 :: 		return (Data<<8)+Data2;
	MOVF       EEPROM_Read_INT_Data_L0+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       EEPROM_Read_INT_Data2_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       EEPROM_Read_INT_Data2_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;EEPROM.c,85 :: 		}
L_end_EEPROM_Read_INT:
	RETURN
; end of _EEPROM_Read_INT
