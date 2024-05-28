`timescale 1ns/1ps 







module counter(clk,rst_n,cntrl,D,MOD,led,button);
    input clk, rst_n, button;
    input [2:0]cntrl;
    input [3:0]D;
    reg[3:0] out;
    reg [3:0] out_next=4'b0;
    reg i = 1'b0;
    reg Clock_1Hz;
    reg [25:0]count_50000000;
    wire start_count;
    output reg [15:0]led;
    input [3:0]MOD;
    
    // Debouncing circuit  
    TOP TOP(.clk(clk), .reset(rst_n), .button(button), .debounced(start_count));
     
    always @(posedge clk)
    begin
        if (rst_n)begin
            out <= 4'b0;
            end
        else if(start_count)
            out <= out_next;
     end
     always @(posedge clk) begin 
         case(cntrl)
    
            3'b001:                         // up counter
                    if(out == MOD)begin
                        out_next = 0;
                        end
                    else 
                        out_next = out + 4'd1;
            3'b101:                         // down counter
               if(out == 4'd0)
                    out_next = MOD;
                else 
                    out_next = out - 1;
            3'b011:                          //load value
                out_next = D;
        
            3'b100:                          //up-down counter
                if (i == 1'b1)begin
                    if(out == MOD)begin
                        
                        out_next = out - 1;
                        i = 1'b0;
                        end
                     else
                        out_next = out +1;
                     end
                 else begin
                    if(out == 4'b0)begin
                       
                        out_next = out + 1;
                        i = 1'b1;
                        end
                    else begin
                        out_next = out - 1;
                        end
                  end
                          
            3'b000:                                           // hold value
                out_next = out;
        
            3'b110:                                          //local syn reset
                out_next = 4'b0;
            default:                                         // Don't care state
                out_next = 4'bx;

        endcase    
                
            end    
                
    
    always @(posedge clk)begin  // Binary to thermometric code
                  case (out)
                            4'd0: led = 16'd0;
                            4'd1: led = 16'd1;
                            4'd2: led = 16'd3;
                            4'd3: led = 16'd7;
                            4'd4: led = 16'd15;
                            4'd5: led = 16'd31;
                            4'd6: led = 16'd63;
                            4'd7: led = 16'd127;
                            4'd8: led = 16'd255;
                            4'd9: led = 16'd511;
                            4'd10: led = 16'd1023;
                            4'd11: led = 16'd2047;
                            4'd12: led = 16'd4095;
                            4'd13: led = 16'd8191;
                            4'd14: led = 16'd16383;
                            4'd15: led = 16'd32767;
                            endcase  
    end

// Generate a clock of period one second

 
              
endmodule