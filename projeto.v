// Modulo principal do projeto
module projeto(
  CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7, // chaves
  BTN0, BTN1, BTN2, BTN3, // botoes
  D0, D1, D2, D3, D4, D5, D6, D7, // display
  LED1, LED3, LED4, LED6, // leds
  M1, M2, M3, M4, M5, M6, M7, // matriz de leds
);
  input CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7; // chaves
  input BTN0, BTN1, BTN2, BTN3; // botoes
  
  output D0, D1, D2, D3, D4, D5, D6, D7; // display
  output M1, M2, M3, M4, M5, M6, M7; // matriz de leds
  output LED1, LED3, LED4, LED6; // leds

  // fios
  wire [2:0] User0, User1;

  wire [2:0] Func0, Func1;
  
  wire [6:0] Matriz0, Matriz1;
  wire [3:0] Leds0, Leds1;

  wire [2:0] UserMenorPrioridade;
  wire [2:0] PrioridadeComp, Prioridade;
  wire ehIgual, ehDiferente;

  and and2 (User0[2], CH0);
  and and1 (User0[1], CH1);
  and and0 (User0[0], CH2);
  
  and and5 (User1[2], CH4);
  and and4 (User1[1], CH5);
  and and3 (User1[0], CH6);

  and and8 (Func0[2], CH3);
  and and7 (Func0[1], BTN1);
  and and6 (Func0[0], BTN2);

  and and11 (Func1[2], CH7);
  and and10 (Func1[1], BTN3);
  and and9 (Func1[0], BTN4);

  // Verifica se os usuários tem a permissão de usar a funcionalidade
  // TODO

  // compara a prioridade dos usuarios
  comparadorDePrioridade comparadorDePrioridade0 (User0, User1, PrioridadeComp, UserMenorPrioridade);
  // se os forem funcionalidades diferentes, ambos executam
  comparadorDeIgualdade comparadorDeIgualdade0 (.A(Func0), .B(Func1), .S(ehIgual));
  // // inverte a saida de ehIgual
  not not0 (ehDiferente, ehIgual);

  decodificadorDeFuncionalidade decodificadorDeFuncionalidade0(User0, Func0, Matriz0[6], Matriz0[5], Matriz0[4], Matriz0[3], Matriz0[2], Matriz0[1], Matriz0[0], Leds0[3], Leds0[2], Leds0[1], Leds0[0]);

  decodificadorDeFuncionalidade decodificadorDeFuncionalidade1(User1, Func1, Matriz1[6], Matriz1[5], Matriz1[4], Matriz1[3], Matriz1[2], Matriz1[1], Matriz1[0], Leds1[3], Leds1[2], Leds1[1], Leds1[0]);

  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade1(M1, Matriz0[0], Matriz1[0], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade2(M2, Matriz0[1], Matriz1[1], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade3(M3, Matriz0[2], Matriz1[2], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade4(M4, Matriz0[3], Matriz1[3], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade5(M5, Matriz0[4], Matriz1[4], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade6(M6, Matriz0[5], Matriz1[5], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade7(M7, Matriz0[6], Matriz1[6], ehDiferente);

  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade8(LED1, Leds0[0], Leds1[0], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade9(LED3, Leds0[1], Leds1[1], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade10(LED4, Leds0[2], Leds1[2], ehDiferente);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade11(LED6, Leds0[3], Leds1[3], ehDiferente);
endmodule

module TB_Projeto();
  reg [7:0] Chaves;
  reg [3:0] Botoes;

  wire D0, D1, D2, D3, D4, D5, D6, D7; // display
  wire M1, M2, M3, M4, M5, M6, M7; // matriz de leds
  wire LED1, LED3, LED4, LED6; // leds

  projeto projeto(Chaves[0], Chaves[1], Chaves[2], Chaves[3], Chaves[4], Chaves[5], Chaves[6], Chaves[7], Botoes[0], Botoes[1], Botoes[2], Botoes[3], D0, D1, D2, D3, D4, D5, D6, D7, M1, M2, M3, M4, M5, M6, M7, LED1, LED3, LED4, LED6);

  initial begin
    // admin - user ; func 1 ; func 2
    Chaves = 10100010; Botoes = 0101; #10;

    // admin - user ; func 2 ; func 1
    Chaves = 10100011; Botoes = 0110; #10;
  end
endmodule
