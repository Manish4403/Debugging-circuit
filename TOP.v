`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 19:18:38
// Design Name: 
// Module Name: TOP
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


module TOP(clk, reset, button, debounced);
    input clk,reset,button;
    output debounced;
    wire timer_done,timer_reset,level;
    
    // FSM 
    FSM fsm(.button(button), .clk(clk), .timer_reset(timer_reset), 
            .Debounced(level), .timer_done(timer_done), .reset(reset));
            
    // 20ms Timer
    Timer Timer(.clk(clk), .reset(timer_reset), .enable(~timer_reset), .done(timer_done));
    
    //Edge Detector
    edge_detector edge_detector(.clk(clk),.reset(reset), .level(level), .pulse(debounced));
    
    
    
endmodule
