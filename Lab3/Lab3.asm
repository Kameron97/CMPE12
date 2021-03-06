;Kameron GIll
;1467833
;kgill2@ucsc.edu
;Lab Section: TuThurs 7-9PM

;Lab 3
;Decimal to binary 2-bits compliments converter

.ORIG x3000

LEA R0, GREETING	;PRINTS GREETINGS
PUTS

START LEA R0, ENTER		;REPEASTS INSTRUCTIONS
PUTS

;INITALIZES VAIBLES AND SETS TO 0
AND R0, R0, #0		;INPUT
AND R1, R1, #0		;INT
AND R2, R2, #0		;MASK
AND R3, R3, #0		;FLAG
AND R4, R4, #0		;MULT COUNTER
AND R5, R5, #0		;TEMP
AND R6, R6, #0		;TEMP
AND R7, R7, #0		;TEMP
ST R0, INT		;Sets INT to 0, INT holds backup int
BR INPUT

INPUT		GETC	;Input character into R0
OUT			;Print input onto screen
BR NEWLINE


NEWLINE AND R5, R5, #0		;R5=0
AND R6, R6, #0			;R6=0
ADD R6, R6, #-10  		;R6=LF
ADD R5, R0, R6  ;CHECK FOR NEWLINE
BRz FLAG

NEGATIVE AND R6, R6, #0  ;R6=0
LD R6, NEG		;CHECKS FOR "-" IN ASCII BY LOADING -45
ADD R5, R5, #0    ;CHECKS
ADD R5, R0, R6
BRz FLAG1

EXIT AND R6, R6, #0  ;R6=0
LD R6, X		;CHECKS FOR "X" IN ASCI -88
AND R5, R5, #0
ADD R5, R0, R6
BRz END			;IF ITS -88, THEN  END PROGRAM

SETUP AND R6, R6, #0	;R6=0
ADD R0, R0, #-16	;MINUS 48 FROM INPUT
ADD R0, R0, #-16
ADD R0, R0, #-16
AND R4, R4, #0
LD R1, INT	;R1=INT
BR MULT



ADD1 ADD R6,R6, R0
ST R6, INT
BR INPUT

MULT ADD R4, R4, #1	;COUNTER++
ADD R6, R6, R1		;R6+INT
AND R5, R5, #0
ADD R5, R5, #-10	;RUN LOOP 10 TIMES
AND R7, R7, #0
ADD R7, R5, R4
BRnp MULT		;R6<10, GO TO MULT
BRz ADD1		;;R6=10GO TO ADD1



FLAG AND R6, R6, #0
ADD R6, R6, #-1		;IF FLAG==1, INVERT(INT)
ADD R6, R6, R3
BRz INVERT

AND R2, R2, #0
LD R1, INT		;R1=INT

MASKUP AND R5, R5, #0
AND R7, R7, #0

MASKPR LEA R6, MASK
ADD R6, R6, R2		;R6+COUNTER
LDR R6, R6 0		;0
AND R5, R5, #0
AND R0, R0, #0
AND R5, R1, R6		
BRnp ONE		;PRINT 1
BRz ZERO		;PRINT 0

FLAG1 AND R3, R3, #0
ADD R3, R3, #1
BR INPUT

ZERO		AND R0, R0, #0		;Reset register
LD R0, ZERO1		;RO=48 ASCII FOR 0
OUT			;Print '0'
BR MASKCOUNTER	

INVERT	LD R1, INT		;R1=INT
NOT R1, R1		;NOT R1
ADD R1, R1, #1		;R1++
ST R1, INT		
BR MASKUP		;MASK	

ONE		AND R0, R0, #0		;Reset register
LD R0, ONE1		;R0=49 ASCII FOR 1
OUT			;Print '1'
BR MASKCOUNTER		


MASKCOUNTER ADD R2, R2, #1	;R2++;
AND R7, R7, #0
ADD R7, R2, #-16	
BRzp START 		;R6<0
BRn MASKUP		;R7=0




END LEA R0, BYE		;Load goodbye message
		PUTS			;Print goodbye message

		HALT

INT	.BLKW 16
ZERO1 .FILL #48
ONE1 .FILL #49
X .FILL #-88
NEG .FILL #-45


GREETING	.STRINGZ "WELCOME TO LAB3!"
ENTER	.STRINGZ "\nEnter a decimal number or X to quit:\n"
THANK	.STRINGZ "\nHERE IS THE BINARY CONVERSION\n"
BYE	.STRINGZ "\nEXITTING LAB3."




MASK	.FILL x8000
	.FILL x4000
	.FILL x2000
	.FILL x1000
	.FILL x0800
	.FILL x0400
	.FILL x0200
	.FILL x0100
	.FILL x0080
	.FILL x0040
	.FILL x0020
	.FILL x0010
	.FILL x0008
	.FILL x0004
	.FILL x0002
	.FILL x0001

.END
