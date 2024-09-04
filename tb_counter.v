module tb_counter;
  reg Clk, reset_n;
  wire [2:0] count;

  integer exp_count;
  integer count_err=0;
  integer var_err=0;

  counter u_dut(.Clk(Clk), .reset_n(reset_n), .count(count));

  initial begin
    Clk = 0;
    forever #10 Clk = ~Clk;
  end

  initial begin
    reset_n = 1'b0;
    #100 reset_n = 1'b1;
    #500;
    if(var_err == 0) begin
      if(count_err == 0)
        $display("\n==================\nStatus: TEST PASSED\n==================\n ");
      else 
        $display("\n==================\nStatus: TEST FAILED\nThe number of Error: %0d\n==================\n", count_err);
    end
    else 
      $display("\n==================\nStatus: TEST FAILED with Variable Error: %0d\n==================\n", var_err);
    $finish;
  end

  initial
    $monitor("Time = %0t: reset = %0b, count = %0d", $stime, reset_n, count);


//checker
  
  initial begin
    exp_count = -1;
    forever begin
      if(reset_n == 1'b0)
        //exp_count = 0;
	wait(reset_n == 1'b1);
      else 
        @(posedge Clk); #1;
      exp_count = exp_count + 1;
      if (exp_count == count) 
    	$display("[Checker] MATCHING: RTL actual count: %0d, Expected count: %0d", count, exp_count);
      else if(exp_count != count) begin
	count_err = count_err + 1;
    	$display("[Checker] ERROR: RTL actual count: %0d, Expected count: %0d", count, exp_count);
      end
      else begin
	$display("Can not compare between checker value and simulation value. Please double check variable in RTL code or Testbench code!");
	var_err = var_err + 1;
      end

      if (exp_count == 7)
	exp_count = -1;
    end
  end

endmodule
