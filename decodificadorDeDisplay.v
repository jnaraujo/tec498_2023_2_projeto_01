module decodificadorDeDisplay(
    User,
    Enable,
    A,B,C,D,E,F,G,DP
);
    input [2:0] User;
    input Enable;
    output A,B,C,D,E,F,G,DP;
    
    wire NOT_User2, NOT_User1, NOT_User0;
    wire W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13;
    wire NOT_Enable;

    not (NOT_User2, User[2]);
    not (NOT_User1, User[1]);
    not (NOT_User0, User[0]);
    not (NOT_Enable, Enable);
    
    // A	
    and (W1, NOT_User2, NOT_User1);
    and (W2, NOT_User2, User[0]);
    or (A, NOT_Enable, W1, W2);

    // B
    and (W3, NOT_User2, User[1]);
    or (B, NOT_Enable, W3, NOT_User0);

    // C
    and (W4, NOT_User2, User[1]);
    and (W5, User[1], User[0]);
    and (W6, NOT_User1, NOT_User0);
    or (C, NOT_Enable, W4, W5, W6);

    // D
    and (W7, User[2], NOT_User1);
    and (W8, User[2], User[0]);
    and (W9, NOT_User2, NOT_User0);
    or (D, NOT_Enable, W7, W8, W9);

    // E
    and (W10, NOT_User2, NOT_User1, NOT_User0);
    or (E, NOT_Enable, W10);

    // F
    and (W11, NOT_User2, NOT_User1, NOT_User0);
    or (F, NOT_Enable, W11);

    // G
    and (W12, User[2], User[1], NOT_User0);
    and (W13, NOT_User2, NOT_User1);
    or (G, NOT_Enable, W12, W13);
    
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
        Enable = 1; User = 000; #10; // 111111111 - neutro - nada
        Enable = 1; User = 001; #10; // 10000011 - user - U
        Enable = 1; User = 010; #10; // 01110001 - invalido - F
        Enable = 1; User = 011; #10; // 11100001 - tester - T
        Enable = 1; User = 100; #10; // 01110001 - invalido - F
        Enable = 1; User = 101; #10; // 00010001 - admin - A
        Enable = 1; User = 110; #10; // 01000011 - guest = G 
        Enable = 1; User = 111; #10; // 00110001 - piloto automatico - P

        Enable = 0; User = 000; #10; // 111111111 - neutro - nada
        Enable = 0; User = 001; #10; // 111111111 - neutro - nada
        Enable = 0; User = 010; #10; // 111111111 - neutro - nada
        Enable = 0; User = 011; #10; // 111111111 - neutro - nada
        Enable = 0; User = 100; #10; // 111111111 - neutro - nada
        Enable = 0; User = 101; #10; // 111111111 - neutro - nada
        Enable = 0; User = 110; #10; // 111111111 - neutro - nada
        Enable = 0; User = 111; #10; // 111111111 - neutro - nada
    end
endmodule
