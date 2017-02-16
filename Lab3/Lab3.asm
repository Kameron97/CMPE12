;Kameron GIll
;1467833
;kgill2@ucsc.edu
;Lab Section: TuThurs 7-9PM

;Lab 3
;Decimal to binary 2-bits compliments converter

.ORIG x3000

LEA R0, GREETING	;PRINTS GREETINGS
PUTS

BEGIN	LEA R0, ENTER		;REPEASTS INSTRUCTIONS
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

INPUT		GETC			;Input character into R0
OUT			;Print input onto screen
BR NEWLINE


NEWLINE AND R5, R5, #0
AND R6, R6, #0
ADD R6, R6, #-10  ;R6=LF
ADD R5, R0, R6  ;CHECK FOR NEWLINE
BRz FLAG

NEGATIVE AND R6, R6, #0  ;R6=0
AND R6, R6, R6, #-15
AND R6, R6, R6, #-15
AND R6, R6, R6, #-15  ;R6= "-"
AND R5, R5, #0    ;CHECKS
ADD R5, R0, R6
BRz FLAG1

EXIT AND R6, R6, #0  ;R6=0
ADD R6, R6, #-16
ADD R6, R6, #-16
ADD R6, R6, #-16
ADD R6, R6, #-16
ADD R6, R6, #-16
ADD R6, R6, #-8
AND R5, R5, #0
ADD R5, R0, R6
BRz END

MULT ADD R4, R4, #1
ADD R6, R6, R1
AND R5, R5, #0
ADD R5, R5, #-10
AND R7, R7, #0
ADD R7, R5, R4
BRnp MULT
BRz ADD1

ADD1 ADD R6,R6, R0
ST R6, INT
BR INPUT

FLAG1 AND R3, R3, #0
ADD R3, R3, #1
BR INPUT

FLAG AND R6, R6, #0
ADD R6, R6, #-1
ADD R6, R6, R3
BRz INVERT

AND R2, R2, #0
LD R1, INT

MASKUP AND R5, R5, #0
AND R7, R7, #0

MASKPR LEA R6, MASK
ADD R6, R6, R2
LDR R6, R6 0
AND R5, R5, #0
AND R0, R0, #0
AND R5, R1, R6
BRz ZERO
BRnp ONE

ZERO		AND R0, R0, #0		;Reset register
ADD R0, R0, #15		;Add 48 for ASCII '0'
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT			;Print '0'
BR MASKCOUNTER		;Increment counter

ONE		AND R0, R0, #0		;Reset register
ADD R0, R0, #15		;Add 49 for ASCII '1'
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #4
OUT			;Print '1'
BR MASKCOUNTER		;Increment counter


MASKCOUNTER	ADD R2, R2, #1		;Increment mask counter by 1
AND R7, R7, #0
ADD R7, R2, #-16	;Check if MASKPTR looped 16 times
BRzp START		;If it did ask for input again
BRn SETUPMASK		;Else loop MASKPTR

INVERT		LD R1, INT		;Load INT into R1
NOT R1, R1		;Flip R1
ADD R1, R1, #1		;Add 1
ST R1, INT		;Store new value into INT
BR SETUPMASK		;Begin MASK-ing

GOODBYE		LEA R0, BYE		;Load goodbye message
		PUTS			;Print goodbye message

		HALT

INT	.BLKW 16
ZERO1 .FILL #48
ONE1 .FILL #49
X .FILL #88

GREETING	.STRINGZ "Welcome to the conversion program"
BEGIN	.STRINGZ "\nEnter a decimal number or X to quit:\n"
THANK	.STRINGZ "\nThanks, here it is in binary\n"
BYE	.STRINGZ "\nBye. Have a great day."




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
