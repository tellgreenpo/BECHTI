

#include "DriverJeuLaser.h"

extern void CallBackSon(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();


Timer_1234_Init_ff(TIM4,72*91);
	
Active_IT_Debordement_Timer(TIM4,2,CallBackSon);

PWM_Init_ff(TIM3,3,720); // Periode 100µs Frequence 100kHz

GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	

//============================================================================	
	
	
while	(1)
	{
	}
}

