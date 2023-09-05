/*
  Módulo principal do projeto.
  Ele recebe como entrada os valores das chaves e dos botões e
  retorna quais LEDs e quais colunas da matriz de LEDs devem ser acesos,
  além de usar o display de 7 segmentos para exibir o código do usuário
  que tem menor prioridade quando a funcionalidade 2 é selecionada.
*/
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
  wire [2:0] Func0, Func1; // funcao verificada
  wire [2:0] Func0_NV, Func1_NV; // funcao não verificada
  
  wire [6:0] Matriz0, Matriz1;
  wire [3:0] Leds0, Leds1;

  wire [2:0] UserMenorPrioridade;
  wire [1:0] Prioridade, Selecao;
  wire ehIgual, ehDiferente;
  wire W_M7, W_M6, W_M5, W_M4, W_M3, W_M2, W_M1;

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

  and and8 (Func0_NV[2], CH3);
  and and7 (Func0_NV[1], Not_BTN0);
  and and6 (Func0_NV[0], Not_BTN1);

  and and11 (Func1_NV[2], CH7);
  and and10 (Func1_NV[1], Not_BTN2);
  and and9 (Func1_NV[0], Not_BTN3);

  // Verifica se os usuários tem a permissão de usar a funcionalidade
  // se sim, a funcionalidade é passada para a saída
  // se não, a saída é 000
  verificadorDePermissao verificadorDePermissao0 (.User(User0), .Func(Func0_NV), .S(Func0));
  verificadorDePermissao verificadorDePermissao1 (.User(User1), .Func(Func1_NV), .S(Func1));

  // compara a prioridade dos usuarios
  comparadorDePrioridade comparadorDePrioridade0 (User0, User1, Prioridade, UserMenorPrioridade);

  // liga o led do piloto automatico
  // Prioridade é 11 quando os dois usuarios tem entrada 111
  and andPA (LED_G, Prioridade[1], Prioridade[0]);

  // se os forem funcionalidades diferentes, ambos executam
  comparadorDeIgualdade comparadorDeIgualdade0 (.A(Func0), .B(Func1), .S(ehIgual));

  // inverte a saida de ehIgual
  not not0 (ehDiferente, ehIgual);

  // Selecao é 11 se ambos devem executar
  // Selecao é 10 se apenas o usuario 1 deve executar
  // Selecao é 01 se apenas o usuario 0 deve executar
  // Selecao é 00 se nenhum deve executar
  or or0 (Selecao[0], Prioridade[0], ehDiferente);
  or or1 (Selecao[1], Prioridade[1], ehDiferente);

  // decodifica a funcionalidade para o usuario 1
  decodificadorDeFuncionalidade decodificadorDeFuncionalidade0(User0, Func0, Matriz0[6], Matriz0[5], Matriz0[4], Matriz0[3], Matriz0[2], Matriz0[1], Matriz0[0], Leds0[3], Leds0[2], Leds0[1], Leds0[0]);

  // decodifica a funcionalidade para o usuario 2
  decodificadorDeFuncionalidade decodificadorDeFuncionalidade1(User1, Func1, Matriz1[6], Matriz1[5], Matriz1[4], Matriz1[3], Matriz1[2], Matriz1[1], Matriz1[0], Leds1[3], Leds1[2], Leds1[1], Leds1[0]);  

  // seleciona a saida da matriz de leds
  seletorDeFuncionalidade seletorDeFuncionalidade1(Selecao, Matriz0[6], Matriz1[6], W_M7);
  seletorDeFuncionalidade seletorDeFuncionalidade2(Selecao, Matriz0[5], Matriz1[5], W_M6);
  seletorDeFuncionalidade seletorDeFuncionalidade3(Selecao, Matriz0[4], Matriz1[4], W_M5);
  seletorDeFuncionalidade seletorDeFuncionalidade4(Selecao, Matriz0[3], Matriz1[3], W_M4);
  seletorDeFuncionalidade seletorDeFuncionalidade5(Selecao, Matriz0[2], Matriz1[2], W_M3);
  seletorDeFuncionalidade seletorDeFuncionalidade6(Selecao, Matriz0[1], Matriz1[1], W_M2);
  seletorDeFuncionalidade seletorDeFuncionalidade7(Selecao, Matriz0[0], Matriz1[0], W_M1);

  // inverte a saida da matriz de leds
  // matriz tem logica invertida
  not not1 (M1, W_M1);
  not not2 (M2, W_M2);
  not not3 (M3, W_M3);
  not not4 (M4, W_M4);
  not not5 (M5, W_M5);
  not not6 (M6, W_M6);
  not not7 (M7, W_M7);

  // seleciona a saida dos leds
  seletorDeFuncionalidade seletorDeFuncionalidade8(Selecao, Leds0[3], Leds1[3], LED6);
  seletorDeFuncionalidade seletorDeFuncionalidade9(Selecao, Leds0[2], Leds1[2], LED4);
  seletorDeFuncionalidade seletorDeFuncionalidade10(Selecao, Leds0[1], Leds1[1], LED3);
  seletorDeFuncionalidade seletorDeFuncionalidade11(Selecao, Leds0[0], Leds1[0], LED1);

  decodificadorDeDisplay decodificadorDeDisplay(
    .User(UserMenorPrioridade),
    .Enable(W_M2), // ativa na funcionalidade 2
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
    User0 = 3'b101; Func0 = 3'b001; User1 = 3'b001; Func1 = 3'b001; #10;

    // admin - user ; func 2 ; func 1 = led1 e m2
    User0 = 3'b101; Func0 = 3'b010; User1 = 3'b001; Func1 = 3'b001; #10;

    // admin - user ; neutro ; func 1 = led3
    User0 = 3'b101; Func0 = 3'b000; User1 = 3'b001; Func1 = 3'b011; #10;

    // piloto automatico - piloto automatico ; led rgb
    User0 = 3'b111; Func0 = 3'b101; User1 = 3'b111; Func1 = 3'b101; #10;

    // casos em que um dos usuarios é invalido
    // admin - nao exite ; m3
    User0 = 3'b101; Func0 = 3'b011; User1 = 3'b100; Func1 = 3'b010; #10;

    // user - nao existe - led1
    User0 = 3'b001; Func0 = 3'b001; User1 = 3'b100; Func1 = 3'b010; #10;

    // user - nao existe - led1
    User0 = 3'b001; Func0 = 3'b001; User1 = 3'b100; Func1 = 3'b001; #10;

    // user - nao existe - m3
    User0 = 3'b011; Func0 = 3'b011; User1 = 3'b100; Func1 = 3'b001; #10;

    // user - nao existe - led 6
    User0 = 3'b110; Func0 = 3'b110; User1 = 3'b100; Func1 = 3'b001; #10;

    // nao existe - admin ; m3
    User0 = 3'b100; Func0 = 3'b011; User1 = 3'b101; Func1 = 3'b011; #10;

    // nao existe - nao existe ; 
    User0 = 3'b100; Func0 = 3'b011; User1 = 3'b100; Func1 = 3'b011; #10;
  end
endmodule
