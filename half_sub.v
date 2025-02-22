module half_sub(
    // Declare your A/B inputs
    
    input A, B,
    
    // Declare Y output
    output Y, Cout
    
    // Declare carry output

);

    // Enter logic equation here
    assign Y = A ^ B;
    assign Cout = ~A & B;

    

endmodule// Implement module called full_adder