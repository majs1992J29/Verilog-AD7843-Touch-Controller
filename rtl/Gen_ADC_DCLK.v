/*

Nombre del archivo: Gen_ADC_DCLK.v

Descripción: El módulo Gen_ADC_DCLK es un generador de reloj para un 
ADC (Convertidor Analógico a Digital) basado en un contador síncrono. 
Este módulo divide la frecuencia del reloj de entrada por un factor 
determinado para generar el reloj del ADC (oADC_DCLK).

Entradas:
  iCLK: Reloj del sistema.
  iRST_n: Señal de reinicio, activa en bajo.
  iENABLE: Señal de habilitación.

Salida:
  oADC_DCLK: Reloj generado para el ADC.

Parámetros:
  fin_cuenta = 2: Define el límite superior del contador.
  n = $clog2(fin_cuenta-1): Calcula el número mínimo de bits necesarios 
  para representar fin_cuenta - 1. En este caso, n será 1.


*/


module Gen_ADC_DCLK (iCLK,iRST_n,iENABLE,oADC_DCLK);

	parameter fin_cuenta = 2;	
	parameter n	= $clog2(fin_cuenta-1); 				//determina el número de bits requeridos.
	
	input iCLK, iRST_n, iENABLE;
	output oADC_DCLK;
	
	reg [n-1:0] oCOUNT;
	
	always @(posedge iCLK)
		begin
			if(!iRST_n)										    //reinicio sincrono, se activa en nivel bajo		
				oCOUNT <= 0;//{n-1{1'b0}};
			else		
				if(iENABLE == 1'b1)										
					if(oCOUNT == fin_cuenta-1)
						oCOUNT <= 0;//{n-1{1'b0}};
					else
						oCOUNT <= oCOUNT + 1'b1;				
		end 				
	assign oADC_DCLK   = (oCOUNT == fin_cuenta-1) ? 1'b1:1'b0;	

endmodule
