`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/14 15:27:23
// Design Name: 
// Module Name: top
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


module top(clk, rst, a, b, result);
input clk, rst;
input [7:0] a,b;
output reg [15:0] result;

reg [7:0] a_reg, b_reg;

always@(posedge clk, posedge rst)
begin
    if(rst)begin
        a_reg <= 0;
        b_reg <= 0;
        result <= 0;
     end
    else
    begin
        a_reg <= a;
        b_reg <= b;
        result <= a_reg * b_reg;
    end
end    
    
endmodule
