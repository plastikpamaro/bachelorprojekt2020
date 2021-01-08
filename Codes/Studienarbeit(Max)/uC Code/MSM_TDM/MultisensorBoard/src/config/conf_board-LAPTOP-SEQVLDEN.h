/**
 * \file
 *
 * \brief Board configuration.
 *
 * Copyright (c) 2014-2015 Atmel Corporation. All rights reserved.
 *
 * \asf_license_start
 *
 * \page License
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of Atmel may not be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * 4. This software may only be redistributed and used in connection with an
 *    Atmel microcontroller product.
 *
 * THIS SOFTWARE IS PROVIDED BY ATMEL "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT ARE
 * EXPRESSLY AND SPECIFICALLY DISCLAIMED. IN NO EVENT SHALL ATMEL BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * \asf_license_stop
 *
 */
/*
 * Support and FAQ: visit <a href="http://www.atmel.com/design-support/">Atmel Support</a>
 */

#ifndef CONF_BOARD_H_INCLUDED
#define CONF_BOARD_H_INCLUDED

/** Use TC Peripheral defines **/
#define TC             TC0
#define TC_PERIPHERAL  0

#define TC_CHANNEL_WAVEFORM_1		1
#define ID_TC_WAVEFORM_1			ID_TC1
#define PIN_TC_WAVEFROM_B_1			IOPORT_CREATE_PIN(PIOA, 16)
#define PIN_TC_WAVEFOEM_B_MUX_1		IOPORT_MODE_MUX_B	


#define TC_CHANNEL_WAVEFORM			2
#define ID_TC_WAVEFORM				ID_TC2
#define PIN_TC_WAVEFORM_A			IOPORT_CREATE_PIN(PIOA, 21)
#define PIN_TC_WAVEFORM_A_MUX		IOPORT_MODE_MUX_A

#define PIN_TC_WAVEFORM_B			IOPORT_CREATE_PIN(PIOA, 22)
#define PIN_TC_WAVEFORM_B_MUX		IOPORT_MODE_MUX_A

#define PIN_TC_WAVEFORM_XCLK		IOPORT_CREATE_PIN(PIOA, 19)
#define PIN_TC_WAVEFORM_XCLK_MUX	IOPORT_MODE_MUX_A

#define PIN_TC_WAVEFORM_XTRIG		IOPORT_CREATE_PIN(PIOA, 20)
#define PIN_TC_WAVEFORM_XCLK_MUX	IOPORT_MODE_MUX_A


/* Enable PDM pins */
#define CONF_BOARD_PDM

/** Enable Com Port. */
#define CONF_BOARD_UART_CONSOLE

/** Definition of TWI interrupt ID on board. */
#define BOARD_TWI_IRQn          TWI4_IRQn
#define BOARD_TWI_Handler    TWI4_Handler

/** Use TC1_Handler for TC capture interrupt**/
#define TC_Handler  TC1_Handler
#define TC_IRQn     TC1_IRQn


/** Configure TWI4 pins */
#define CONF_BOARD_TWI4

/** Flexcom application to use */
#define BOARD_FLEXCOM_TWI          FLEXCOM4

/** SPI MACRO definition */
#define CONF_BOARD_SPI

/** SPI slave select MACRO definition */
#define CONF_BOARD_SPI_NPCS0

/** Spi Hw ID . */
#define SPI_ID          ID_SPI5

/** SPI base address for SPI master mode*/
#define SPI_MASTER_BASE      SPI5
/** SPI base address for SPI slave mode, (on different board) */
#define SPI_SLAVE_BASE       SPI5
/** FLEXCOM base address for SPI mode*/
#define BOARD_FLEXCOM_SPI    FLEXCOM5

#define USART_INTERRUPT_PRIORITY	1
#define PDM_INTERRUPT_PRIORITY		2
#define TIMER_INTERRUPT_PRIORITY	3
#define TWI1_INTERRUPT_PRIORITY		4

#endif /* CONF_BOARD_H_INCLUDED */
