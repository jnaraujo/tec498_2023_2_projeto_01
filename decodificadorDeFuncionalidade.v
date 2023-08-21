module decodificadorDeFuncionalidade(F, E, F1, F2, F3, F4, F5, F6, F7);
  // entradas
  input [2:0] F; // funcionalidade
  input E; // enable

  // saidas
  output F1, F2, F3, F4, F5, F6, F7;	

  // fios
  wire W0, W1, W2, W3, W4, W5, W6;
  wire NOT_F0, NOT_F1, NOT_F2;

  // NOTs
  not NOT0 (NOT_F0, F[0]);
  not NOT1 (NOT_F1, F[1]);
  not NOT2 (NOT_F2, F[2]);

  and and0 (F7, F[2], F[1], F[0], E);
  and and1 (F6, F[2], F[1], NOT_F0, E);
  and and2 (F5, F[2], NOT_F1, F[0], E);
  and and3 (F4, F[2], NOT_F1, NOT_F0, E);
  and and4 (F3, NOT_F2, F[1], F[0], E);
  and and5 (F2, NOT_F2, F[1], NOT_F0, E);
  and and6 (F1, NOT_F2, NOT_F1, F[0], E);
endmodule

module TB_DecodificadorDeFuncionalidade();
  reg [2:0] F;
  reg E;

  wire F1, F2, F3, F4, F5, F6, F7;

  decodificadorDeFuncionalidade decodificadorDeFuncionalidade(F, E, F1, F2, F3, F4, F5, F6, F7);

  initial begin
    // caso de habilitação
    F = 000; E = 1; #10; // 0000000
    F = 001; E = 1; #10; // 0000001
    F = 010; E = 1; #10; // 0000010
    F = 011; E = 1; #10; // 0000100
    F = 100; E = 1; #10; // 0001000
    F = 101; E = 1; #10; // 0010000
    F = 110; E = 1; #10; // 0100000
    F = 111; E = 1; #10; // 1000000

    // caso de desabilitação
    F = 000; E = 0; #10; // 0000000
    F = 001; E = 0; #10; // 0000000
    F = 010; E = 0; #10; // 0000000
    F = 011; E = 0; #10; // 0000000
    F = 100; E = 0; #10; // 0000000
    F = 101; E = 0; #10; // 0000000
    F = 110; E = 0; #10; // 0000000
    F = 111; E = 0; #10; // 0000000
  end
endmodule
