
.ORIG x3000
;INPUT SECTION
;===========================================================================
INPUT1											;Ask for the first digit to sort
	LD R5, HEXN30						;ASCII Offset
	LD R3, MC1								;Multiply counter for value 100
	LD R6, NUM1								;Load address of NUM1
	LEA R0, PROMPT						;Load Prompt to R0
	PUTS												;Display prompt to console
	LEA R0, NI1								;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of 1st value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn IV2D2									;1st value 2nd digit path 2 for non- 100 input
	BRz IV2D1									;1st value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
IV2D1
	LEA R0, NI2								;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz IV3D1									;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	IV3D1											;Third Value Check, input should be 0 anything else is error
	LEA R0, NI3								;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop											;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop							;Keep looping until MC is zero
	BRz SKIP1									;If MC is zero, move to SKIP1


IV2D2
	LEA R0, NI2								;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd value is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz	IV3D2								;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop2									;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop2						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

IV3D2
	LEA R0, NI3								;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP1												;Jump to here to store the 100 value to Num1 from IV2D1
	STI R2, NUM1							;Store Num1 to R2 from either IV2D1 or IV2D1
BR INPUT2										;Jump to INPUT2 for the 2nd value

NUM1 		.FILL X3200				;temporary storage for value input
MC1			.FILL #0010				;Multiply Counter 10
HEXN30 .FILL xFFD0 					;-30 HEX
PROMPT .STRINGZ "Please enter values in three digit form for sorting:"
NI1	.STRINGZ  "\nInput the 1st number in three digits (Enter 1st digit): "
NI2	.STRINGZ  "\nInput the 1st number in three digits (Enter 2nd digit): "
NI3	.STRINGZ  "\nInput the 1st number in three digits (Enter 3rd digit): "

;Input2
;==================================================================================
INPUT2											;Ask for the first digit to sort
	LD R3, MC2								;Multiply counter for value 100
	LD R6, NUM2								;Load address of NUM1
	LEA R0, TWONI1						;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn IIV2D2								;2nd value 2nd digit path 2 for non- 100 input
	BRz IIV2D1								;2nd value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
IIV2D1
	LEA R0, TWONI2						;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz IIV3D1								;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	IIV3D1											;Third Digit Check, input should be 0 anything else is error
	LEA R0, TWONI3						;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of  value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop3							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop3										;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop3						;Keep looping until MC is zero
	BRz SKIP2									;If MC is zero, move to SKIP2

IIV2D2
	LEA R0, TWONI2								;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd digit is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz	IIV3D2								;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop4									;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop4						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

IIV3D2
	LEA R0, TWONI3						;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP2												;Jump to here to store the 100 value to Num1 from IIV2D1
	STI R2, NUM2							;Store Num2 to R2 from either IIV2D1 or IIV2D1
BR INPUT3										;Jump to INPUT3 for the 3rd value

NUM2 		.FILL X3201				;temporary storage for value input
MC2			.FILL #0010				;Multiply Counter 10
TWONI1	.STRINGZ  "\nInput the 2nd number in three digits (Enter 1st digit): "
TWONI2	.STRINGZ  "\nInput the 2nd number in three digits (Enter 2nd digit): "
TWONI3	.STRINGZ  "\nInput the 2nd number in three digits (Enter 3rd digit): "

;Input3
;==================================================================================
INPUT3											;Ask for the first digit to sort
	LD R3, MC3								;Multiply counter for value 100
	LD R6, NUM3								;Load address of NUM1
	LEA R0, THREENI1					;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of  value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn IIIV2D2								;3rd value 2nd digit path 2 for non- 100 input
	BRz IIIV2D1								;3rd value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
IIIV2D1
	LEA R0, THREENI2					;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz IIIV3D1								;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	IIIV3D1											;Third Digit Check, input should be 0 anything else is error
	LEA R0, THREENI3						;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of  value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop5							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop5										;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop5						;Keep looping until MC is zero
	BRz SKIP3									;If MC is zero, move to SKIP3

IIIV2D2
	LEA R0, THREENI2					;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd digit is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz IIIV3D2								;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop6									;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop6						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

IIIV3D2
	LEA R0, THREENI3					;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP3												;Jump to here to store the 100 value from IIIV2D1
	STI R2, NUM3							;Store Num3 to R2 from either IIIV2D1 or IIIV2D1
BR INPUT4										;Jump to INPUT4 for the 4th value

NUM3 		.FILL X3202				;temporary storage for value input
MC3			.FILL #0010				;Multiply Counter 10
THREENI1	.STRINGZ  "\nInput the 3rd number in three digits (Enter 1st digit): "
THREENI2	.STRINGZ  "\nInput the 3rd number in three digits (Enter 2nd digit): "
THREENI3	.STRINGZ  "\nInput the 3rd number in three digits (Enter 3rd digit): "


;Input4
;==================================================================================

INPUT4											;Ask for the first digit to sort
	LD R3, MC4								;Multiply counter for value 100
	LD R6, NUM4								;Load address of NUM1
	LEA R0, FOURNI1					;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of  value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn IVV2D2								;4th value 2nd digit path 2 for non- 100 input
	BRz IVV2D1								;4th value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
IVV2D1
	LEA R0, FOURNI2					;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz IVV3D1								;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	IVV3D1										;Third Digit Check, input should be 0 anything else is error
	LEA R0, FOURNI3					;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of  value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop7							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop7										;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop7						;Keep looping until MC is zero
	BRz SKIP4									;If MC is zero, move to SKIP4

IVV2D2
	LEA R0, FOURNI2					;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd digit is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz IVV3D2								;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop8									;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop8						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

IVV3D2
	LEA R0, FOURNI3					;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP4												;Jump to here to store the 100 value from IVV2D1
	STI R2, NUM4							;Store Num4 to R2 from either IVV2D1 or IVV2D1
BR INPUT5										;Jump to INPUT5 for the 5th value

NUM4 		.FILL X3203				;temporary storage for value input
MC4			.FILL #0010				;Multiply Counter 10
FOURNI1	.STRINGZ  "\nInput the 4th number in three digits (Enter 1st digit): "
FOURNI2	.STRINGZ  "\nInput the 4th number in three digits (Enter 2nd digit): "
FOURNI3	.STRINGZ  "\nInput the 4th number in three digits (Enter 3rd digit): "


;Input5
;==================================================================================
INPUT5											;Ask for the first digit to sort
	LD R3, MC5								;Multiply counter for value 100
	LD R6, NUM5								;Load address of NUM1
	LEA R0, FIVENI1						;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of  value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn VV2D2								;5th value 2nd digit path 2 for non- 100 input
	BRz VV2D1								;5th value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
VV2D1
	LEA R0, FIVENI2						;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz VV3D1								;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	VV3D1											;Third Digit Check, input should be 0 anything else is error
	LEA R0, FIVENI3						;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of  value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop9							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop9										;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop9						;Keep looping until MC is zero
	BRz SKIP5									;If MC is zero, move to SKIP4

VV2D2
	LEA R0, FIVENI2					;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd digit is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz VV3D2								;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop10									;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop10						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

VV3D2
	LEA R0, FIVENI3						;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP5												;Jump to here to store the 100 value to Num1 from VV2D1
	STI R2, NUM5							;Store Num2 to R2 from either VV2D1 or VV2D1
BR INPUT6										;Jump to INPUT6 for the 6th value

NUM5 		.FILL X3204				;temporary storage for value input
MC5			.FILL #0010				;Multiply Counter 10
FIVENI1	.STRINGZ  "\nInput the 5th number in three digits (Enter 1st digit): "
FIVENI2	.STRINGZ  "\nInput the 5th number in three digits (Enter 2nd digit): "
FIVENI3	.STRINGZ  "\nInput the 5th number in three digits (Enter 3rd digit): "

;Input6
;==================================================================================
INPUT6											;Ask for the first digit to sort
	LD R3, MC6							;Multiply counter for value 100
	LD R6, NUM6								;Load address of NUM1
	LEA R0, SIXNI1					;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of  value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn VIV2D2								;6th value 2nd digit path 2 for non- 100 input
	BRz VIV2D1								;6th value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
VIV2D1
	LEA R0, SIXNI2					;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz VIV3D1								;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	VIV3D1											;Third Digit Check, input should be 0 anything else is error
	LEA R0, SIXNI3						;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of  value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop11							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop11										;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop11						;Keep looping until MC is zero
	BRz SKIP6									;If MC is zero, move to SKIP4

VIV2D2
	LEA R0, SIXNI2							;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd digit is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz VIV3D2								;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop12									;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop12						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

VIV3D2
	LEA R0, SIXNI3							;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP6												;Jump to here to store the 100 value from VIV2D1
	STI R2, NUM6							;Store Num6 to R2 from either VIV2D1 or VIV2D1
BR INPUT7										;Jump to INPUT7 for the 7th value

NUM6 		.FILL X3205				;temporary storage for value input
MC6			.FILL #0010				;Multiply Counter 10
SIXNI1	.STRINGZ  "\nInput the 6th number in three digits (Enter 1st digit): "
SIXNI2	.STRINGZ  "\nInput the 6th number in three digits (Enter 2nd digit): "
SIXNI3	.STRINGZ  "\nInput the 6th number in three digits (Enter 3rd digit): "


;Input7
;==================================================================================
INPUT7											;Ask for the first digit to sort
	LD R3, MC7								;Multiply counter for value 100
	LD R6, NUM7								;Load address of NUM1
	LEA R0, SEVENNI1					;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of  value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn VIIV2D2								;4th value 2nd digit path 2 for non- 100 input
	BRz VIIV2D1								;4th value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
VIIV2D1
	LEA R0, SEVENNI2					;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz VIIV3D1								;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	VIIV3D1											;Third Digit Check, input should be 0 anything else is error
	LEA R0, SEVENNI3						;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of  value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop13							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop13										;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop13						;Keep looping until MC is zero
	BRz SKIP7									;If MC is zero, move to SKIP4

VIIV2D2
	LEA R0, SEVENNI2					;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd digit is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz VIIV3D2								;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop14									;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop14						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

VIIV3D2
	LEA R0, SEVENNI3					;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP7												;Jump to here to store the 100 value1 from VIIV2D1
	STI R2, NUM7							;Store Num7 to R2 from either VIIV2D1 or VIIV2D1
BR INPUT8										;Jump to INPUT8 for the 8th value

NUM7 		.FILL X3206				;temporary storage for value input
MC7			.FILL #0010				;Multiply Counter 10
SEVENNI1	.STRINGZ  "\nInput the 7th number in three digits (Enter 1st digit): "
SEVENNI2	.STRINGZ  "\nInput the 7th number in three digits (Enter 2nd digit): "
SEVENNI3	.STRINGZ  "\nInput the 7th number in three digits (Enter 3rd digit): "

;Input8
;==================================================================================
INPUT8											;Ask for the first digit to sort
	LD R3, MC8								;Multiply counter for value 100
	LD R6, NUM8								;Load address of NUM1
	LEA R0, EIGTHNI1					;Ask user to input the first value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 1st digit of  value
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
															;Check if 1st value is 1, 0 or more than 1
	ADD R2, R2, #1						;Add 1 to R2
	NOT R2, R2								;Two's complement R2
	ADD R2, R2, #1
	ADD R1, R1, R2						;R1 minus R2 1-1 BRz  or 0-1 BRn or 2-1 HALT
															;Check if value is 100, if over 100, error
															;If 1st value is 1, input should be 100. 
															;2nd and 3rd should be zero anything else is error
	BRn VIIIV2D2								;4th value 2nd digit path 2 for non- 100 input
	BRz VIIIV2D1								;4th value 2nd digit path 1 for 100 input
	HALT											;Halt if value is more than 100s value is more than 1
															;Second Value Check
VIIIV2D1
	LEA R0, EIGTHNI2					;Ask user to input the second value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2  0+0 
	BRz VIIIV3D1								;Continue to ask third digit
	HALT											;Halt if 2nd digit is more than 0 for the 10s value of 100
	VIIIV3D1											;Third Digit Check, input should be 0 anything else is error
	LEA R0, EIGTHNI3						;Ask user to input the third value of a 3 digit number
	PUTS												;display question
	GETC												;ask to input 3rd digit of  value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R2, #0						;Put 0 in R2
	ADD R1, R1, R2						;R1 plus R2 0+0 Continue ;1+0 if positive halt to error
	BRz Multloop15							;If value is 100, move to Multloop. 
	HALT											;Halt if 3nd value is more than 0 for the 1s value of 100

Multloop15										;Create value 100 by 10 x 10. Multiply Loop. 
	ADD  R2, R2, #10						;Add 10 by 10 times to reach 100
	ADD R3, R3, #-1						;Remove 1 from MC (Multiply Counter)		
	BRp Multloop15						;Keep looping until MC is zero
	BRz SKIP8									;If MC is zero, move to SKIP4

VIIIV2D2
	LEA R0, EIGTHNI2					;Ask user to input the second value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 10s so # times 10.
	GETC												;ask to input 2nd digit of value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R4, R1, #0						;If 2nd digit is zero, Copy R1 to R4 for later to add with 3rd value ex. 00+9
	BRz VIIIV3D2							;then jump to 1st value 3rd digit, if not continue to multloop
	Multloop16								;Multiply to find the 10s value
															;R1 is counter for mult loop		
															;IF 3, 3X10 FOR 30
	ADD R2, R2, #10						;Add 10 x times where x is R1
	ADD R1, R1, #-1						;Remove 1 from Multiply Counter
	BRp Multloop16						;Keep looping until MC is zero
	ADD R4, R2, #0						;Copy R2 to R4 for later to add with 3rd value ex. 30+9

VIIIV3D2
	LEA R0, EIGTHNI3					;Ask user to input the third value of a 3 digit number, value can be 0-9
	PUTS												;value is in the 1s so just add with second value ex. 0 + 9 = 9.
	GETC												;ask to input 3rd digit of 1st value
	AND R1, R1, #0							;CLEAR R1
	AND R2, R2, #0							;CLEAR R2
	ADD R1, R0, R5						;copy to R1 and add ASCII Offset
	OUT												;Display their input to the user 
	AND R0, R0, #0							;CLEAR R0
	ADD R2, R4, R1						;ADD R4 to R1 Add the 10s value with the 1s value ex. 30 + 9 = 39.

SKIP8												;Jump to here to store the 100 value from VIIIV2D1
	STI R2, NUM8							;Store Num8 to R2 from either VIIIV2D1 or VIIIV2D1
HALT

NUM8 		.FILL X3207				;temporary storage for value input
MC8			.FILL #0010				;Multiply Counter 10
EIGTHNI1	.STRINGZ  "\nInput the 8th number in three digits (Enter 1st digit): "
EIGTHNI2	.STRINGZ  "\nInput the 8th number in three digits (Enter 2nd digit): "
EIGTHNI3	.STRINGZ  "\nInput the 8th number in three digits (Enter 3rd digit): "

;END OF INPUT SECTION
;==============================================================================
.END
