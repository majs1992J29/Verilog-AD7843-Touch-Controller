/*

Nombre del archivo: Gen_ADC_DIN.v

Descripción: El módulo Gen_ADC_DIN es responsable de generar la secuencia 
de datos de entrada (oADC_DIN) para un Convertidor Analógico a Digital (ADC). 
Esta secuencia se utiliza para configurar y controlar el funcionamiento del ADC.

Entradas:
  iCLK: Reloj del sistema.
  iRST_n: Señal de reinicio, activa en bajo.
  iENABLE: Señal de habilitación.
  iCOUNT: Contador que determina la secuencia de datos a enviar.

Salida:
  oADC_DIN: Dato de entrada para el ADC.


*/



module Gen_ADC_DIN (iCLK,iRST_n,iENABLE,iCOUNT, oADC_DIN);

	input iCLK, iRST_n, iENABLE;
	input [6:0] iCOUNT;
	
	output reg oADC_DIN;
	
	always @(posedge iCLK)
		if (!iRST_n) 
			begin
				oADC_DIN = 1'b0; 
			end 
		else begin
			if (iENABLE == 1'b1) 
				begin			
					case(iCOUNT)
					 // para el eje X
						0:  oADC_DIN = 1;	// S
						1:	 oADC_DIN = 1; // S
						2:	 oADC_DIN = 0;	// A2
						3:	 oADC_DIN = 0;	// A2
						4:  oADC_DIN = 0;	// A1
						5:  oADC_DIN = 0;	// A1
						6:  oADC_DIN = 1;	// A0
						7:  oADC_DIN = 1;	// A0
						8:  oADC_DIN = 0;	// MODE
						9:  oADC_DIN = 0;	// MODE
						10: oADC_DIN = 0; // SER/__DEF
						11: oADC_DIN = 0;	// SER/__DEF
						12: oADC_DIN = 1;	// PD1
						13: oADC_DIN = 1;	// PD1
						14: oADC_DIN = 0;	// PD0
						15: oADC_DIN = 0; // PD0
						
						// Conversion
						16: oADC_DIN = 0;
						17: oADC_DIN = 0;
						18: oADC_DIN = 0;
						19: oADC_DIN = 0;
						20: oADC_DIN = 0;
						21: oADC_DIN = 0;
						22: oADC_DIN = 0;
						23: oADC_DIN = 0;
						24: oADC_DIN = 0;
						25: oADC_DIN = 0;
						26: oADC_DIN = 0;
						27: oADC_DIN = 0;
						28: oADC_DIN = 0;
						29: oADC_DIN = 0;
						30: oADC_DIN = 0;
						31: oADC_DIN = 0;
						
						 // para el eje Y
						32: oADC_DIN = 1;	// S
						33: oADC_DIN = 1;	// S
						34: oADC_DIN = 1; // A2
						35: oADC_DIN = 1;	// A2
						36: oADC_DIN = 0;	// A1
						37: oADC_DIN = 0;	// A1
						38: oADC_DIN = 1;	// A0
						39: oADC_DIN = 1;	// A0
						40: oADC_DIN = 0;	// MODE
						41: oADC_DIN = 0;	// MODE
						42: oADC_DIN = 0;	// SER/__DEF
						43: oADC_DIN = 0;	// SER/__DEF
						44: oADC_DIN = 1;	// PD1
						45: oADC_DIN = 1;	// PD1
						46: oADC_DIN = 0;	// PD0
						47: oADC_DIN = 0; // PD0
					
						default:
							oADC_DIN = 1'b0; 
					endcase
				end 
		end
				
endmodule
