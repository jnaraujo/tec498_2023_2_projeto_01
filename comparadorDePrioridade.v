// Módulo que compara a prioridade de dois usuários e retorna qual das interfaces tem maior prioridade
// Ele também retorna o código do usuário com menor prioridade - para a funcionalidade 2 do projeto
module comparadorDePrioridade(User0, User1, S, UserMenorPrioridade);
  // Entradas
  input [2:0] User0;
  input [2:0] User1;

  // Saídas
  output [1:0] S;
  output [2:0] UserMenorPrioridade;

  // Fios
  wire W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15;
  wire W16, W17, W18, W19, W20, W21, W22, W23, W24, W25, W26, W27, W28, W29, W30, W31;
  wire NOT_User0_0, NOT_User0_1, NOT_User0_2, NOT_User1_0, NOT_User1_1, NOT_User1_2;

  // NOTs
  not NOT0 (NOT_User0_0, User0[0]);
  not NOT1 (NOT_User0_1, User0[1]);
  not NOT2 (NOT_User0_2, User0[2]);

  not NOT3 (NOT_User1_0, User1[0]);
  not NOT4 (NOT_User1_1, User1[1]);
  not NOT5 (NOT_User1_2, User1[2]);
  
  // A = User0[2]
  // B = User0[1]
  // C = User0[0]
  // D = User1[2]
  // E = User1[1]
  // F = User1[0]

  // SAIDA 0

  // A'CD'E'
  and S0_AND0 (W0, NOT_User0_2, User0[0], NOT_User1_2, NOT_User1_1);

  // B'CD'E'
  and S0_AND1 (W1, NOT_User0_1, User0[0], NOT_User1_2, NOT_User1_1);

  // A'CDEF'
  and S0_AND2 (W2, NOT_User0_2, User0[0], User1[2], User1[1], NOT_User1_0);

  // B'CDEF'
  and S0_AND3 (W3, NOT_User0_1, User0[0], User1[2], User1[1], NOT_User1_0);

  // A'BCD'F
  and S0_AND4 (W4, NOT_User0_2, User0[1], User0[0], NOT_User1_2, User1[0]);

  // AB'CD'F
  and S0_AND5 (W5, User0[2], NOT_User0_1, User0[0], NOT_User1_2, User1[0]);

  // AB'CE'F
  and S0_AND6 (W6, User0[2], NOT_User0_1, User0[0], NOT_User1_1, User1[0]);

  // ABC'D'E'F'
  and S0_AND7 (W7, User0[2], User0[1], NOT_User0_0, NOT_User1_2, NOT_User1_1, NOT_User1_0);

  // ABC'DEF'
  and S0_AND8 (W8, User0[2], User0[1], NOT_User0_0, User1[2], User1[1], NOT_User1_0);

  // ABCDEF
  and S0_AND9 (W9, User0[2], User0[1], User0[0], User1[2], User1[1], User1[0]);

  or S0_OR0 (S[1], W0, W1, W2, W3, W4, W5, W6, W7, W8, W9);

  // SAIDA 0

  // A'B'C'E'F
  and S1_AND0 (W10, NOT_User0_2, NOT_User0_1, NOT_User0_0, NOT_User1_1, User1[0]);

  // A'B'D'EF
  and S1_AND1 (W11, NOT_User0_2, NOT_User0_1, NOT_User1_2, User1[1], User1[0]);

  // A'CDE'F
  and S1_AND2 (W12, NOT_User0_2, User0[0], User1[2], NOT_User1_1, User1[0]);

  // ABC'D'F
  and S1_AND3 (W13, User0[2], User0[1], NOT_User0_0, NOT_User1_2, User1[0]);

  // ABC'E'F
  and S1_AND4 (W14, User0[2], User0[1], NOT_User0_0, NOT_User1_1, User1[0]);

  // A'B'C'DEF'
  and S1_AND5 (W15, NOT_User0_2, NOT_User0_1, NOT_User0_0, User1[2], User1[1], NOT_User1_0);

  or S1_OR0 (S[0], W10, W11, W12, W13, W14, W15, W9);

  // UserMenorPrioridade 2
  // A'CDEF' + B'CDEF' + ABC'D'F + ABC'E'F + AB'CDE'F + ABC'DEF'

  // AB'CDE'F
  and UMP_2_AND0 (W16, User0[2], NOT_User0_1, User0[0], User1[2], NOT_User1_1, User1[0]);

  or UMP_2_OR0 (UserMenorPrioridade[2], W2, W3, W13, W14, W16, W8);

  // UserMenorPrioridade 1
  // A'CDEF' + B'CDEF' + ABC'D'F + ABC'E'F + A'BCD'EF + A'BCDE'F + AB'CD'EF + ABC'DEF'

  // A'BCD'EF
  and UMP_1_AND0 (W17, NOT_User0_2, User0[1], User0[0], NOT_User1_2, User1[1], User1[0]);

  // A'BCDE'F
  and UMP_1_AND1 (W18, NOT_User0_2, User0[1], User0[0], User1[2], NOT_User1_1, User1[0]);

  // AB'CD'EF
  and UMP_1_AND2 (W19, User0[2], NOT_User0_1, User0[0], NOT_User1_2, User1[1], User1[0]);

  or UMP_1_OR0 (UserMenorPrioridade[1], W2, W3, W13, W14, W17, W18, W19, W8);

  // UserMenorPrioridade 0
  // A'CD'F + B'CD'F + A'CE'F + B'CE'F

  // A'CD'F
  and UMP_0_AND0 (W20, NOT_User0_2, User0[0], NOT_User1_2, User1[0]);

  // A'CE'F
  and UMP_0_AND1 (W21, NOT_User0_2, User0[0], NOT_User1_1, User1[0]);

  or UMP_0_OR0 (UserMenorPrioridade[0], W20, W5, W21, W6);



endmodule

module TB_ComparadorDePrioridade();
  reg [2:0] User0;
  reg [2:0] User1;

  wire [1:0] S;
  wire [2:0] UserMenorPrioridade;

  comparadorDePrioridade comparadorDePrioridade(User0, User1, S, UserMenorPrioridade);

  initial begin
    User0 = 000; User1 = 000; #10; // 0 0 - 0	0	0
    User0 = 000; User1 = 110; #10; // 0 1 - 0	0	0
    User0 = 000; User1 = 011; #10; // 0 1 - 0	0	0
    User0 = 000; User1 = 001; #10; // 0 1 - 0	0	0
    User0 = 000; User1 = 101; #10; // 0 1 - 0	0	0

    User0 = 110; User1 = 000; #10; // 1 0 - 0	0	0
    User0 = 110; User1 = 110; #10; // 1 0 - 1	1	0
    User0 = 110; User1 = 001; #10; // 0 1 - 1	1	0
    User0 = 110; User1 = 011; #10; // 0 1 - 1	1	0
    User0 = 110; User1 = 101; #10; // 0 1 - 1	1	0

    User0 = 001; User1 = 000; #10; // 1 0 - 0	0	0
    User0 = 001; User1 = 110; #10; // 1 0 - 1	1	0
    User0 = 001; User1 = 001; #10; // 1 0 - 0	0	1
    User0 = 001; User1 = 011; #10; // 0 1 - 0	0	1
    User0 = 001; User1 = 101; #10; // 0 1 - 0	0	1

    User0 = 011; User1 = 000; #10; // 1 0 - 0	0	0
    User0 = 011; User1 = 110; #10; // 1 0 - 1	1	0
    User0 = 011; User1 = 001; #10; // 1 0 - 0	0	1
    User0 = 011; User1 = 011; #10; // 1 0 - 0	1	1
    User0 = 011; User1 = 101; #10; // 0 1 - 0	1	1

    User0 = 101; User1 = 000; #10; // 1 0 - 0	0	0
    User0 = 101; User1 = 110; #10; // 1 0 - 1	1	0
    User0 = 101; User1 = 001; #10; // 1 0 - 0	0	1
    User0 = 101; User1 = 011; #10; // 1 0 - 0	1	1
    User0 = 101; User1 = 101; #10; // 1 0 - 1	0	1

    User0 = 111; User1 = 111; #10; // 1 1 - 0	0	0

    // casos invalidos
    User0 = 101; User1 = 001; #10;
    
  end
endmodule