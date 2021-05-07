	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
;On declare variable globale
SortieSon DCW 0 ; 16 bit
Index DCD 0 ;32bit
	EXPORT SortieSon
		
	IMPORT Son
	IMPORT LongueurSon
	IMPORT PeriodeSonMicroSec
	
; ===============================================================================================
	

	EXPORT CallBackSon
	EXPORT StartSon
		
	INCLUDE ./Driver/DriverJeuLaser.inc
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		



CallBackSon proc
	PUSH{LR,R4}
	LDR R1,=Index
	LDR R0,=LongueurSon
	LDR R3,[R1]
	LDR R2,[R0]
	;if(index<5512) then
	CMP R3,R2
	BHS finsi

; inferieur
els
		;sonBrut = Son[index];
		; 16 bit
		LDR R2,=Son
		LDR R4,=SortieSon
		LDRSH R0,[R2,R3,LSL #1]
		; index++;
		ADD R3,#1
		STR R3,[R1]
		;SortieSon = mise_a_echelle(sonBrut)
		; sonBrut += 32768
		ADD R0,#32768
		; SortieSon = sonBrut /  92 ! attention conversion
		MOV R3,#92
		UDIV R0,R3
		STRH R0,[R4]
		bl PWM_Set_Value_TIM3_Ch3
		
finsi ;superieur
	POP {PC,R4}


	endp
		
StartSon proc
	LDR R0,=Index
	MOV R1,#0
	STR R1,[R0]
	bx lr
	endp
		
	END	