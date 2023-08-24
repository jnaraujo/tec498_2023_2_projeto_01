module decodificadorDeDisplay(
    User,
    A,B,C,D,E,F,G,DP
);
    input [2:0] User;
    output A,B,C,D,E,F,G,DP;
    
    wire NOT_User2, NOT_User1, NOT_User0;
    wire W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12;

    not (NOT_User2, User[2]);
    not (NOT_User1, User[1]);
    not (NOT_User0, User[0]);
    
    // A = ( NOT a AND NOT b) OR ( NOT a AND c)			
    and (W1, NOT_User2, NOT_User1);
    and (W2, NOT_User2, User[0]);
    or (A, W1, W2);

    // B = ( NOT a AND b) OR NOT c
    and (W3, NOT_User2, User[1]);
    or (B, W3, NOT_User0);

    // C = ( NOT a AND b) OR (b AND c) OR ( NOT b AND NOT c)
    and (W4, NOT_User2, User[1]);
    and (W5, User[1], User[0]);
    and (W6, NOT_User1, NOT_User0);
    or (C, W4, W5, W6);

    // D = (a AND NOT b) OR (a AND c) OR ( NOT a AND NOT c)
    and (W7, User[2], NOT_User1);
    and (W8, User[2], User[0]);
    and (W9, NOT_User2, NOT_User0);
    or (D, W7, W8, W9);

    // E = NOT a AND NOT b AND NOT c
    and (E, NOT_User2, NOT_User1, NOT_User0);

    // F = NOT a AND NOT b AND NOT c
    and (F, NOT_User2, NOT_User1, NOT_User0);

    // G = (a AND b AND NOT c) OR ( NOT a AND NOT b)
    and (W10, User[2], User[1], NOT_User0);
    and (W11, NOT_User2, NOT_User1);
    or (G, W10, W11);
    
    assign DP = 1;

endmodule

module TB_DecodificadorDeDisplay();
    reg [2:0] User;
    wire A,B,C,D,E,F,G,DP;

    decodificadorDeDisplay decodificadorDeDisplay(
        User,
        A,B,C,D,E,F,G,DP
    );

    initial begin
        User = 000; #10; // 111111111 - neutro - nada
        User = 001; #10; // 10000011 - user - U
        User = 010; #10; // 01110001 - invalido - F
        User = 011; #10; // 11100001 - tester - T
        User = 100; #10; // 01110001 - invalido - F
        User = 101; #10; // 00010001 - admin - A
        User = 110; #10; // 01000011 - guest = G 
        User = 111; #10; // 00110001 - piloto automatico - P
    end
endmodule
