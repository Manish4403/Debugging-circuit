`timescale 1ns/1ps


module FSM(button,clk,timer_reset, Debounced, timer_done,reset);
    input button,clk,reset,timer_done;
    output timer_reset, Debounced;
    reg [3:0]shift_reg, next_state;
    parameter [3:0] s0 = 4'b0001,
                    s1 = 4'b0010,
                    s2 = 4'b0100,
                    s3 = 4'b1000;
    always @(posedge clk) begin
        if(reset)
            shift_reg <= s0;
        else
            shift_reg <= next_state;
    end
    
    always @(*)begin
        case(shift_reg)
             s0: begin
                    if(~button)
                        next_state = s0;
                    else
                        next_state = s1;
                 end
             s1: begin
                    if(button && timer_done)
                        next_state = s2;
                    else if(button && ~timer_done)
                        next_state = s1;
                    else if(~button)
                        next_state = s0; 
                 end
              s2: begin
                    if(button)
                        next_state = s2;
                    else
                        next_state = s3;
                  end
              s3: begin
                    if(~button && ~timer_done)
                        next_state = s3;
                    else if(~button && timer_done)
                        next_state = s0;
                    else if(button)
                        next_state = s2;
                  end
              default: next_state = s0;
                
        endcase
    end
    assign timer_reset = (shift_reg == s0) || (shift_reg == s2);
    assign Debounced = (shift_reg == s3) || (shift_reg == s2);
endmodule