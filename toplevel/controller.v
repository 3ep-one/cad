module controller(
    input_a, input_b, input_op,
    input_a_stable, input_b_stable, input_op_stable,
    input_z_ack,
    output_a_ack, output_b_ack, output_op_ack,
    output_z,
    output_z_stable,
    clk, rst_n);
    input clk, rst_n;
    input  [31:0] input_a;
    input  [31:0] input_b;
    input [2:0] input_op;
    input input_a_stable, input_b_stable, input_op_stable;
    input input_z_ack;

    output output_a_ack, output_b_ack;
	output reg output_op_ack;
    output [31:0] output_z;
    output output_z_stable;

    reg [31:0]reg_a_stable;
	 reg [31:0]reg_b_stable;
    reg [2:0] reg_op_stable;
    parameter IDLE = 3'b000, 
              IF_1 = 3'b001, IF_2 = 3'b010, IF_3 = 3'b011,
              ID_1 = 3'b100,
              EX_1 = 3'b101;
    reg[2:0] state, next_state;



    // next state
    always @(posedge clk or posedge rst_n)
    begin
        if(rst_n)
		  begin
            state <= 3'b000;
            //reg_a_stable <= 64'b0;
            //reg_b_stable <= 64'b0;
            //reg_op_stable <= 3'b0;
            //output_z <= 64'b0;
		  end
        else 
            state <= next_state; 
    end

    // FSM
    always @(*)
    begin
        case(state)
            IDLE: 
            begin
                next_state = input_a_stable ? IF_1 : IDLE;
            end
            IF_1: 
            begin
                next_state = input_b_stable ? IF_2 : IF_1;
            end
            IF_2: 
            begin
                next_state = input_op_stable ? IF_3 : IF_2;
            end
            IF_3:
            begin
                next_state = ID_1;
            end
            ID_1:
            begin
                next_state = EX_1;
            end
            EX_1:
            begin
                next_state = IDLE;
            end
            default:
            begin 
                next_state = IDLE;
            end
        endcase
    end

    
    reg [63:0] output_adder_single;

    adder ADDER (reg_a_stable,
        reg_b_stable,
        input_a_stable,
        input_b_stable,
        input_z_ack,
        clk,
        rst_n,
        output_adder_single,
        output_z_stable,
        output_a_ack,
        output_b_ack);
 
	 
    // SIGNAL
    always @(state)
    begin
        //output_a_ack <= 1'b0;
        //output_b_ack <= 1'b0;
        //output_op_ack <= 1'b0;
        //output_z_stable <= 1'b0;
        //output_z <= 64'b0;
        case(state)
            IDLE: 
            begin
                //output_z <= 64'b0;
            end
            IF_1: 
            begin
                reg_a_stable <= input_a;
                //output_a_ack <= 1'b1;
            end
            IF_2: 
            begin
                reg_b_stable <= input_b;
                //output_b_ack <= 1'b1;
            end
            IF_3:
            begin
                reg_op_stable <= input_op;
                output_op_ack <= 1'b1;
            end
            ID_1:
            begin

                if(reg_op_stable == 3'b000)
                begin
                    
                end

            end
            EX_1:
            begin
                //output_z_stable <= 1'b1;
            end
            default:
            begin
            //TODO: ?????
                reg_a_stable <= 32'b0;
                reg_b_stable <= 32'b0;
                reg_op_stable <= 3'b0;
            end
        endcase
    end

endmodule 