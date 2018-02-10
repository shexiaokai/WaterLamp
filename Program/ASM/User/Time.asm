/**
  **********************************  STC89C52  ********************************
  * @文件名     ： Time.asm 
  * @作者       ： 佘晓凯 
  * @文件版本   ： V1.0.0 
  * @日期       ： 2018年02月10日 
  * @摘要       ： 定时器初始化及其中断函数 
  ******************************************************************************/
/*----------------------------------------------------------------------------
  更新日志:
  2018-02-10 V1.0.0:完成基本部分 
  ----------------------------------------------------------------------------*/

/* 包含的头文件 --------------------------------------------------------------*/

$INCLUDE (Main.inc)



TIME_ASM 	SEGMENT		CODE
RSEG		TIME_ASM

PUBLIC TIME_INIT,TIME0_INTERRUPT
/************************************************
函数名称 ： TIME_INIT
功    能 ： 定时器寄存器初始化 
作    者 ： 佘晓凯 
摘    要 ： 无			
	
*************************************************/
TIME_INIT:
	MOV 	TMOD,	#01H
    MOV 	TH0	,	#0FFH
    MOV 	TL0	,	#48H
    SETB 	ET0
	SETB 	EA
    ;SETB TR0
    RET

/************************************************
函数名称 ： TIME0_INTERRUPT
功    能 ： 定时器中断函数，输出pwm 
作    者 ： 佘晓凯；
使用缓存 ： R4、R5、R6、R7、COUNT（0x32）、AOD（bit 0x01） 
摘    要 ： 定时2ms				
	
*************************************************/	
TIME0_INTERRUPT:
	
	PUSH 	ACC
	PUSH	PSW
    MOV 	TH0	,	#0FFH				;计数器置数；
    MOV 	TL0	,	#48H
	MOV		A	,	R4					;比计较r4,r5输出0，确定pwm占空比；
	CJNE	A	,	05H	,	R4R5DEF		;如果r4=r5，输出0，在r4为20的时候输出1
	CLR		P2.0						;制造周期为10ms的pwm，r5控制占空比；
R4R5DEF:
	DJNZ	R4	,	TIME0_RETURN		;r4计数，每20个中断进入设置；
T20:									;每20次中断 
	MOV		R4	,	#20					;重置R4 
	SETB	P2.0						;复位端口 
	
	DJNZ	R6	,	TIME0_RETURN		;每（R7）个周期r6表示当前周期数 
TR6:
	MOV		R6	,	07H					;用R7重置R6
	CJNE	R5	,	#20	,	IFR5SAM0	;改变PWM占空比的增减 
	SETB	AOD
IFR5SAM0:	
	CJNE	R5	,	#00H	,	R5DEF0	
	CLR		AOD
R5DEF0:	
	JB		AOD	,	DECR5
INCR5:	INC		R5
		SJMP	TIME0_RETURN
DECR5:	DEC		R5

TIME0_RETURN:
	POP		PSW
	POP		ACC
	RETI


END