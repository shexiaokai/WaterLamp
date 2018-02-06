$INCLUDE (Main.inc)
$INCLUDE (Delay.inc)
$INCLUDE (Key.inc)
ORG 00H
LJMP	MAIN

MAIN_ASM 	SEGMENT		CODE
RSEG		MAIN_ASM

MAIN:	
	
        ACALL	INIT                ;初始化程序     
			
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      		
		
LOOP:	
		LCALL	KEY	
		LCALL	DELAY2MS
		
		
		

		
		SJMP	LOOP
OVER:	
		
		SJMP	OVER		
		
/************************************************
函数名称 ： INIT
功    能 ： 初始化数据；
作    者 ： 佘晓凯；
摘    要 ： ；			
	
*************************************************/
		
		
		
INIT:	
		MOV		SP	,	60H			;堆栈区设置为0X60-0X7F
		MOV		MODE,	00H			;MODE初始值为0
		
		;闪烁灯初始化
		CLR		RS0					;设置第0工作区
		CLR		RS1
		MOV		R3	,	#01H		;闪烁灯初始化第一个灯闪
		MOV		A	,	R3
		MOV		R2	,	A			;将初始化值放入计数值
		
		;流水灯初始化
		CLR		RS0					;设置第1工作区
		SETB	RS1
		MOV		R3	,	250			;闪烁灯初始化每250次改变状态
		MOV		A	,	R3
		MOV		R2	,	A			;将初始化值放入计数值
		
		
		CLR		RS0					;初始化为第0工作区
		CLR		RS1
		
		
		
		MOV 	P2	,	#00H		;熄灭灯；
		
		
		RET
		
				
		
		
		
		
END



