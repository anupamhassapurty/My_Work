`define MON_IF mif.MONITOR.monitor_cb

class monitor;

	virtual mul_if mif;

	transaction t3;
	mailbox #(transaction) mbx;

	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
		t3 = new;
	endfunction

	task run;
		forever begin
			repeat(2) @(posedge mif.MONITOR.clk);
			t3.m = `MON_IF.m;
			t3.n = `MON_IF.n;
			t3.mul = `MON_IF.mul;

			mbx.put(t3);

			t3.display("MON","RCVD");
		end

	endtask

endclass

