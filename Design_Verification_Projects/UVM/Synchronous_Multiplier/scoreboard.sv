class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

	uvm_analysis_imp#(transaction,scoreboard) recv;

	function new(input string name = "scoreboard", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		recv = new("recv",this);
	endfunction

	virtual function void write(transaction tr);
		`uvm_info("SCB", $sformatf("m = %0d n = %0d mul = %0d",tr.m,tr.n,tr.mul), UVM_NONE)

		if(tr.mul == tr.m * tr.n)
			`uvm_info("SCB","Multiplication Data Matched", UVM_NONE)
		else
			`uvm_info("SCB","ERROR in Multiplication", UVM_NONE)


          $display("===================================================================");

	endfunction

endclass
