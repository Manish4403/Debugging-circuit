`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 19:19:32
// Design Name: 
// Module Name: Timer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Timer(clk, reset, enable, done);
    input clk,reset,enable;
    output done;
//    parameter final = 1;
    reg [20:0]count; 
    reg [0:0]count_next;
    always @(posedge clk)
    begin
        if(reset)begin
            count <= 0;
            count_next <= 0;
            end
        else if(count == 1999999)
            begin
                count_next <= 1'b1;
                count <= 0;
            end
        else if(enable)begin
            count <= count + 1;
            count_next <= 0;
            end
        
     end
         
     assign done = count_next ? 1'b1 : 1'b0;

endmodule
