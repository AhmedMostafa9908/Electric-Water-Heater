
_I2C_Master_Init:

;I2C.c,3 :: 		void I2C_Master_Init()
;I2C.c,5 :: 		TRISC3_bit=1;
	BSF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;I2C.c,6 :: 		TRISC4_bit=1;  // sets C3 & C4 as high impedence inputs
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;I2C.c,7 :: 		SSPADD=(_XTAL_FREQ/(4*100000)) - 1;    // value to make boud rate 100k bit/s
	MOVLW      39
	MOVWF      SSPADD+0
;I2C.c,8 :: 		SSPCON=0x28;   // master mode , enable MSSP
	MOVLW      40
	MOVWF      SSPCON+0
;I2C.c,9 :: 		SSPCON2 = 0x00;
	CLRF       SSPCON2+0
;I2C.c,10 :: 		SSPSTAT = 0x00;
	CLRF       SSPSTAT+0
;I2C.c,11 :: 		}
L_end_I2C_Master_Init:
	RETURN
; end of _I2C_Master_Init

_I2C_Master_Wait:

;I2C.c,12 :: 		void I2C_Master_Wait(){
;I2C.c,13 :: 		while ((SSPSTAT & 0x04) || (SSPCON2 & 0x1F));
L_I2C_Master_Wait0:
	BTFSC      SSPSTAT+0, 2
	GOTO       L__I2C_Master_Wait6
	MOVLW      31
	ANDWF      SSPCON2+0, 0
	MOVWF      R0+0
	BTFSS      STATUS+0, 2
	GOTO       L__I2C_Master_Wait6
	GOTO       L_I2C_Master_Wait1
L__I2C_Master_Wait6:
	GOTO       L_I2C_Master_Wait0
L_I2C_Master_Wait1:
;I2C.c,14 :: 		}
L_end_I2C_Master_Wait:
	RETURN
; end of _I2C_Master_Wait

_I2C_Master_Start:

;I2C.c,15 :: 		void I2C_Master_Start(){
;I2C.c,16 :: 		I2C_Master_Wait();
	CALL       _I2C_Master_Wait+0
;I2C.c,17 :: 		SEN_bit=1;   // Write 1 in SE
	BSF        SEN_bit+0, BitPos(SEN_bit+0)
;I2C.c,19 :: 		}
L_end_I2C_Master_Start:
	RETURN
; end of _I2C_Master_Start

_I2C_Master_RepeatedStart:

;I2C.c,20 :: 		void I2C_Master_RepeatedStart(){
;I2C.c,22 :: 		RSEN_bit=1;      //Write 1 in RSEN
	BSF        RSEN_bit+0, BitPos(RSEN_bit+0)
;I2C.c,23 :: 		I2C_Master_Wait();
	CALL       _I2C_Master_Wait+0
;I2C.c,24 :: 		}
L_end_I2C_Master_RepeatedStart:
	RETURN
; end of _I2C_Master_RepeatedStart

_I2C_Master_Stop:

;I2C.c,25 :: 		void I2C_Master_Stop(){
;I2C.c,26 :: 		I2C_Master_Wait();
	CALL       _I2C_Master_Wait+0
;I2C.c,27 :: 		PEN_bit=1;   // write 1 in PE
	BSF        PEN_bit+0, BitPos(PEN_bit+0)
;I2C.c,29 :: 		}
L_end_I2C_Master_Stop:
	RETURN
; end of _I2C_Master_Stop

_I2C_ACK:

;I2C.c,30 :: 		void I2C_ACK(){
;I2C.c,32 :: 		ACKDT_bit=0;     // the signal is ACk
	BCF        ACKDT_bit+0, BitPos(ACKDT_bit+0)
;I2C.c,33 :: 		ACKEN_bit=1;     // send ACk
	BSF        ACKEN_bit+0, BitPos(ACKEN_bit+0)
;I2C.c,34 :: 		I2C_Master_Wait();
	CALL       _I2C_Master_Wait+0
;I2C.c,35 :: 		}
L_end_I2C_ACK:
	RETURN
; end of _I2C_ACK

_I2C_NACK:

;I2C.c,36 :: 		void I2C_NACK(){
;I2C.c,38 :: 		ACKDT_bit=1;      // THe signal is NACk
	BSF        ACKDT_bit+0, BitPos(ACKDT_bit+0)
;I2C.c,39 :: 		ACKEN_bit=1; //send NACK
	BSF        ACKEN_bit+0, BitPos(ACKEN_bit+0)
;I2C.c,40 :: 		I2C_Master_Wait();
	CALL       _I2C_Master_Wait+0
;I2C.c,41 :: 		}
L_end_I2C_NACK:
	RETURN
; end of _I2C_NACK

_I2C_Master_Write:

;I2C.c,42 :: 		void I2C_Master_Write(unsigned char Data){
;I2C.c,43 :: 		I2C_Master_Wait();
	CALL       _I2C_Master_Wait+0
;I2C.c,44 :: 		SSPBUF = Data;
	MOVF       FARG_I2C_Master_Write_Data+0, 0
	MOVWF      SSPBUF+0
;I2C.c,45 :: 		I2C_Master_Wait();  //to till me the slave recive the data and send Ack
	CALL       _I2C_Master_Wait+0
;I2C.c,47 :: 		}
L_end_I2C_Master_Write:
	RETURN
; end of _I2C_Master_Write

_I2C_Read_Byte:

;I2C.c,48 :: 		unsigned char I2C_Read_Byte(void){
;I2C.c,49 :: 		RCEN_bit=1; // enable master recive
	BSF        RCEN_bit+0, BitPos(RCEN_bit+0)
;I2C.c,50 :: 		while(!SSPIF_bit);   // Wait Until Completion
L_I2C_Read_Byte4:
	BTFSC      SSPIF_bit+0, BitPos(SSPIF_bit+0)
	GOTO       L_I2C_Read_Byte5
	GOTO       L_I2C_Read_Byte4
L_I2C_Read_Byte5:
;I2C.c,51 :: 		SSPIF_bit = 0;
	BCF        SSPIF_bit+0, BitPos(SSPIF_bit+0)
;I2C.c,52 :: 		I2C_NACK();       // Clear The Interrupt Flag Bit
	CALL       _I2C_NACK+0
;I2C.c,53 :: 		return SSPBUF;
	MOVF       SSPBUF+0, 0
	MOVWF      R0+0
;I2C.c,55 :: 		}
L_end_I2C_Read_Byte:
	RETURN
; end of _I2C_Read_Byte
