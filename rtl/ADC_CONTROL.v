/*

Nombre del archivo: ADC_CONTROL.v
Descripción: El módulo ADC_CONTROL sirve como un controlador para un 
ADC, coordinando la lectura de datos y la generación de señales de control 
y de reloj. Utiliza varios submódulos para llevar a cabo estas tareas.
 La lógica de control parece estar dividida entre estos submódulos, 
 con control_FSM manejando el estado general, mientras que los contadores 
 y generadores manejan aspectos específicos del tiempo y señales.
Inputs y Outputs:

 iCLK, iRST_n: Señales de reloj y reset, comunes en diseño digital.
 iADC_PENIRQ_n, iADC_BUSY, iADC_DOUT: Entradas relacionadas con el ADC, 
 indicando interrupciones, estado de ocupado, y datos de salida del ADC.
 oSCEN, oADC_DIN, oADC_DCLK: Controlan la comunicación con el ADC.
 oX_COORD, oY_COORD: Salidas para las coordenadas X e Y, del dato leído del ADC.

Parámetros y Cálculos:

 SYSCLK_FRQ, ADC_DCLK_FRQ: Frecuencias para el reloj del sistema y del ADC.
 ADC_DCLK_CNT: Cálculo para determinar el conteo necesario en base a las frecuencias

*/

module ADC_CONTROL(
					iCLK,
					iRST_n,
					oADC_DIN,
					oADC_DCLK,
					oSCEN,
					iADC_DOUT,
					iADC_BUSY,
					iADC_PENIRQ_n,
					oX_COORD,
					oY_COORD
					);
					
	parameter SYSCLK_FRQ		= 50000000;
	parameter ADC_DCLK_FRQ	= 70000; 
	parameter ADC_DCLK_CNT	= SYSCLK_FRQ/(ADC_DCLK_FRQ*2);


	input iCLK, iRST_n, iADC_PENIRQ_n, iADC_BUSY, iADC_DOUT;
	
	output  oSCEN;
	output  oADC_DIN;
	output  oADC_DCLK;
	
	output  [11:0] oX_COORD;
	output  [11:0] oY_COORD;
	
	wire trans_en;
	wire trans_eof;
	wire half_dclk;
	wire dclk;
	wire fin_80;
	
	wire [6:0] count_80;
	

	/* CONTROL FSM */
	control_FSM control_FSM_inst
	(
		.iCLK(iCLK) ,								// input  iCLK_sig
		.iRST_n(iRST_n) ,							// input  iRST_n_sig
		.iENABLE_1(dclk) ,						// input  iENABLE_1_sig
		.iENABLE_2(fin_80) ,						// input  iENABLE_2_sig
		.iADC_PENIRQ_n(iADC_PENIRQ_n) ,		// input  iADC_PENIRQ_n_sig
		.oADC_CS(oSCEN) ,							// output  oADC_CS_sig
		.oEna_trans(trans_en) ,					// output  oEna_trans_sig
		.oFin_trans(trans_eof) 					// output  oFin_trans_sig
	);

	
	defparam Cont_Mod_ADC_DCLK_CNT_inst.fin_cuenta = 25;
	/* CONTADOR MODULO: ADC_DCLK_CNT */
	Cont_Mod_ADC_DCLK_CNT Cont_Mod_ADC_DCLK_CNT_inst
	(
		.iCLK(iCLK) ,				// input  iCLK_sig
		.iRST_n(iRST_n) ,			// input  iRST_n_sig
		.iENABLE(trans_en) ,		// input  iENABLE_sig
		.oTC(dclk) ,				// output  oTC_sig
		.oTC_2(half_dclk) 		// output  oTC_2_sig
	);

	/* CONTADOR MODULO 80 */
	count_mod_80 count_mod_80_inst
	(
		.iCLK(iCLK) ,				// input  iCLK_sig
		.iRST_n(iRST_n) ,			// input  iRST_n_sig
		.iENABLE(dclk) ,			// input  iENABLE_sig
		.oCOUNT(count_80) ,		// output [n-1:0] oCOUNT_sig
		.oTC(fin_80) 				// output  oTC_sig
	);

	defparam count_mod_80_inst.fin_cuenta = 80;
	
	/* GENERADOR: ADC_DCLK */
	Gen_ADC_DCLK Gen_ADC_DCLK_inst
	(
		.iCLK(iCLK) ,				// input  iCLK_sig
		.iRST_n(iRST_n) ,			// input  iRST_n_sig
		.iENABLE(dclk) ,			// input  iENABLE_sig
		.oADC_DCLK(oADC_DCLK) 	// output  oADC_DCLK_sig
	);
	defparam Gen_ADC_DCLK_inst.fin_cuenta = 2;

	/* GENERADOR: ADC_DIN */
	Gen_ADC_DIN Gen_ADC_DIN_inst
	(
		.iCLK(iCLK) ,				// input  iCLK_sig
		.iRST_n(iRST_n) ,			// input  iRST_n_sig
		.iENABLE(trans_en) ,		// input  iENABLE_sig
		.iCOUNT(count_80) ,		// input [6:0] iCOUNT_sig
		.oADC_DIN(oADC_DIN) 		// output oADC_DIN_sig
	);

	
	/* GENERADOR: ADC_DOUT */
	Gen_ADC_DOUT Gen_ADC_DOUT_inst
	(
		.iCLK(iCLK) ,					// input  iCLK_sig
		.iRST_n(iRST_n) ,				// input  iRST_n_sig
		.iENABLE_1(trans_en) ,		// input  iENABLE_1_sig
		.iENABLE_2(half_dclk) ,		// input  iENABLE_2_sig
		.iCOUNT(count_80) ,			// input [6:0] iCOUNT_sig
		.iADC_DOUT(iADC_DOUT) ,		// input  iADC_DOUT_sig
		.oX_COORD(oX_COORD) ,		// output [11:0] oX_COORD_sig
		.oY_COORD(oY_COORD) 			// output [11:0] oY_COORD_sig
	);

endmodule




