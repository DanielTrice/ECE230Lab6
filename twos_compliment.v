module twos_compliment (
    input [7:0] A,
    output[7:0] Y
);


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
        .A(~A[0]),
        .B(1),
        .Y(Y[0]),
        .Cin(1'b0), // Fix to zero
        .Cout(carry)
    );
    
    full_adder lsb2_inter(
        .A(~A[1]),
        .B(0),
        .Y(Y[1]),
        .Cin(carry), // Fix to zero
        .Cout(second_carry)
    );

    full_adder msb2_inter(
        .A(~A[2]),
        .B(0),
        .Y(Y[2]),
         .Cin(second_carry), // Fix to zero
        .Cout(third_carry)
    );
    
    full_adder msb_inter(
        .A(~A[3]),
        .B(0),
        .Y(Y[3]),
        .Cin(third_carry),
        .Cout(around)
    );


    // Second addition
    full_adder lsb(
        .A(~A[4]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[4]), // This is now the real summation
        .Cin(around), // Fix to zero
        .Cout(second_carry2) // We still need to carry to second
        // bit of second addition
    );
    
     full_adder lsb2(
        .A(~A[5]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[5]), // This is now the real summation
        .Cin(second_carry2), // Fix to zero
        .Cout(third_carry2) // We still need to carry to second
        // bit of second addition
    );
    
     full_adder msb2(
        .A(~A[6]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[6]), // This is now the real summation
        .Cin(third_carry2), // Fix to zero
        .Cout(fourth_carry2) // We still need to carry to second
        // bit of second addition
    );

    full_adder msb(
        .A(~A[7]),
        .B(1'b0),
        .Y(Y[7]),
        .Cin(fourth_carry2)
        // no carry out!
    );

endmodule