	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		

;char FlagCligno
; DCB pour 8 bit
FlagCligno DCD 0
	
	EXPORT FlagCligno

	
; ===============================================================================================
	
	EXPORT timer_callback
	
	INCLUDE ./Driver/DriverJeuLaser.inc

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

;char FlagCligno;

;void timer_callback(void)
;{
;	if (FlagCligno==1)
;	{
;		FlagCligno=0;
;		GPIOB_Set(1);
;	}
;	else
;	{
;		FlagCligno=1;
;		GPIOB_Clear(1);
;	}
;		
;}

timer_callback proc
	PUSH {LR}
		;if (FlagCligno==1)
		LDR R1,=FlagCligno ;LDRB pour 8 bit
		LDR R0,[R1]
		CMP R0,#1
		BNE els
	;then
		; FlagCligno = 0
		MOV R0,#0
		STR R0,[R1]
		;GPIOB_Set(1);
		MOV R0,#1
		; attention pour R0 a R3 qui peuvent etre cramer
		; Push ces registres
		bl GPIOB_Set;

		
		B finsi
	;else
els
		; FlagCligno = 1
		MOV R0,#1
		STR R0,[R1]
		;GPIOB_Set(0)
		MOV R0,#1

		bl GPIOB_Clear;

finsi
		
		;pop lr
		;BX LR
		pop {pc}
		
		
		ENDP
	END	