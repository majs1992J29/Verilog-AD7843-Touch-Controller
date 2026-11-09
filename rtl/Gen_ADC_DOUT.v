/*

Nombre del archivo: Gen_ADC_DOUT.v

Descripción: El módulo Gen_ADC_DOUT está diseñado para procesar la salida 
de un Convertidor Analógico a Digital (ADC) y almacenar los resultados 
en dos registros: oX_COORD y oY_COORD. Estos registros representan las 
coordenadas X e Y, de un sistema de entrada  táctil.

Entradas:
  iCLK: Reloj del sistema.
  iRST_n: Señal de reinicio, activa en bajo.
  iENABLE_1 y iENABLE_2: Señales de habilitación para controlar la lectura de los datos.
  iCOUNT: Contador que determina en qué parte del proceso de lectura se encuentra el sistema.
  iADC_DOUT: Dato de salida del ADC.

Salidas:
  oX_COORD: Registro de 12 bits para almacenar la coordenada X.
  oY_COORD: Registro de 12 bits para almacenar la coordenada Y.


*/



module Gen_ADC_DOUT (iCLK,iRST_n,iENABLE_1,iENABLE_2,iCOUNT, iADC_DOUT, oX_COORD,oY_COORD);

	input iCLK, iRST_n, iENABLE_1,iENABLE_2;
	input [6:0] iCOUNT;
	input iADC_DOUT;
	
	output reg [11:0] oX_COORD;
	output reg [11:0] oY_COORD;
	
	always@(posedge iCLK, negedge iRST_n)	
		if (!iRST_n) 
			begin
				oX_COORD = {12{1'b0}};
				oY_COORD = {12{1'b0}};
			end 
		else begin
			if (iENABLE_1 == 1'b1) 
				begin			
					case(iCOUNT)	
//						18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40: oX_COORD[11:0] <= (iENABLE_2) ? {iADC_DOUT, oX_COORD[11:1]} : oX_COORD;
//						50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72: oY_COORD[11:0] <= (iENABLE_2) ? {iADC_DOUT, oY_COORD[11:1]} : oY_COORD;
						// x coord
						18: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[11] = iADC_DOUT; 
								else 
									oX_COORD[11] = oX_COORD[11];
							 end
						20: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[10] = iADC_DOUT; 
								else 
									oX_COORD[10] = oX_COORD[10];
							 end
						22: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[9]  = iADC_DOUT; 
								else 
									oX_COORD[9]  = oX_COORD[9];
							 end
						24: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[8]  = iADC_DOUT; 
								else 
									oX_COORD[8]  = oX_COORD[8];
							 end
						26: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[7]  = iADC_DOUT; 
								else 
									oX_COORD[7]  = oX_COORD[7];
							 end
						28: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[6]  = iADC_DOUT; 
								else 
									oX_COORD[6]  = oX_COORD[6];
							 end
						30: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[5]  = iADC_DOUT; 
								else 
									oX_COORD[5]  = oX_COORD[5];
							 end
						32: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[4]  = iADC_DOUT; 
								else 
									oX_COORD[4]  = oX_COORD[4];
							 end
						34: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[3]  = iADC_DOUT; 
								else 
									oX_COORD[3]  = oX_COORD[3];
							 end
						36: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[2]  = iADC_DOUT; 
								else 
									oX_COORD[2]  = oX_COORD[2];
							 end
						38: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[1]  = iADC_DOUT; 
								else 
									oX_COORD[1]  = oX_COORD[1];
							 end
						40: begin 
								if(iENABLE_2 == 1'b1) 
									oX_COORD[0]  = iADC_DOUT; 
								else 
									oX_COORD[0]  = oX_COORD[0];
							 end
						
						
						// y coord
						50: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[11] = iADC_DOUT; 
								else 
									oY_COORD[11] = oY_COORD[11];
							 end
						52: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[10] = iADC_DOUT; 
								else 
									oY_COORD[10] = oY_COORD[10];
							 end
						54: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[9]  = iADC_DOUT; 
								else 
									oY_COORD[9]  = oY_COORD[9];
							 end
						56: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[8]  = iADC_DOUT; 
								else 
									oY_COORD[8]  = oY_COORD[8];
							 end
						58: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[7]  = iADC_DOUT; 
								else 
									oY_COORD[7]  = oY_COORD[7];
							 end
						60: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[6]  = iADC_DOUT; 
								else 
									oY_COORD[6]  = oY_COORD[6];
							 end
						62: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[5]  = iADC_DOUT; 
								else 
									oY_COORD[5]  = oY_COORD[5];
							 end
						64: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[4]  = iADC_DOUT; 
								else 
									oY_COORD[4]  = oY_COORD[4];
							 end
						66: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[3]  = iADC_DOUT; 
								else 
									oY_COORD[3]  = oY_COORD[3];
							 end
						68: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[2]  = iADC_DOUT; 
								else 
									oY_COORD[2]  = oY_COORD[2];
							 end
						70: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[1]  = iADC_DOUT; 
								else 
									oY_COORD[1]  = oY_COORD[1];
							 end
						72: begin 
								if(iENABLE_2 == 1'b1) 
									oY_COORD[0]  = iADC_DOUT; 
								else 
									oY_COORD[0]  = oY_COORD[0];
							end
					endcase
				end			
			end
endmodule
