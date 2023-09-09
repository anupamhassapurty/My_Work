`define MON_IF fif.MONITOR.monitor_cb

class monitor;
	virtual fifo_if fif;
	
	transaction t3;
	mailbox #(transaction) mbx;
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
		//t3 = new;
	endfunction

	task run;
		forever begin
          t3 = new;
          repeat(1) @(posedge fif.MONITOR.clk); 
          t3.data_out  = `MON_IF.data_out;
          t3.full      = `MON_IF.full;
         // $display("%0t t3 full = %0b",$time,t3.full);
          //$display("%0t fif full = %0b",$time,fif.full);
			t3.empty     = `MON_IF.empty;
			t3.overflow  = `MON_IF.overflow;
			t3.underflow = `MON_IF.underflow;
			t3.overrun   = `MON_IF.overrun;
			t3.underrun  = `MON_IF.underrun;
          		 
          	t3.write_enable = `MON_IF.write_enable;
			t3.read_enable  = `MON_IF.read_enable;
			t3.data_in 	    = `MON_IF.data_in;	

         // repeat(1) @(posedge fif.MONITOR.clk); 
			mbx.put(t3);
			
			t3.display("MON","RCVD");
		end
	endtask
endclass
