// Modulo que compara dois numeros de 3 bits e retorna 1 se forem iguais
// e 0 se forem diferentes
module comparadorDeIgualdade(A, B, S);
	// entradas
	input [2:0] A;
	input [2:0] B;
	
	// saidas
	output S;
	
	// fios
	wire W0, W1, W2;
	
	// xnor retorna 1 se os dois bits forem iguais
	// 0 0 -> 1
	// 0 1 -> 0
	// 1 0 -> 0
	// 1 1 -> 1

	xnor xnor0(W0, A[2], B[2]);
	xnor xnor1(W1, A[1], B[1]);
	xnor xnor2(W2, A[0], B[0]);
	
	and and0(S, W0, W1, W2);
endmodule

module TB_ComparadorDeIgualdade();
	reg [2:0] A;
	reg [2:0] B;

	wire S;

	comparadorDeIgualdade comparadorDeIgualdade(A, B, S);

	initial begin
		// casos de igualdade
		A = 3'b000; B = 3'b000; #10; // 1
		A = 3'b110; B = 3'b110; #10; // 1
		A = 3'b001; B = 3'b001; #10; // 1
		A = 3'b011; B = 3'b011; #10; // 1
		A = 3'b101; B = 3'b101; #10; // 1
		A = 3'b111; B = 3'b111; #10; // 1

		// casos de diferença
		A = 3'b000; B = 3'b110; #10; // 0
		A = 3'b110; B = 3'b000; #10; // 0
		A = 3'b001; B = 3'b110; #10; // 0
		A = 3'b110; B = 3'b001; #10; // 0
		A = 3'b011; B = 3'b110; #10; // 0
		A = 3'b110; B = 3'b011; #10; // 0
		A = 3'b101; B = 3'b110; #10; // 0
		A = 3'b110; B = 3'b101; #10; // 0
		A = 3'b111; B = 3'b110; #10; // 0
		A = 3'b110; B = 3'b111; #10; // 0
	end
endmodule

	