/**
  **********************************  STC89C52  ********************************
  * @�ļ���     �� Key.asm 
  * @����       �� ������ 
  * @�ļ��汾   �� V1.0.0 
  * @����       �� 2018��02��10�� 
  * @ժҪ       �� �������� 
  ******************************************************************************/
/*----------------------------------------------------------------------------
  ������־:
  2018-02-10 V1.0.0:��ɻ������� 
  ----------------------------------------------------------------------------*/

/* ������ͷ�ļ� --------------------------------------------------------------*/
$INCLUDE (MAIN.inc)
$INCLUDE (Delay.inc)
$INCLUDE (Time.inc)


KEY_ASM 	SEGMENT		CODE
RSEG		KEY_ASM
;���� 
PUBLIC KEY

/************************************************
�������� �� Key
��    �� �� �жϰ������²�����ģʽ��ı�ģʽ״̬��
��    �� �� ��������
ժ    Ҫ �� mode1 p15 
			mode2 p16
			mode3 p17
			ʹ���ۼ���A��δ��ջ��			
	
*************************************************/
KEY:
		MOV		A	,	P1			
		ANL		A	,	#07H		;ȡ����λ��
		XRL		A	,	#07H		;ȡ����
		JZ		KEY_RETURN			;���û�а��£�return��
		ACALL	DELAY10MS			;��ʱ10���룻
		
		MOV		A	,	P1			;���10������а������£�
		ANL		A	,	#07H
		XRL		A	,	#07H 
		JZ		KEY_RETURN			;���û�а��£�return��
		;������£�
		MOV		P2	,	#00H		;�������µ�ʱ��ѵ�Ϩ�� 
		CLR		TR0					;�Ѷ�ʱ���ر� 
		;�жϰ��µİ��� 	
		CJNE	A	,	MODE	,CHANGE_MODE	;��������͵�ǰģʽ��һ������ת	
		;������ı�ģʽ 
SAMEMODE1:	
		CJNE	A	,	#01H	,	SAMEMODE2	;���Ϊģʽ1�ı���˸��λ��
		MOV		A	,	R3						;R3Ϊ��˸��λ�� 
		RL		A								;��˸��λ������ 
		MOV		R3	,	A
		MOV		COUNT,	#250					;����ֵ���� 
		SJMP	KEYUP							;ruturn
SAMEMODE2:	
		CJNE	A	,	#02H	,	SAMEMODE3	;���Ϊģʽ2
		CPL		MODE2LOR						;�ı���ˮ�Ʒ��� 
		MOV		P2	,	R2						;R2��¼��ˮ��״̬ 
		MOV		COUNT,	#250					;���ü���ֵ 
		SJMP	KEYUP							;return
		
SAMEMODE3:
		SETB	TR0								;������ʱ�� 
		CJNE	R7	,	#10H	,	INCR5		;����Ƶ������16 
		MOV		R7	,	#03H					;����3 
INCR5:	INC		R7								;�ı����Ƶ�� 
		SJMP	KEYUP							;return

;���ģʽ�ı� 
CHANGE_MODE:
		MOV		MODE,	A						;ģʽ�����ı�  
				
MODE1:	
		CLR 	TR0
		CJNE	A	,	#01H	,	MODE2	;�����Ϊģʽ1
		MOV		P2	,	R3					
		MOV		COUNT,	#250
		SJMP	KEYUP

MODE2:	
		CLR 	TR0
		CJNE	A	,	#02H	,	MODE3	;�����Ϊģʽ2
		MOV		P2	,	R2
		MOV		COUNT,	#250
		SJMP	KEYUP
											;�����Ϊģʽ3
MODE3:	
		SETB 	TR0							;������ʱ�� 
		MOV		R4	,	#20					;��ʼ������ 
		MOV		R5	,	#0					
		SETB 	TR0
		SJMP	KEYUP
		
KEYUP:
		MOV		A	,	P1			
		ANL		A	,	#07H		;ȡ����λ��
		XRL		A	,	#07H		;ȡ����
		JNZ		KEYUP				;��������ɿ���return��
		ACALL	DELAY10MS
KEY_RETURN:		
		RET	
END		