/*

Nombre del archivo: count_mod_80.v
Descripción: El módulo count_mod_80 es un contador síncrono con capacidad
 para contar hasta 80. Este contador incrementa su valor en cada flanco 
 positivo del reloj iCLK, siempre que esté habilitado por iENABLE y 
 no se encuentre en estado de reinicio.

Entradas:
  iCLK: Reloj del sistema.
  iRST_n: Señal de reinicio, activa en bajo.
  iENABLE: Señal de habilitación del contador.

Salidas:
  oCOUNT: Valor actual del contador, de 7 bits.
  oTC (Terminal Count): Señal que indica cuando el contador ha alcanzado 
  su valor máximo (79 en este caso).

Parámetros:
  fin_cuenta = 80: Define el límite superior del contador.
  n = $clog2(fin_cuenta-1): Calcula el número mínimo de bits necesarios 
  para representar fin_cuenta - 1. Sin embargo, este cálculo no se utiliza directamente, 
  ya que oCOUNT está definido como un registro de 7 bits ([6:0]).

*/

module count_mod_80 (iCLK,iRST_n,iENABLE, oCOUNT, oTC);

	parameter fin_cuenta = 80;	
	parameter n	= $clog2(fin_cuenta-1); 				//determina el número de bits requeridos.
	
	input  iCLK, iRST_n, iENABLE;
	output reg [n-1:0] oCOUNT;
	output oTC;
	
	always @(posedge iCLK)
		begin
			if(!iRST_n)										  		//reinicio sincrono, se activa en nivel bajo
				oCOUNT <= {n{1'b0}};
			else
				if(iENABLE == 1'b1)			 
					if(oCOUNT == fin_cuenta-1)
						oCOUNT <= {n{1'b0}};
					else
						oCOUNT <= oCOUNT + 1'b1;	
				else 
					oCOUNT <= oCOUNT;		
		end			
	
	assign oTC   = (oCOUNT == fin_cuenta-1) ? 1'b1:1'b0;	
	
endmodule
