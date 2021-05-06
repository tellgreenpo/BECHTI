	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
;int VarTime =0			
VarTime	dcd 0

	export VarTime
	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc
		
		;VarTime=TimeValue
	    ldr r0,=VarTime ;r0=& VarTime		  
		ldr r1,=TimeValue ;cste donc valeur
		str r1,[r0]
		
BoucleTempo ; for(;TimeValue>0;)

		; VarTime--
		ldr r1,[r0] 				
		subs r1,#1 ;suffixe -s permet de update le flags flags Z a 1 si le resultat est 0
		str  r1,[r0]
		
		
		;BNE check le flag Z = 0
		bne	 BoucleTempo
		
		;b c'est pour sauter
		;lr est l'adresse de la prochaine instruction
		;on reviens vers le lr
		; necessite de push pop pour sous programmes
		bx lr
		endp
		
		
	END	