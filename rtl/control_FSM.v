/*

Nombre del archivo: control_FSM.v
Descripción: El módulo control_FSM implementa una máquina de estados 
finitos (FSM), para controlar un proceso de la comunicación con un 
convertidor analógico a digital (ADC).

Entradas:
  iCLK: Reloj del sistema.
  iRST_n: Señal de reinicio activa en bajo.
  iENABLE_1, iENABLE_2: Señales de habilitación.
  iADC_PENIRQ_n: Señal relacionada con el ADC, posiblemente una interrupción.
  

Salidas (todas registradas):
  oADC_CS: Chip select para el ADC.
  oEna_trans: Habilitación de transmisión.
  oFin_trans: Indicador de finalización de transmisión.


Estados (localparam):
  S0 a S3: Representan los diferentes estados de la máquina de estados.
  
Descripción de la Lógica de Estados:

 S0: Estado inicial. Todas las salidas están desactivadas.
 S1: Espera hasta que iADC_PENIRQ_n esté en bajo para pasar a S2.
 S2: Si iENABLE_1 y iENABLE_2 están activos, pasa a S3. Activa oADC_CS y oEna_trans.
 S3: Transición inmediata para volver a S0.

*/

module control_FSM(iCLK,iRST_n,iENABLE_1, iENABLE_2,iADC_PENIRQ_n, oADC_CS, oEna_trans, oFin_trans);

	input iCLK, iRST_n, iENABLE_1, iENABLE_2,iADC_PENIRQ_n;
	output reg oADC_CS;
	output reg oEna_trans;
	output reg oFin_trans;
	
	reg  [2:0] state, next_state;
	localparam [2:0] S0=0, S1=1, S2=2, S3=3;
	
	
	
	always@(posedge iCLK or negedge iRST_n)
		begin 
			if(!iRST_n)
				state <= S0;
			else
				state <= next_state;
		end
		
	
	always@(state or iENABLE_1 or iENABLE_2 or iADC_PENIRQ_n)
		case(state)
			S0: begin
						next_state <= S1;
				 end					  					  
							
			S1: begin
					if (iADC_PENIRQ_n == 1'b1)
						begin
							next_state <= S1;
						end	
					else
						begin
							next_state <= S2;
						end
				 end			
			
			S2: 
				begin
					if ((iENABLE_1 == 1'b1) && (iENABLE_2 == 1'b1))
						begin
							next_state <= S3;
						end	
					else	
						begin		
							next_state <= S2;
						end
				end	
			
			S3: 
				begin
						next_state <= S0;
				end		
			
			default: 
				begin
					next_state <=  S0;
				end
			
		endcase
			
			
			
		always@(state,  iENABLE_1 , iENABLE_2 , iADC_PENIRQ_n)
			case(state)
				S0:	
					begin
						oADC_CS    <= 0;
						oEna_trans <= 0;
						oFin_trans <= 0;					
					end
				S1:
					begin
						oADC_CS    <= 0;
						oEna_trans <= 0;
						oFin_trans <= 0;					
					end
				S2:
					begin
						oADC_CS    <= 1;
						oEna_trans <= 1;
						oFin_trans <= 0;					
					end
				S3:
					begin
						oADC_CS    <= 0;
						oEna_trans <= 0;
						oFin_trans <= 1;					
					end

				default:
					begin
						oADC_CS    <= 0;
						oEna_trans <= 0;
						oFin_trans <= 0;					
					end
			endcase
				
	
endmodule




