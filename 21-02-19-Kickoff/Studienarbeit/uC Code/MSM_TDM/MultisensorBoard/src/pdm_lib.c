///*
 //* pdm_lib.c
 //*
 //* Created: 06.09.2017 17:06:14
 //*  Author: USER
 //*/ 
//
//#include "asf.h"
//#include "conf_board.h"
//#include "conf_spi_pdc_example.h"
//#include "delay.h"
//
//#include "pdm_lib.h"
//
///* Globally available PDMIC module struct */
//static struct pdm_instance pdm0;
//
///* Two buffers to store the PCM data */
////static int16_t audio_buffer[2][PCM_BUF_SIZE];
///* Global variable to say which of the buffers should be used */
////static uint8_t buffer_index = 0;
//
//
///* Function to setup the PDM module */
//void init_pdm(void)
//{
	///* PDM configuration structure / PDM Interface Controller 0 - */
	//struct pdm_config conf_pdmic0;
	///* Get default configuration */
	//pdm_get_config_default(&conf_pdmic0);
	///* Prescaler for 1 MHz PDM clock */
	//conf_pdmic0.prescal = PDM_PRESCALER;
	///* Set gain to 1 - if not, all conversions are 0 */
	//conf_pdmic0.gain = 1;
	///* Oversampling ratio */
	//conf_pdmic0.oversampling_ratio = PDMIC_OVERSAMPLING_RATIO_64;
	///* Data size */
	//conf_pdmic0.conver_data_size = PDMIC_CONVERTED_DATA_SIZE_16;
	///* Initialize PDMIC0 with configuration */
	//pdm_init(&pdm0, PDMIC0, &conf_pdmic0);	
	//
	//// 	/* PDM Interface Controller 1 -  */
	//// 	struct pdm_config conf_pdmic1;
	//// 	pdm_get_config_default(&conf_pdmic1);
	//// 	conf_pdmic1.prescal = PDM_PRESCALER;
	//// 	conf_pdmic1.gain = 1;
	//// 	conf_pdmic1.oversampling_ratio = PDMIC_OVERSAMPLING_RATIO_64;
	//// 	conf_pdmic1.conver_data_size = PDMIC_CONVERTED_DATA_SIZE_16;
	//// 	pdm_init(&pdm1, PDMIC1, &conf_pdmic1);
	//
	///* PDM Interrupts */
////Auskommentiert am 3.8.17
	//NVIC_DisableIRQ(PDMIC0_IRQn);
	//NVIC_ClearPendingIRQ(PDMIC0_IRQn);
	//NVIC_SetPriority(PDMIC0_IRQn, PDM_INTERRUPT_PRIORITY);
	//NVIC_EnableIRQ(PDMIC0_IRQn);	
///*	// 	NVIC_DisableIRQ(PDMIC1_IRQn);
	//// 	NVIC_ClearPendingIRQ(PDMIC1_IRQn);
	//// 	NVIC_SetPriority(PDMIC1_IRQn, 0);
	//// 	NVIC_EnableIRQ(PDMIC1_IRQn);	
	//pdm_enable_interrupt(&pdm0, PDMIC_INTERRUPT_SRC_DATA_READY);
	////	pdm_enable_interrupt(&pdm1, PDMIC_INTERRUPT_SRC_DATA_READY);
//*/	
//}
//
//void enable_pdm(void)
//{	
	///* Enable PDM module */
	//pdm_enable(&pdm0);	
//}