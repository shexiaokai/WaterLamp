
ORG 00H

MIAN:	
		MOV 	A	,	#0FEH		;���ۼ���������0xFE
		
		
LOOP:	
		MOV 	P2	,	A			;���ۼ����е����ݷ���A
		RL		A					;Aѭ������	
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