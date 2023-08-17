`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/14 15:31:39
// Design Name: 
// Module Name: top_tb
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


module top_tb();
reg clk, rst;
reg [7:0] a,b;
wire [15:0] result;

top DUT(clk,rst, a, b, result);

always #10 clk = ~clk;
initial begin
clk = 0;
rst = 1;
#20 rst = 0;
end


reg [15:0] exp;
integer in_fp, exp_fp, result_fp;
integer in_fp_val, exp_fp_val;
integer  i,j;
initial begin
    in_fp = $fopen("input.dat", "r");
    exp_fp = $fopen("expected.dat", "r");
    result_fp = $fopen("result1.dat", "w");
end

initial begin
    @(negedge rst);
    @(negedge clk)begin
        in_fp_val = $fscanf(in_fp, "%h %h", a, b);
        end
     for(i = 1; i <= 15; i = i+ 1) begin
     repeat(5) @(negedge clk);
     in_fp_val = $fscanf(in_fp, "%h %h", a, b);
     end
end

initial begin
    @(negedge rst);
    repeat (2) @(negedge clk);
    exp_fp_val = $fscanf(exp_fp, "%h", exp);
    @(negedge clk) begin
    compare(result_fp, 0, result, exp);
    end
    for(j = 1; j <= 15; j = j + 1)begin
    repeat(5) @(negedge clk);
    exp_fp_val = $fscanf(exp_fp, "%h", exp);
    compare(result_fp, j, result, exp);
    end
end

initial begin
    #2000;
    $fclose(in_fp);
    $fclose(exp_fp);
    $fclose(result_fp);
end


task compare(
input integer fd, v,
input [31:0] cal_val, exp_val);

if(cal_val != exp_val) begin
    $fdisplay(fd, "[%0d] : UnCorrect", v);
    $fdisplay(fd, " EXpected %0d, Calculated %0d", exp_val, cal_val);
    end
    else begin
    $fdisplay(fd, "[%0d] : Correct", v);
    $fdisplay(fd, " EXpected %0d, Calculated %0d", exp_val, cal_val);
    end
endtask

endmodule
