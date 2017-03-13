/*Kameron Gill
 Lab 5
     */



/* define all global symbols here */
.global main 

.text
.set noreorder

.ent main
main:

 andi $t9, $t9, 0x0	     /* Clear t9*/
 addi $t9, $t9, 0x0FF    /* all LEDS are off */
 sw $t9, TRISECLR	    
 sw $t9, PORTECLR	    
 andi $t9, $t9, 0x0	    /* Clear t9*/
 addi $t9, $t9, 0x001    /* Set t9 to 1*/
 sw $t9, PORTESET	    /* TURN first LED on */
 andi $t0, $t0, 0x0	    /* Clear t0 */

 mainloop:
 lw $t2, PORTE	/* t2=porte */
 lw $t3, PORTD	/* t3= portd */
 la $t5, PORTE	/*t5= porte */

 srl $t3, $t3, 8	    /*right shift 8bits */
 andi $a0, $t3, 0x000F   /*xf= 1111, checks to see if all switches are on */
 addi $a0, $a0, 1	    /*a0++ */
 jal mydelay		    

 andi $t8, $t8, 0x0	    /* Clear t8 */
 addi $t8, $t8, 0x001    /* t8= 0001*/

 andi $t9, $t9, 0x0	    /* Clear t9 */
 addi $t9, $t9, 0x080    /* t9 = 1000 0000 */

 bgtz $t0, shiftright    /* If reverse flag t0 is 1, jump to shift right */
 nop
    
 shiftleft:
 beq $t2, $t9, shiftright	/* t2==t9 (LED 1), shift right */
 nop
 andi $t0, $t0, 0x0		/*clear flag */
 sll $t2, $t2, 1		/* Shift one bit to the left */
 sw $t2, 0($t5)		/* Store new bit into PORT E */
 b mainloop			/* jump back to mainloops */
 nop
 shiftright:
 beq $t2, $t8, shiftleft	/* t2== t8 (LED 8), go to shift left */
 nop
 andi $t0, $t0, 0x0		/*clear fag */
 addi $t0, $t0, 0x01		/*flag =1*/
 srl $t2, $t2, 1		/* Shift 1 bit to the right*/
 sw $t2, 0($t5)		/* Store new bit into PORT E */
 b mainloop			/* jump back to mainloops */
 nop
	    
	 

 mydelay:
 andi $t6, $t6, 0x0			/* Clear counter t6 */
 andi $t7, $t7, 0x0			/* Clear t7 */
 addi $t7, $t7, 0x0800		/* t7 = 2048*/
 mul $a0, $a0, $t7			/* a0*t7 */

 delayloop:
 beq $t6, $a0, exitdelay		/* t6==a0, exit */
 nop
 addi $t6, $t6, 1		/* t6++ */
 b delayloop			/* Restart loop */
 nop

 exitdelay:
 jr $ra				/* jump to my delay*/

.end main

.data
