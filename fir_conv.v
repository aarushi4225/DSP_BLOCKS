`timescale 1ns / 1ps

module fir_conv
# (parameter W = 16, L = 2)
(input wire clk, rstn, val_in,
input wire signed [W-1:0] xin,
output reg val_out,
output reg signed [W-1:0] cD, cA);

localparam signed [W*L-1:0] H0 = { 16'sd1,  16'sd1};
localparam signed [W*L-1:0] H1 = { 16'sd1, -16'sd1};
// array
reg signed [W-1:0] x [0:L-2];
integer i;

reg signed [W+3:0] accA, accD;

always@(posedge clk) begin 
    if(!rstn) begin 
        for (i = 0; i < L-1; i = i+1) x[i] <= 0;
            cA <= 0; cD <= 0;
            val_out <= 1'b0;
    end 
    else if(val_in) begin 
        accA = xin * H0[(0+1)*W-1 -: W];
        accD = xin * H1[(0+1)*W-1 -: W];
        
        for (i = 0; i < L-1; i = i+1) begin
                accA = accA + x[i] * H0[(i+2)*W-1 -: W];
                accD = accD + x[i] * H1[(i+2)*W-1 -: W];
            end
        cA <= accA;
        cD <= accD;
        
        for (i = L-2; i > 0; i = i-1) x[i] <= x[i-1];
        x[0] <= xin;
        val_out <= 1'b1;
    end
    
    else val_out <= 1'b0;
    
end

endmodule
