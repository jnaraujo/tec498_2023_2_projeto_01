// Modulo principal do projeto
module projeto(
  CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7, // chaves
  BTN0, BTN1, BTN2, BTN3, // botoes
  D0, D1, D2, D3, D4, D5, D6, D7, // display
  LED1, LED3, LED4, LED6, // leds
  M1, M2, M3, M4, M5, M6, M7, // matriz de leds
  Col, // coluna da matriz de leds
  Digito1, Digito2, Digito3, Digito4, // display de 7 segmentos
  LED_R, LED_G, LED_B // led do piloto automatico
);
  input CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7; // chaves
  input BTN0, BTN1, BTN2, BTN3; // botoes
  
  output D0, D1, D2, D3, D4, D5, D6, D7; // display
  output M1, M2, M3, M4, M5, M6, M7; // matriz de leds
  output LED1, LED3, LED4, LED6; // leds
  output Col; // coluna da matriz de leds
  output Digito1, Digito2, Digito3, Digito4; // display de 7 segmentos
  output LED_R, LED_G, LED_B; // led do piloto automatico

  // fios
  wire Not_BTN0, Not_BTN1, Not_BTN2, Not_BTN3; // botões funcionam em logica invertida

  wire [2:0] User0, User1;

  wire [2:0] Func0, Func1;
  
  wire [6:0] Matriz0, Matriz1;
  wire [3:0] Leds0, Leds1;

  wire [2:0] UserMenorPrioridade;
  wire [1:0] PrioridadeComp, Prioridade;
  wire ehIgual, ehDiferente;

  // inverte os botoes
  not (Not_BTN0, BTN0);
  not (Not_BTN1, BTN1);
  not (Not_BTN2, BTN2);
  not (Not_BTN3, BTN3);

  and and2 (User0[2], CH0);
  and and1 (User0[1], CH1);
  and and0 (User0[0], CH2);
  
  and and5 (User1[2], CH4);
  and and4 (User1[1], CH5);
  and and3 (User1[0], CH6);

  and and8 (Func0[2], CH3);
  and and7 (Func0[1], Not_BTN0);
  and and6 (Func0[0], Not_BTN1);

  and and11 (Func1[2], CH7);
  and and10 (Func1[1], Not_BTN2);
  and and9 (Func1[0], Not_BTN3);

  // Verifica se os usuários tem a permissão de usar a funcionalidade
  // TODO

  // compara a prioridade dos usuarios
  comparadorDePrioridade comparadorDePrioridade0 (User0, User1, PrioridadeComp, UserMenorPrioridade);

  // liga o led do piloto automatico
  // PrioridadeComp é 11 quando os dois usuarios tem entrada 111
  and andPA (LED_G, PrioridadeComp[1], PrioridadeComp[0]);

  // se os forem funcionalidades diferentes, ambos executam
  comparadorDeIgualdade comparadorDeIgualdade0 (.A(Func0), .B(Func1), .S(ehIgual));

  // inverte a saida de ehIgual
  not not0 (ehDiferente, ehIgual);

  or or0 (Prioridade[0], PrioridadeComp[0], ehDiferente);
  or or1 (Prioridade[1], PrioridadeComp[1], ehDiferente);

  decodificadorDeFuncionalidade decodificadorDeFuncionalidade0(User0, Func0, Matriz0[6], Matriz0[5], Matriz0[4], Matriz0[3], Matriz0[2], Matriz0[1], Matriz0[0], Leds0[3], Leds0[2], Leds0[1], Leds0[0]);

  decodificadorDeFuncionalidade decodificadorDeFuncionalidade1(User1, Func1, Matriz1[6], Matriz1[5], Matriz1[4], Matriz1[3], Matriz1[2], Matriz1[1], Matriz1[0], Leds1[3], Leds1[2], Leds1[1], Leds1[0]);  

  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade1(Prioridade, Matriz0[6], Matriz1[6], M7);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade2(Prioridade, Matriz0[5], Matriz1[5], M6);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade3(Prioridade, Matriz0[4], Matriz1[4], M5);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade4(Prioridade, Matriz0[3], Matriz1[3], M4);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade5(Prioridade, Matriz0[2], Matriz1[2], M3);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade6(Prioridade, Matriz0[1], Matriz1[1], M2);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade7(Prioridade, Matriz0[0], Matriz1[0], M1);

  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade8(Prioridade, Leds0[3], Leds1[3], LED6);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade9(Prioridade, Leds0[2], Leds1[2], LED4);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade10(Prioridade, Leds0[1], Leds1[1], LED3);
  multiplexadorDeFuncionalidade multiplexadorDeFuncionalidade11(Prioridade, Leds0[0], Leds1[0], LED1);

  decodificadorDeDisplay decodificadorDeDisplay(
    .User(UserMenorPrioridade),
    .Enable(Matriz0[1]), // ativa na funcionalidade 2
    .A(D0),.B(D1),.C(D2),.D(D3),.E(D4),.F(D5),.G(D6),.DP(D7)
  );

  // define a coluna que será ligada
  assign Col = 1;
  // define o digito que será ligado
  assign Digito1 = 0;
  assign Digito2 = 1;
  assign Digito3 = 1;
  assign Digito4 = 1;

  assign LED_R = 0;
  assign LED_B = 0;
endmodule

module TB_Projeto();
  /*
    Os valores correspondentes aos botões funcionam com lógica invertida
    na placa. Porém, para melhor visualização, os valores foram invertidos
    aqui no código.
  */

  reg [2:0] User0, User1;
  reg [2:0] Func0, Func1;

  wire D0, D1, D2, D3, D4, D5, D6, D7; // display
  wire M1, M2, M3, M4, M5, M6, M7; // matriz de leds
  wire LED1, LED3, LED4, LED6; // leds
  wire Col; // coluna da matriz de leds
  wire Digito1, Digito2, Digito3, Digito4; // display de 7 segmentos
  wire LED_R, LED_G, LED_B; // led do piloto automatico

  projeto projeto(
    User0[2], User0[1], User0[0], Func0[2], User1[2], User1[1], User1[0], Func1[2], // chaves
    ~Func0[1], ~Func0[0], ~Func1[1], ~Func1[0], // botoes
    D0, D1, D2, D3, D4, D5, D6, D7, // display
    LED1, LED3, LED4, LED6, // leds
    M1, M2, M3, M4, M5, M6, M7, // matriz de leds
    Col, // coluna da matriz de leds
    Digito1, Digito2, Digito3, Digito4, // display de 7 segmentos
    LED_R, LED_G, LED_B // led do piloto automatico
  );

  initial begin
    // admin - user ; func 1 ; func 1 = m1
    User0 = 101; Func0 = 001; User1 = 001; Func1 = 001; #10;

    // admin - user ; func 2 ; func 1 = led1 e m2
    User0 = 101; Func0 = 010; User1 = 001; Func1 = 001; #10;

    // admin - user ; neutro ; func 1 = led3
    User0 = 101; Func0 = 000; User1 = 001; Func1 = 011; #10;

    // piloto automatico - piloto automatico ; led rgb
    User0 = 111; Func0 = 101; User1 = 111; Func1 = 101; #10;
  end
endmodule
