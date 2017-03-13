/* Kameron Gill
     1476833
     
     LAB 5: Section J
     */



.global main

.text
.set noreorder

.ent main
main:
    
    andi $t9, $t9, 0x0	     /* reset t9*/
    addi $t9, $t9, 0x0FF    /*x0ff is hex for 1111 1111, sets its value to it*/
			    /*all switches at 1 basicaly */
    sw $t9, TRISECLR	    /* Enable LED outputs by clearing bits 0-8 in TRISE */
    
    mainloop:
    lw $t2, PORTD	    /* t2=PORTD */
    lw $t3, PORTD	    /* t3=PORTD */
    lw $t4, PORTF	    /* T4=portf */
    la $t5, PORTE	    /* t5=PORTE */
			    
    
    
    andi $t3, $t3, 0x00E0   /*t3= 110 0000 last three light are off */
    sw $t3, 0($t5)	    /* Store the 1 bits of PORT D in PORT E to turn on LD6, LD7, LD8 */
    
    srl $t2, $t2, 8	    /*8 bits added to turn on LED 1 2 3 4*/
    andi $t6, $t2, 0x000F   /* cheks to see if LEDS are 1 2 3 4 are on,(xF = 0000 1111 */
    sw $t6, 0($t5)	    /*store bit of PORTD into port e */
			    
   
    sll $t4, $t4, 3	    /* SHift 3 = LED 5*/
    andi $t7, $t4, 0x0010   /* x10 =  0001 0000
				checks if button 1 is on */
    sw $t7, 0($t5)	   /*store inot PORT E*/

  
    b mainloop		    /* Restart loop */
    nop
    
.end main

.data


