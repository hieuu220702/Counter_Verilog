module counter (Clk, reset_n, count);
  input wire Clk;
  input wire reset_n;
  output reg [2:0] count;

  always @(posedge Clk or negedge reset_n) begin
    if (reset_n == 1'b0)
      count <= 3'b000;
    else
      count <= count + 1'b1; 
 	 
  end 
endmodule
