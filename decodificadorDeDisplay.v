/*
Módulo responsável por exibir no display de 7 segmentos o código do usuário
que tem menor prioridade. Ele recebe como entrada o código do usuário
e exibe a no display a letra correspondente ao código do usuário.

Admin - A
Tester - T
User - U
Guest - G

*/
module decodificadorDeDisplay(
    User,
    Enable,
    A,B,C,D,E,F,G,DP
);
    input [2:0] User;
    input Enable;
    output A,B,C,D,E,F,G,DP;
    
    wire NOT_User2, NOT_User1, NOT_User0;
    wire W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14;
    wire NOT_Enable;

    not (NOT_User2, User[2]);
    not (NOT_User1, User[1]);
    not (NOT_User0, User[0]);
    not (NOT_Enable, Enable);

    // A
    and (W1, NOT_User2, NOT_User1);
    and (W2, User[1], User[0]);
    or (A, NOT_Enable, W1, W2);

    // B
    or (B, NOT_Enable, User[1], W3, NOT_User0);

    // C
    and (W3, NOT_User2, User[1]);
    and (W4, User[1], User[0]);
    and (W5, NOT_User1, NOT_User0);
    or (C, NOT_Enable, W3, W4, W5);

    // D
    and (W6, User[2], NOT_User1);
    and (W7, User[2], User[0]);
    and (W8, NOT_User2, NOT_User0);
    or (D, NOT_Enable, W6, W7, W8);

    // E
    and (W9, NOT_User2, NOT_User1, NOT_User0);
    and (W10, User[2], User[1], User[0]);
    or (E, NOT_Enable, W9, W10);

    // F
    and (W12, NOT_User2, NOT_User1, NOT_User0);
    and (W11, User[2], User[1], User[0]);
    or (F, NOT_Enable, W11, W12);

    // G
    and (W13, User[2], User[1]);
    and (W14, NOT_User2, NOT_User1);
    or (G, NOT_Enable, W13, W14);
    
    assign DP = 1;

endmodule

module TB_DecodificadorDeDisplay();
    reg [2:0] User;
    reg Enable;
    wire A,B,C,D,E,F,G,DP;

    decodificadorDeDisplay decodificadorDeDisplay(
        User,
        Enable,
        A,B,C,D,E,F,G,DP
    );

    initial begin
        Enable = 1'b1; User = 3'b000; #10; // 111111111 - neutro - nada
        Enable = 1'b1; User = 3'b001; #10; // 10000011 - user - U
        Enable = 1'b1; User = 3'b010; #10; // 01110001 - invalido - F
        Enable = 1'b1; User = 3'b011; #10; // 11100001 - tester - T
        Enable = 1'b1; User = 3'b100; #10; // 01110001 - invalido - F
        Enable = 1'b1; User = 3'b101; #10; // 00010001 - admin - A
        Enable = 1'b1; User = 3'b110; #10; // 01000011 - guest = G 
        Enable = 1'b1; User = 3'b111; #10; // 111111111 - neutro - nada

        Enable = 1'b0; User = 3'b000; #10; // 111111111 - neutro - nada
        Enable = 1'b0; User = 3'b001; #10; // 111111111 - neutro - nada
        Enable = 1'b0; User = 3'b010; #10; // 111111111 - neutro - nada
        Enable = 1'b0; User = 3'b011; #10; // 111111111 - neutro - nada
        Enable = 1'b0; User = 3'b100; #10; // 111111111 - neutro - nada
        Enable = 1'b0; User = 3'b101; #10; // 111111111 - neutro - nada
        Enable = 1'b0; User = 3'b110; #10; // 111111111 - neutro - nada
        Enable = 1'b0; User = 3'b111; #10; // 111111111 - neutro - nada
    end
endmodule
