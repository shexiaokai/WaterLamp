LED:

		MOV		A	,	MODE
		
MODE1:	
		CJNE	A	,	#01H	,	MODE2	;���Ϊģʽ1
		
		
		SJMP	LEDRETURN
MODE2:	
		CJNE	A	,	#02H	,	MODE3	;���Ϊģʽ2
		CLR		RS0					;���õ�1������;
		SETB	RS1
		SJMP	LEDRETURN
MODE3:	
		CJNE	A	,	#04H	,	LEDRETURN	;
		SETB	RS0					;���õ�2������;
		CLR		RS1
		SJMP	LEDRETURN
		
LEDRETURN:
		RET
		
		END