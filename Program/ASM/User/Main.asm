$INCLUDE (Main.inc)
$INCLUDE (Delay.inc)
$INCLUDE (Key.inc)
ORG 00H
LJMP	MAIN

MAIN_ASM 	SEGMENT		CODE
RSEG		MAIN_ASM

MAIN:	
	
        ACALL	INIT                ;��ʼ������     
			
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      		
		
LOOP:	
		LCALL	KEY	
		LCALL	DELAY2MS
		
		
		

		
		SJMP	LOOP
OVER:	
		
		SJMP	OVER		
		
/************************************************
�������� �� INIT
��    �� �� ��ʼ�����ݣ�
��    �� �� ��������
ժ    Ҫ �� ��			
	
*************************************************/
		
		
		
INIT:	
		MOV		SP	,	60H			;��ջ������Ϊ0X60-0X7F
		MOV		MODE,	00H			;MODE��ʼֵΪ0
		
		;��˸�Ƴ�ʼ��
		CLR		RS0					;���õ�0������
		CLR		RS1
		MOV		R3	,	#01H		;��˸�Ƴ�ʼ����һ������
		MOV		A	,	R3
		MOV		R2	,	A			;����ʼ��ֵ�������ֵ
		
		;��ˮ�Ƴ�ʼ��
		CLR		RS0					;���õ�1������
		SETB	RS1
		MOV		R3	,	250			;��˸�Ƴ�ʼ��ÿ250�θı�״̬
		MOV		A	,	R3
		MOV		R2	,	A			;����ʼ��ֵ�������ֵ
		
		
		CLR		RS0					;��ʼ��Ϊ��0������
		CLR		RS1
		
		
		
		MOV 	P2	,	#00H		;Ϩ��ƣ�
		
		
		RET
		
				
		
		
		
		
END



