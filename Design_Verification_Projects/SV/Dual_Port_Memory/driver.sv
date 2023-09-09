class driver;
	virtual ram_if rif;
	
	mailbox #(transaction) mbx;
	
	transaction t2;
		
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
      	t2 = new;
	endfunction

	//reset dut
	task reset;
      @(posedge rif.a_clk);
      t2.display_a("DRV","RESET");
			rif.a_wr   <= 'b0;
			rif.a_addr <= 'b0;
			rif.a_din  <= 'b0;
      @(posedge rif.a_clk);
      
      @(posedge rif.b_clk);
	  t2.display_b("DRV","RESET");
			rif.b_wr   <= 'b0;
			rif.b_addr <= 'b0;
			rif.b_din  <= 'b0;
      @(posedge rif.b_clk);
	endtask
	
	//Apply random stimulus to DUT
	task run;
		forever begin
			mbx.get(t2);
			
			t2.display_a("DRV","SENT");
			rif.a_wr   <= t2.a_wr;
			rif.a_addr <= t2.a_addr;
			rif.a_din  <= t2.a_din;
			
          	t2.display_b("DRV","SENT");
			rif.b_wr   <= t2.b_wr;
			rif.b_addr <= t2.b_addr;
			rif.b_din  <= t2.b_din;
			
          repeat(2) begin
            @(posedge rif.a_clk);
            @(posedge rif.b_clk);
          end
		end
	endtask
endclass
