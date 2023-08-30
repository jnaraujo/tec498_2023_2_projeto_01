module decodificadorDeFuncionalidade(User, Func, M7, M6, M5, M4, M3, M2, M1, L6, L4, L3, L1);
  // entradas
  input [2:0] User, Func;

  // saidas
  output M7, M6, M5, M4, M3, M2, M1, L6, L4, L3, L1; // LEDS E MATRIZ

  // fios
  wire W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13;
  wire NOT_User0, NOT_User1, NOT_User2;
  wire NOT_F0, NOT_F1, NOT_F2;

  // NOTs
  not NOT0 (NOT_User0, User[0]);
  not NOT1 (NOT_User1, User[1]);
  not NOT2 (NOT_User2, User[2]);
  not NOT3 (NOT_F0, Func[0]);
  not NOT4 (NOT_F1, Func[1]);
  not NOT5 (NOT_F2, Func[2]);

  // M7 - U2U1'U0F2F1F0		
  and AND0 (M7, User[2], NOT_User1, User[0], Func[2], Func[1], Func[0]);

  // M6 - U2U1'U0F2F1F0' + U2'U1U0F2F1F0'
  and AND1 (W0, User[2], NOT_User1, User[0], Func[2], Func[1], NOT_F0);
  and AND2 (W1, NOT_User2, User[1], User[0], Func[2], Func[1], NOT_F0);
  or OR0 (M6, W0, W1);

  // M5 U2U1'U0F2F1'F0			
  and AND3 (M5, User[2], NOT_User1, User[0], Func[2], NOT_F1, Func[0]);

  // M4 = U2U1'U0F2F1'F0' + U2'U1U0F2F1'F0'		
  and AND4 (W2, User[2], NOT_User1, User[0], Func[2], NOT_F1, NOT_F0);
  and AND5 (W3, NOT_User2, User[1], User[0], Func[2], NOT_F1, NOT_F0);
  or OR1 (M4, W2, W3);

  // M3 = U2U1'U0F2'F1F0 + U2'U1U0F2'F1F0
  and AND6 (W4, User[2], NOT_User1, User[0], NOT_F2, Func[1], Func[0]);
  and AND7 (W5, NOT_User2, User[1], User[0], NOT_F2, Func[1], Func[0]);
  or OR2 (M3, W4, W5);

  // M2 = U2U1'U0F2'F1F0' + U2'U1U0F2'F1F0'
  and AND8 (W6, User[2], NOT_User1, User[0], NOT_F2, Func[1], NOT_F0);
  and AND9 (W7, NOT_User2, User[1], User[0], NOT_F2, Func[1], NOT_F0);
  or OR3 (M2, W6, W7);

  // M1 = U2U1'U0F2'F1'F0 + U2'U1U0F2'F1'F0			
  and AND10 (W8, User[2], NOT_User1, User[0], NOT_F2, NOT_F1, Func[0]);
  and AND11 (W9, NOT_User2, User[1], User[0], NOT_F2, NOT_F1, Func[0]);
  or OR4 (M1, W8, W9);

  // L6 = U2'U1'U0F2F1F0' + U2U1U0'F2F1F0'		
  and AND12 (W10, NOT_User2, NOT_User1, User[0], Func[2], Func[1], NOT_F0);
  and AND13 (W11, User[2], User[1], NOT_User0, Func[2], Func[1], NOT_F0);
  or OR5 (L6, W10, W11);

  // L4 = U2'U1'U0F2F1'F0'	
  and AND14 (L4, NOT_User2, NOT_User1, User[0], Func[2], NOT_F1, NOT_F0);

  // L3 = U2'U1'U0F2'F1F0
  and AND15 (L3, NOT_User2, NOT_User1, User[0], NOT_F2, Func[1], Func[0]);

  // L1 = U2'U1'U0F2'F1'F0 + U2U1U0'F2'F1'F0		
  and AND16 (W12, NOT_User2, NOT_User1, User[0], NOT_F2, NOT_F1, Func[0]);
  and AND17 (W13, User[2], User[1], NOT_User0, NOT_F2, NOT_F1, Func[0]);
  or OR6 (L1, W12, W13);
endmodule

module TB_DecodificadorDeFuncionalidade();
  reg [2:0] User, Func;

  wire M1, M2, M3, M4, M5, M6, M7, L6, L4, L3, L1;

  decodificadorDeFuncionalidade decodificadorDeFuncionalidade(User, Func, M7, M6, M5, M4,M3, M2, M1, L6, L4, L3, L1);

  initial begin
    // caso de habilitação
    User = 101; Func = 001; #10; // 0	0	0	0	0	0	1	0	0	0	0
    User = 101; Func = 010; #10; // 0	0	0	0	0	1	0	0	0	0	0
    User = 101; Func = 011; #10; // 0	0	0	0	1	0	0	0	0	0	0
    User = 101; Func = 100; #10; // 0	0	0	1	0	0	0	0	0	0	0
    User = 101; Func = 101; #10; // 0	0	1	0	0	0	0	0	0	0	0
    User = 101; Func = 110; #10; // 0	1	0	0	0	0	0	0	0	0	0
    User = 101; Func = 111; #10; // 1	0	0	0	0	0	0	0	0	0	0

    User = 011; Func = 001; #10; // 0	0	0	0	0	0	1	0	0	0	0
    User = 011; Func = 010; #10; // 0	0	0	0	0	1	0	0	0	0	0
    User = 011; Func = 011; #10; // 0	0	0	0	1	0	0	0	0	0	0
    User = 011; Func = 100; #10; // 0	0	0	1	0	0	0	0	0	0	0
    User = 011; Func = 110; #10; // 0	1	0	0	0	0	0	0	0	0	0

    User = 001; Func = 001; #10; // 0	0	0	0	0	0	0	0	0	0	1
    User = 001; Func = 011; #10; // 0	0	0	0	0	0	0	0	0	1	0
    User = 001; Func = 100; #10; // 0	0	0	0	0	0	0	0	1	0	0
    User = 001; Func = 110; #10; // 0	0	0	0	0	0	0	1	0	0	0

    User = 110; Func = 001; #10; // 0	0	0	0	0	0	0	0	0	0	1
    User = 110; Func = 110; #10; // 0	0	0	0	0	0	0	1	0	0	0
    
  end
endmodule
