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
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		



CallBackSon proc
	LDR R0,=Son
	LDR R1,=Index
	LDR R2,=LongueurSon
	LDR R4,=SortieSon
	LDR R3,[R1]
	;if(index<5512) then
	CMP R3,R2
	BNE els
els
		;sonBrut = Son[index];
		; 16 bit
		LDRSH R2,[R0,R3,LSL #1]
		; index++;
		ADD R3,#1
		STR R3,[R1]
		;SortieSon = mise_a_echelle(sonBrut)
		; sonBrut += 32768
		ADD R2,#32768
		; SortieSon = sonBrut /  92 ! attention conversion
		MOV R3,#92
		UDIV R2,R3
		STRH R2,[R4]
		
	;else do nothing
	bx lr
	endp
	
		
	END	