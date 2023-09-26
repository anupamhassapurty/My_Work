class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)

	function new(input string name = "monitor", uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	uvm_analysis_port#(transaction)send;
	transaction tr;
	virtual mul_if mif;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr = transaction::type_id::create("tr");
		send = new("send",this);
		if(!uvm_config_db#(virtual mul_if)::get(this,"","mif",mif))
			`uvm_error("MON", "Unable to access Interface");
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			repeat(2) @(posedge mif.clk);
				tr.m = mif.m;
				tr.n = mif.n;
				tr.mul = mif.mul;

				`uvm_info("MON", $sformatf("m = %0d n = %0d mul = %0d",tr.m,tr.n,tr.mul), UVM_NONE)

				send.write(tr);
		end
	endtask

endclass
