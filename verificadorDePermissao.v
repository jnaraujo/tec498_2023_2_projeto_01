/*
  Módulo que verifica se um usuário tem permissão para acessar uma funcionalidade.
  O módulo recebe como entrada um vetor de 3 bits que representa o usuário e um vetor de 3 bits que representa a funcionalidade.
  O módulo retorna um vetor de 3 bits que representa a funcionalidade do usuário.
  Se ele não tiver permissão, o vetor de saída será 000.
*/

module verificadorDePermissao(
  User,
  Func,
  S
);
  input [2:0] User, Func; // entradas

  output [2:0] S; // saida

  wire NOT_User0, NOT_User1, NOT_User2;
  wire NOT_F0, NOT_F1, NOT_F2;

  wire W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13;

  not NOT0 (NOT_User0, User[0]);
  not NOT1 (NOT_User1, User[1]);
  not NOT2 (NOT_User2, User[2]);

  not NOT3 (NOT_F0, Func[0]);
  not NOT4 (NOT_F1, Func[1]);
  not NOT5 (NOT_F2, Func[2]);

  // S2 = A'CDF' + AB'CD + ABC'DEF'
  and AND0 (W0, NOT_User2, User[0], Func[2], NOT_F0);
  and AND1 (W1, User[2], NOT_User1, User[0], Func[2]);
  and AND2 (W2, User[2], User[1], NOT_User0, Func[2], Func[1], NOT_F0);
  or OR0 (S[2], W0, W1, W2);

  // S1 = AB'CE + A'CD'EF + A'CDEF' + A'BCD'E + ABC'DEF'			
  and AND3 (W3, User[2], NOT_User1, User[0], Func[1]);
  and AND4 (W4, NOT_User2, User[0], NOT_F2, Func[1], Func[0]);
  and AND5 (W5, NOT_User2, User[0], Func[2], Func[1], NOT_F0);
  and AND6 (W6, NOT_User2, User[1], User[0], NOT_F2, Func[1]);
  and AND7 (W7, User[2], User[1], NOT_User0, Func[2], Func[1], NOT_F0);
  or OR1 (S[1], W3, W4, W5, W6, W7);

  // S0 = A'CD'F + AB'CF + ABC'D'E'F			
  and AND8 (W8, NOT_User2, User[0], NOT_F2, Func[0]);
  and AND9 (W9, User[2], NOT_User1, User[0], Func[0]);
  and AND10 (W10, User[2], User[1], NOT_User0, NOT_F2, NOT_F1, Func[0]);
  or OR2 (S[0], W8, W9, W10);
endmodule


module TB_VerificadorDePermissao();

  reg [2:0] User;
  reg [2:0] Func;

  wire [2:0] S;

  verificadorDePermissao verificadorDePermissao(User, Func, S);

  initial begin
    User = 3'b110; Func = 3'b001; #10; // 001
    User = 3'b110; Func = 3'b110; #10; // 110

    User = 3'b001; Func = 3'b001; #10; // 001
    User = 3'b001; Func = 3'b011; #10; // 011
    User = 3'b001; Func = 3'b100; #10; // 100
    User = 3'b001; Func = 3'b110; #10; // 110

    User = 3'b011; Func = 3'b001; #10; // 001
    User = 3'b011; Func = 3'b010; #10; // 010
    User = 3'b011; Func = 3'b011; #10; // 011
    User = 3'b011; Func = 3'b100; #10; // 100
    User = 3'b011; Func = 3'b110; #10; // 110

    User = 3'b101; Func = 3'b001; #10; // 001
    User = 3'b101; Func = 3'b010; #10; // 010
    User = 3'b101; Func = 3'b011; #10; // 011
    User = 3'b101; Func = 3'b100; #10; // 100
    User = 3'b101; Func = 3'b101; #10; // 101
    User = 3'b101; Func = 3'b110; #10; // 110
    User = 3'b101; Func = 3'b111; #10; // 111

    // usuarios invalidos
    User = 3'b100; Func = 3'b001; #10; // 000
    User = 3'b100; Func = 3'b010; #10; // 000
    User = 3'b010; Func = 3'b011; #10; // 000
    User = 3'b010; Func = 3'b100; #10; // 000

    // funcionalidades invalidas
    User = 3'b110; Func = 3'b010; #10; // 000
    User = 3'b110; Func = 3'b011; #10; // 000
    User = 3'b011; Func = 3'b101; #10; // 000
  end

endmodule