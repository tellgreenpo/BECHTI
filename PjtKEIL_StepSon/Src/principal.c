

#include "DriverJeuLaser.h"

extern void CallBackSon(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();


Timer_1234_Init_ff(TIM4,72*91);
	
Active_IT_Debordement_Timer(TIM4,2,CallBackSon);

PWM_Init_ff(TIM3,3,720); // Periode 100�s Frequence 100kHz

GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	

//============================================================================	
	
	
while	(1)
	{
	}
}

