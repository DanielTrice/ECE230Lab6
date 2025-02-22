// Implement top level module
module top(
    input[9:0] sw,
    output[13:0] led
);
 
 half_sub halfsub( 
        .A(sw[0]),// Hook up its A to sw[0],
        .B(sw[1]),
        .Y(led[0]),
        .Cout(led[1])
    );
    
ones_compliment onescomp (
    .A(sw[5:2]),
    .B(sw[9:6]),
    .Y(led[5:2])
    );
    
twos_compliment twocomp(
    .A(sw[9:2]),
    .Y(led[13:6])
);

/*wire carry;

    
    full_adder fA_LSB(
        .A(sw[4]), // Hook up its C to sw[2]
        .B(sw[6]), // Hook up its D to sw[3]
        .Cin(0),
        .Y(led[3]),
        .Cout(carry)
    );
      full_adder fA_MSB( 
        .A(sw[5]), // Hook up its C to sw[2]
        .B(sw[7]), // Hook up its D to sw[3]
        .Cin(carry),
        .Y(led[4]),
        .Cout(led[5])
    );
    
    light lightSwitch(
        .upstairs(sw[0]),
        .downstairs(sw[1]),
        .stair_light(led[0])

      );
*/

endmodule