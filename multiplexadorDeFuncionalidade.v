module multiplexadorDeFuncionalidade(P, A, B, S);
  input [1:0] P;
  input A, B;

  output S;

  wire P1_AND_A, P0_AND_B;

  and and0 (P1_AND_A, P[1], A);
  and and1 (P0_AND_B, P[0], B);

  or or0 (S, P1_AND_A, P0_AND_B);
endmodule

module TB_MultiplexadorDeFuncionalidade();
  reg [1:0] P;
  reg A, B;

  wire S;

  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade(P, A, B, S);

  initial begin
    P = 01; A = 0; B = 1; #10; // 1
    P = 01; A = 1; B = 1; #10; // 1
    P = 10; A = 1; B = 0; #10; // 1
    P = 10; A = 1; B = 1; #10; // 1
    P = 11; A = 0; B = 1; #10; // 1
    P = 11; A = 1; B = 0; #10; // 1
    P = 11; A = 1; B = 1; #10; // 1

    // saidas 0
    P = 00; A = 0; B = 0; #10; // 0
    P = 00; A = 0; B = 1; #10; // 0
    P = 00; A = 1; B = 0; #10; // 0
    P = 00; A = 1; B = 1; #10; // 0
    P = 01; A = 0; B = 0; #10; // 0
    P = 01; A = 1; B = 0; #10; // 0
    P = 10; A = 0; B = 0; #10; // 0
    P = 10; A = 0; B = 1; #10; // 0
    P = 11; A = 0; B = 0; #10; // 0
  end
endmodule