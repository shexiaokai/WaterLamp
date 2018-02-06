/**
  **********************************  CC2530  **********************************
  * @文件名     ： Key.asm;
  * @作者       ： 佘晓凯;
  * @文件版本   ： V1.0.0;
  * @日期       ： 2018年02月05日;
  * @摘要       ： 按键部分;
  ******************************************************************************/
/*----------------------------------------------------------------------------
  更新日志:
  2018-01-25 V1.0.0:
  ----------------------------------------------------------------------------*/

/* 包含的头文件 --------------------------------------------------------------*/
$INCLUDE (MAIN.inc)
$INCLUDE (Delay.inc)



KEY_ASM 	SEGMENT		CODE
RSEG		KEY_ASM

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
		MOV		P1	,	#00H
			
		CJNE	A	,	MODE	,CHANGE_MODE	;如果按键和当前模式不一样，跳转	
		;如果不改变模式；
		
		
CHANGE_MODE:
		MOV		MODE,	A
		
		
MODE1:	
		CJNE	A	,	#01H	,	MODE2	;如果为模式1
		CLR		RS0					;设置第0工作区;
		CLR		RS1
		SJMP	KEYUP

MODE2:	
		CJNE	A	,	#02H	,	MODE3	;如果为模式2
		CLR		RS0					;设置第1工作区;
		SETB	RS1
		SJMP	KEYUP
		
MODE3:	
		SETB	RS0					;设置第2工作区;
		CLR		RS1
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