module ones_compliment (
    input [3:0] A, B,
    output[3:0] Y
);

    // Stores the intermediary sum (A + B)
    wire [3:0] APlusB;
    // The carry used for A+B. Will need to scale
    // up in higher order addition
    wire carry;
    
    // The carr out of A+B
    wire around;
    // The carry used for (A + B) + around
    wire second_carry;
    // The carry used for (A + B) + around + around
    wire third_carry;
    // The carry used for (A + B) + around + around + around
    wire fourth_carry;
    
    wire second_carry2;

    wire third_carry2;
    wire fourth_carry2;
    
    // First addition
    full_adder lsb_inter(
        .A(A[0]),
        .B(~B[0]),
        .Y(APlusB[0]),
        .Cin(1'b0), // Fix to zero
        .Cout(carry)
    );
    
    full_adder lsb2_inter(
        .A(A[1]),
        .B(~B[1]),
        .Y(APlusB[1]),
        .Cin(carry), // Fix to zero
        .Cout(second_carry)
    );

    full_adder msb2_inter(
        .A(A[2]),
        .B(~B[2]),
        .Y(APlusB[2]),
         .Cin(second_carry), // Fix to zero
        .Cout(third_carry)
    );
    
    full_adder msb_inter(
        .A(A[3]),
        .B(~B[3]),
        .Y(APlusB[3]),
        .Cin(third_carry),
        .Cout(around)
    );


    // Second addition
    full_adder lsb(
        .A(APlusB[0]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[0]), // This is now the real summation
        .Cin(around), // Fix to zero
        .Cout(second_carry2) // We still need to carry to second
        // bit of second addition
    );
    
     full_adder lsb2(
        .A(APlusB[1]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[1]), // This is now the real summation
        .Cin(second_carry2), // Fix to zero
        .Cout(third_carry2) // We still need to carry to second
        // bit of second addition
    );
    
     full_adder msb2(
        .A(APlusB[2]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[2]), // This is now the real summation
        .Cin(third_carry2), // Fix to zero
        .Cout(fourth_carry2) // We still need to carry to second
        // bit of second addition
    );

    full_adder msb(
        .A(APlusB[3]),
        .B(1'b0),
        .Y(Y[3]),
        .Cin(fourth_carry2)
        // no carry out!
    );

endmodule