module mac(
        inout_a,
        input_b,
        input_c,
        input_a_stb,
        input_b_stb,
        input_c_stb,
        output_z_ack,
        clk,
        rst,
        output_z_stb,
        input_a_ack,
        input_b_ack
        input_c_);

    
    input     clk;
    input     rst;

    inout     [31:0] input_a;
    input     input_a_stb;
    output    input_a_ack;

    input     [31:0] input_b;
    input     input_b_stb;
    output    input_b_ack;

    output    [31:0] output_z;
    output    output_z_stb;
    input     output_z_ack;

    wire [63:0]  


	adder ADDER (
        reg_a_stable,
        reg_b_stable,
        input_a_stable,
        input_b_stable,
        input_z_ack,
        clk,
        rst_n,
        output_z,
        output_z_stable,
        output_a_ack,
        output_b_ack);

    module multiplier(
        input_a,
        input_b,
        input_a_stb,
        input_b_stb,
        output_z_ack,
        clk,
        rst,
        output_z,
        output_z_stb,
        input_a_ack,
        input_b_ack);


endmodule