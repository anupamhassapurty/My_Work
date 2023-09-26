class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)

	function new(input string name = "monitor", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	uvm_analysis_port#(transaction)send;
	transaction tr;
	virtual add_if aif;

	virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
		tr = transaction::type_id::create("tr");
		send = new("send",this);
		if(!uvm_config_db#(virtual add_if)::get(this,"","aif",aif))
			`uvm_error("MON", "Unable to access Interface")
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			repeat(2) @(posedge aif.clk);
				tr.a     = aif.a;
				tr.b     = aif.b;
				tr.sum 	 = aif.sum;
				tr.carry = aif.carry;

				`uvm_info("MON", $sformatf("a : %0d, b : %0d, Result : %0d",tr.a,tr.b,{tr.carry,tr.sum}),UVM_NONE)

				send.write(tr);
		end
	endtask

endclass
