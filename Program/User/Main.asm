
ORG 00H

MIAN:	
		MOV 	A	,	#0FEH		;在累加器中输入0xFE
		
		
LOOP:	
		MOV 	P2	,	A			;将累加器中的数据放入A
		RL		A					;A循环左移	
		ACALL	DELAY500MS
		SJMP	LOOP
		
DELAY500MS:							;@11.0592MHz
		MOV 	30H	,	#4
		MOV 	31H	,	#129
		MOV 	32H	,	#112
NEXT:
		DJNZ 	32H	,	NEXT
		DJNZ 	31H	,	NEXT
		DJNZ 	30H	,	NEXT

		RET


END