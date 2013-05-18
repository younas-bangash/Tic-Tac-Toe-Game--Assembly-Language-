
.data
grid:  	.word 0, 0, 0, 0, 0, 0, 0, 0, 0
input1:		.asciiz "\n User X please select the next square (1-9):  "
input2: 	.asciiz "\n User O please select the next square (1-9):  "
output1:	.asciiz "\n Invalid move! The square is already occupied; please select again (1-9):  "
output2:	.asciiz "\n Invalid index! Please select the next square (1-9):  "
output3:	.asciiz "\n-----------------------\n"
output4:	.asciiz "  "
output5:	.asciiz "  |"
output6:	.asciiz "X"
output7:	.asciiz "O"
output8:	.asciiz "-"
output9:	.asciiz "\n Congratulations, X WINS!"
output10:	.asciiz "\n Congratulations, O WINS!"
output11:	.asciiz	"\n GAME DRAW"
output12:	.asciiz "\n Continue? (1 = yes, 0 = no)"
output13:	.asciiz "\n To continue please choose (1 = yes, 0 = no)"
nl:		.asciiz "\n"

	.text
main:	
	addi $t3, $zero, 9	#Counter
	addi $a2, $zero, 1	#Value 1 will represent X.
	addi $s2, $zero, 2	#Value 2 will represent O.
	addi $s0, $zero, 3	#Counter for printing.
	addi $s1, $zero, 3	#Another counter for printing.
	add $t9, $zero, $zero	#A flag to tell who's turn it is.

print:	
	li $v0, 4		#This prints the current status of the tic-tac-toe board
	la $a1, grid

print1:	
	lw $t8, 0($a1)
	addi $a1, $a1, 4
	la $a0, output4
	syscall
	beq $t8, $zero, dash
	beq $t8, $a2, X

O:	la $a0, output7
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash
	j nline

X:	la $a0, output6
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash
	j nline

dash:	
	la $a0, output8
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash
	j nline

hdash:	
	la $a0, output5
	syscall
	j print1

nline:	
	la $a0, output3
	syscall
	addi $s1, $s1, -1
	addi $s0, $s0, 3
	bgtz $s1, print1
	beq $t9, $zero, main2
	j main3

win1:	li $v0, 4		#Same thing as print, except it also prints that player X wins.
	la $a1, grid
prin1:	lw $t8, 0($a1)
	addi $a1, $a1, 4
	la $a0, output4
	syscall
	beq $t8, $zero, dash1
	beq $t8, $a2, X1
O1:	la $a0, output7
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash1
	j nline1
X1:	la $a0, output6
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash1
	j nline1
dash1:	la $a0, output8
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash1
	j nline1
hdash1:	la $a0, output5
	syscall
	j prin1
nline1:	la $a0, output3
	syscall
	addi $s1, $s1, -1
	addi $s0, $s0, 3
	bgtz $s1, prin1
	la $a0, output9
	syscall
	j cont

win2:	li $v0, 4		#Same thing as print, except it also prints that player O wins.
	la $a1, grid
prin2:	lw $t8, 0($a1)
	addi $a1, $a1, 4
	la $a0, output4
	syscall
	beq $t8, $zero, dash2
	beq $t8, $a2, X2
O2:	la $a0, output7
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash2
	j nline
X2:	la $a0, output6
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash2
	j nline2
dash2:	la $a0, output8
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdash2
	j nline2
hdash2:	la $a0, output5
	syscall
	j prin2
nline2:	la $a0, output3
	syscall
	addi $s1, $s1, -1
	addi $s0, $s0, 3
	bgtz $s1, prin2
	la $a0, output10
	syscall
	j cont

draw:	li $v0, 4		#Same thing as print, except it also prints that it was a draw.
	la $a1, grid
prinw:	lw $t8, 0($a1)
	addi $a1, $a1, 4
	la $a0, output4
	syscall
	beq $t8, $zero, dashw
	beq $t8, $a2, Xw
Ow:	la $a0, output7
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdashw
	j nlinew
Xw:	la $a0, output6
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdashw
	j nlinew
dashw:	la $a0, output8
	syscall
	addi $s0, $s0, -1
	bgtz $s0, hdashw
	j nlinew
hdashw:	la $a0, output5
	syscall
	j prinw
nlinew:	la $a0, output3
	syscall
	addi $s1, $s1, -1
	addi $s0, $s0, 3
	bgtz $s1, prinw
	la $a0, output11
	syscall
	j cont	

main21:	li $v0, 4
	la $a0, output1
	syscall	
main2:	li $v0, 4		#Load command to output string
	la $a0, input1
	syscall
	li $v0, 5		#Load command to input an integer
	syscall
	slti $t1, $v0, 10	#Catches an exception, index > 9.
	beq $t1, $zero, excep1
	slti $t1, $v0, 1	#Catches an exception, index < 1.
	bne $t1, $zero, excep1
	la $a0, grid
	addi $v0, $v0, -1
	sll $t1, $v0, 2		#Multiply index by 4, for byte offset.
	add $a0, $a0, $t1	
	lw $a1, 0($a0)		#Make this square an X.
	bgtz $a1, main21
	addi $a1, $a1, 1
	sw $a1, 0($a0)
	addi $t3, $t3, -1	#Subtract counter.
	addi $t9, $t9, 1	#Player O's turn is next
	addi $s1, $s1, 3
	j end1

main31:	li $v0, 4
	la $a0, output1
	syscall
main3:	li $v0, 4		#Load command to output string
	la $a0, input2
	syscall
	li $v0, 5		#Load command to input an integer
	syscall
	slti $t1, $v0, 10	#Catches an exception, index > 9
	beq $t1, $zero, excep2
	slti $t1, $v0, 1	#Catches an exception, index < 1
	bne $t1, $zero, excep2
	la $a0, grid
	addi $v0, $v0, -1
	sll $t1, $v0, 2		#Multiply index by 4, for byte offset.
	add $a0, $a0, $t1
	lw $a1, 0($a0)		#Make this square an O.
	bgtz $a1, main31
	addi $a1, $a1, 2
	sw $a1, 0($a0)
	addi $t3, $t3, -1	#Subtract counter.
	addi $t9, $t9, -1	#Player X's turn is next
	addi $s1, $s1, 3
	j end2

excep1:	li $v0, 4
	la $a0, output2
	syscall
	j main2

excep2: li $v0, 4
	la $a0, output2
	syscall
	j main3

#Both end1 and end2 are used to determine if X or O wins.
end1:	la $a0, grid
	lw $t4, 0($a0)	#Check if Row 1 is filled with X
	lw $t5, 4($a0)
	lw $t6, 8($a0)
	beq $t4, $a2, cond2
	j next
cond2:	beq $t5, $a2, cond3
	j next
cond3:	beq $t6, $a2, win1
next:	lw $t4, 12($a0)	#Check if Row 2 is filled with X
	lw $t5, 16($a0)
	lw $t6, 20($a0)
	beq $t4, $a2, con12
	j next1
con12:	beq $t5, $a2, con13
	j next1
con13:	beq $t6, $a2, win1
next1:	lw $t4, 24($a0)	#Check if Row 3 is filled with X
	lw $t5, 28($a0)
	lw $t6, 32($a0)
	beq $t4, $a2, con22
	j next2
con22:	beq $t5, $a2, con23
	j next2
con23:	beq $t6, $a2, win1
next2:	lw $t4, 0($a0)	#Check if this diagonal '\' is filled with X
	lw $t5, 16($a0)
	lw $t6, 32($a0)
	beq $t4, $a2, con32
	j next3
con32:	beq $t5, $a2, con33
	j next3
con33:	beq $t6, $a2, win1
next3:	lw $t4, 8($a0)	#Check if this diagonal '/' is filled with X
	lw $t5, 16($a0)
	lw $t6, 24($a0)
	beq $t4, $a2, con42
	j next4
con42:	beq $t5, $a2, con43
	j next4
con43:	beq $t6, $a2, win1
next4:	lw $t4, 0($a0)	#Check if column 1 is filled with X
	lw $t5, 12($a0)
	lw $t6, 24($a0)
	beq $t4, $a2, con52
	j next5
con52:	beq $t5, $a2, con53
	j next5
con53:	beq $t6, $a2, win1
next5:	lw $t4, 4($a0)	#Check if column 2 is filled with X
	lw $t5, 16($a0)
	lw $t6, 28($a0)
	beq $t4, $a2, con62
	j next6
con62:	beq $t5, $a2, con63
	j next6
con63:	beq $t6, $a2, win1
next6:	lw $t4, 8($a0)	#Check if column 3 is filled with X
	lw $t5, 20($a0)
	lw $t6, 32($a0)
	beq $t4, $a2, con72
	j next7
con72:	beq $t5, $a2, con73
	j next7
con73:	beq $t6, $a2, win1	
next7:	bne $t3, $zero, print
	j draw		#X must win by 9th turn or it's a draw

end2:	la $a0, grid	
	lw $t4, 0($a0)	#Check if row 1 is filled with O
	lw $t5, 4($a0)
	lw $t6, 8($a0)
	beq $t4, $s2, con2
	j nex
con2:	beq $t5, $s2, con3
	j nex
con3:	beq $t6, $s2, win2
nex:	lw $t4, 12($a0)	#Check if row 2 is filled with O
	lw $t5, 16($a0)
	lw $t6, 20($a0)
	beq $t4, $s2, co12
	j nex1
co12:	beq $t5, $s2, co13
	j nex1
co13:	beq $t6, $s2, win2
nex1:	lw $t4, 24($a0)	#Check if row 3 is filled with O
	lw $t5, 28($a0)
	lw $t6, 32($a0)
	beq $t4, $s2, co22
	j nex2
co22:	beq $t5, $s2, co23
	j nex2
co23:	beq $t6, $s2, win2
nex2:	lw $t4, 0($a0)	#Check if this diagonal '\' is filled with O
	lw $t5, 16($a0)
	lw $t6, 32($a0)
	beq $t4, $s2, co32
	j nex3
co32:	beq $t5, $s2, co33
	j nex3
co33:	beq $t6, $s2, win2
nex3:	lw $t4, 8($a0)	#Check if this diagonal '/' is filled with O
	lw $t5, 16($a0)
	lw $t6, 24($a0)
	beq $t4, $s2, co42
	j nex4
co42:	beq $t5, $s2, co43
	j nex4
co43:	beq $t6, $s2, win2
nex4:	lw $t4, 0($a0)	#Check if column 1 is filled with O
	lw $t5, 12($a0)
	lw $t6, 24($a0)
	beq $t4, $s2, co52
	j nex5
co52:	beq $t5, $s2, co53
	j nex5
co53:	beq $t6, $s2, win2
nex5:	lw $t4, 4($a0)	#Check if column 2 is filled with O
	lw $t5, 16($a0)
	lw $t6, 28($a0)
	beq $t4, $s2, co62
	j nex6
co62:	beq $t5, $s2, co63
	j nex6
co63:	beq $t6, $s2, win2
nex6:	lw $t4, 8($a0)	#Check if column 3 is filled with O
	lw $t5, 20($a0)
	lw $t6, 32($a0)
	beq $t4, $s2, co72
	j nex7
co72:	beq $t5, $s2, co73
	j nex7
co73:	beq $t6, $s2, win2	
nex7:	j print

excep3:	li $v0, 4
	la $a0, output13
	syscall
	j cont

#Clears the tic-tac-toe board for a new game.
clmain:	la $a0, grid
	add $a2, $zero, $zero
loop2:	slti $t1, $a2, 10
	beq $t1, $zero, main
loop:	lw $a1, 0($a0)
	addi $a2, $a2, 1	#Counter for clearing data.
	add $a1, $zero, $zero
	sw $a1, 0($a0)
	addi $a0, $a0, 4	#Move to the next address.
	j loop2

#This sees if the user wants to continue or not.
cont:	
	li $v0, 4			#Loads command to output string.
	la $a0, output12
	syscall
	li $v0, 5			#Loads command to input an integer
	syscall
	bltz $v0, excep3	#Make input more idiot-proof
	slti $t1, $v0, 2
	beq $t1, $zero, excep3
	slti $t1, $v0, 1
	li $v0, 4
	la $a0, nl
	syscall
	beq $t1, $zero, clmain
	li $v0, 10
	syscall
