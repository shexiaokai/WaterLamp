/**
  **********************************  STC89C52  ********************************
  * @文件名     ： Key.asm 
  * @作者       ： 佘晓凯 
  * @文件版本   ： V1.0.0 
  * @日期       ： 2018年02月10日 
  * @摘要       ： 按键部分 
  ******************************************************************************/
/*----------------------------------------------------------------------------
  更新日志:
  2018-02-10 V1.0.0:完成基本部分 
  ----------------------------------------------------------------------------*/

/* 包含的头文件 --------------------------------------------------------------*/
$INCLUDE (MAIN.inc)
$INCLUDE (Delay.inc)
$INCLUDE (Time.inc)


KEY_ASM 	SEGMENT		CODE
RSEG		KEY_ASM
;函数 
PUBLIC KEY

/************************************************
函数名称 ： Key
功    能 ： 判断按键按下并设置模式或改变模式状态；
作    者 ： 佘晓凯；
摘    要 ： mode1 p15 
			mode2 p16
			mode3 p17
			使用累加器A，未堆栈；			
	
*************************************************/
KEY:
		MOV		A	,	P1			
		ANL		A	,	#07H		;取后三位；
		XRL		A	,	#07H		;取反；
		JZ		KEY_RETURN			;如果没有按下，return；
		ACALL	DELAY10MS			;延时10毫秒；
		
		MOV		A	,	P1			;如果10毫秒后还有按键按下；
		ANL		A	,	#07H
		XRL		A	,	#07H 
		JZ		KEY_RETURN			;如果没有按下，return；
		;如果按下；
		MOV		P2	,	#00H		;按键按下的时候把灯熄灭 
		CLR		TR0					;把定时器关闭 
		;判断按下的按键 	
		CJNE	A	,	MODE	,CHANGE_MODE	;如果按键和当前模式不一样，跳转	
		;如果不改变模式 
SAMEMODE1:	
		CJNE	A	,	#01H	,	SAMEMODE2	;如果为模式1改变闪烁灯位置
		MOV		A	,	R3						;R3为闪烁灯位置 
		RL		A								;闪烁灯位置左移 
		MOV		R3	,	A
		MOV		COUNT,	#250					;计数值重置 
		SJMP	KEYUP							;ruturn
SAMEMODE2:	
		CJNE	A	,	#02H	,	SAMEMODE3	;如果为模式2
		CPL		MODE2LOR						;改变流水灯方向 
		MOV		P2	,	R2						;R2纪录流水灯状态 
		MOV		COUNT,	#250					;重置计数值 
		SJMP	KEYUP							;return
		
SAMEMODE3:
		SETB	TR0								;开启定时器 
		CJNE	R7	,	#10H	,	INCR5		;呼吸频率上限16 
		MOV		R7	,	#03H					;下限3 
INCR5:	INC		R7								;改变呼吸频率 
		SJMP	KEYUP							;return

;如果模式改变 
CHANGE_MODE:
		MOV		MODE,	A						;模式变量改变  
				
MODE1:	
		CLR 	TR0
		CJNE	A	,	#01H	,	MODE2	;如果改为模式1
		MOV		P2	,	R3					
		MOV		COUNT,	#250
		SJMP	KEYUP

MODE2:	
		CLR 	TR0
		CJNE	A	,	#02H	,	MODE3	;如果改为模式2
		MOV		P2	,	R2
		MOV		COUNT,	#250
		SJMP	KEYUP
											;如果改为模式3
MODE3:	
		SETB 	TR0							;开启定时器 
		MOV		R4	,	#20					;初始化数据 
		MOV		R5	,	#0					
		SETB 	TR0
		SJMP	KEYUP
		
KEYUP:
		MOV		A	,	P1			
		ANL		A	,	#07H		;取后三位；
		XRL		A	,	#07H		;取反；
		JNZ		KEYUP				;如果按键松开，return；
		ACALL	DELAY10MS
KEY_RETURN:		
		RET	
END		