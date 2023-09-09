class monitor;
	virtual ram_if rif;
	
	transaction t3;
	mailbox #(transaction) mbx;
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
		t3 = new;
	endfunction

	task run;
		forever begin
          repeat(2) begin
            @(posedge rif.a_clk);
            @(posedge rif.b_clk);
          end
			t3.a_wr   = rif.a_wr;
			t3.a_addr = rif.a_addr;
			t3.a_din  = rif.a_din;
          	t3.a_dout = rif.a_dout;
			t3.display_a("MON","RCVD");
			
          	t3.b_wr   = rif.b_wr;
			t3.b_addr = rif.b_addr;
			t3.b_din  = rif.b_din;
          	t3.b_dout = rif.b_dout;
			t3.display_b("MON","RCVD");
          
          mbx.put(t3);         
		end
	endtask
endclass

