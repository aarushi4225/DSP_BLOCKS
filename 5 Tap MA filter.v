`timescale 1ns / 1ps

module MAfilter
# (parameter W = 16)
(input wire clk, rstn, val_in,
input wire signed [W-1:0] xin, 
output reg val_out,
output reg signed [W-1:0] out);

reg signed [W-1:0] x1, x2, x3,x4;

always@(posedge clk) begin 
    if (!rstn) begin 
        x1 <= 0; x2 <= 0; x3 <= 0; x4 <= 0;
        out<=0; val_out <= 1'b0;
    end
    else if(val_in) begin 
         x4 <= x3;
         x3 <= x2;
         x2 <= x1;
         x1 <= xin;
         
         out <= (xin+x1+x2+x3+x4)/5;
         val_out <= 1'b1;
    end
    else begin
         val_out <= 1'b0;
    end
end
endmodule
