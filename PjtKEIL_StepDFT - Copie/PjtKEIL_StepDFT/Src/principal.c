#include "DriverJeuLaser.h"


extern void StartSon(void);
extern int DFT_ModuleAuCarre(short int * Signal64ech, char k);
extern short int LeSignal[];
int tab[64];
short int dma_buf[64];
int cpt_callback = 0;
int seuil = 0x056A8C;
int score[6] = {0,0,0,0,0,0};
void callback_Systick(void) {
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	
	cpt_callback++;
	
	int i;
	for (i=0;i<64;i++){
		tab[i] = DFT_ModuleAuCarre(dma_buf,i);
		}
	
	/* COMPTEUR POUR LE JOUEUR 1 */ 
	if (tab[17] > seuil && cpt_callback > 19){
		score[0] += 1;
		StartSon();
		cpt_callback = 0;
	}
	
	/* COMPTEUR POUR LE JOUEUR 2 */ 
	if (tab[18] > seuil && cpt_callback > 19){
		score[1] += 1;
		StartSon();
		cpt_callback = 0;
	}
	
	/* COMPTEUR POUR LE JOUEUR 3 */ 
	if (tab[19] > seuil && cpt_callback > 19){
		score[2] += 1;
		StartSon();
		cpt_callback = 0;
	}
	
	/* COMPTEUR POUR LE JOUEUR 4 */ 
	if (tab[20] > seuil && cpt_callback > 19){
		score[3] += 1;
		StartSon();
		cpt_callback = 0;
	}
	
	/* COMPTEUR POUR LE JOUEUR 5 */ 
	if (tab[23] > seuil && cpt_callback > 19){
		score[4] += 1;
		StartSon();
		cpt_callback = 0;
	}
	
	/* COMPTEUR POUR LE JOUEUR 6 */ 
	if (tab[24] > seuil && cpt_callback > 19){
		score[5] += 1;
		StartSon();
		cpt_callback = 0;
	}
}



int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
	
Systick_Period_ff(360000);
	
Systick_Prio_IT(1, callback_Systick);

SysTick_On ;

SysTick_Enable_IT ;	

Init_TimingADC_ActiveADC_ff( ADC1, 72 );

Single_Channel_ADC( ADC1, 2 );
	
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );

Init_ADC1_DMA1(0,dma_buf);



	
//============================================================================	
	

while	(1)
	{
	}
}

