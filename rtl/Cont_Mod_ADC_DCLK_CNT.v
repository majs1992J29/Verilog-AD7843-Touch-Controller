/*

Nombre del archivo: Cont_Mod_ADC_DCLK_CNT.v

Descripción: El módulo Cont_Mod_ADC_DCLK_CNT es un contador digital 
con dos salidas de comparación. Su principal función es contar hasta 
un valor predeterminado y generar señales de control cuando alcanza 
ciertos puntos del conteo.

Parámetros:
  fin_cuenta: Valor máximo del conteo, configurado en 25.
  n: Número de bits necesarios para almacenar fin_cuenta - 1, determinado por $clog2.

Entradas:
  iCLK: Señal de reloj para el contador.
  iRST_n: Señal de reinicio activa en bajo.
  iENABLE: Habilita el conteo cuando está en alto.

Salidas:
  oTC: Se activa (1) cuando el contador alcanza fin_cuenta - 1.
  oTC_2: Se activa (1) cuando el contador alcanza la mitad de fin_cuenta - 1.

*/


module Cont_Mod_ADC_DCLK_CNT (iCLK,iRST_n,iENABLE,oTC, oTC_2);

	parameter fin_cuenta = 25;	
	parameter n	= $clog2(fin_cuenta-1); 				//determina el número de bits requeridos.
	
	input iCLK, iRST_n, iENABLE;
	output oTC;
	output oTC_2;
	
	reg [n-1:0] oCOUNT;
	
	always @(posedge iCLK)
		begin 
			if(!iRST_n)										    //reinicio sincrono, se activa en nivel bajo		
				oCOUNT <= 0;
			else
				begin
					if(iENABLE == 1'b1)										
						if(oCOUNT == fin_cuenta-1)
							oCOUNT <= 0;
						else
							oCOUNT <= oCOUNT + 1'b1;	
					else
						oCOUNT <= oCOUNT;	
				end			
		end	
	
	assign oTC   = ( oCOUNT == fin_cuenta-1)      ? 1'b1:1'b0;	
	assign oTC_2 = (oCOUNT == ((fin_cuenta-1) >> 1'b1)) ? 1'b1:1'b0;
	
endmodule
