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
		
		`uvm_info("SCB", $sformatf("a : %0d, b : %0d, Result : %0d",tr.a,tr.b,{tr.carry,tr.sum}),UVM_NONE)

		if({tr.carry,tr.sum} == tr.a + tr.b)
			`uvm_info("SCB", "TEST PASSED ! --> Addition is Correct", UVM_NONE)
		else
			`uvm_info("SCB", "TEST FAILED --> Error in Addition", UVM_NONE)


		$display("==========================================================");

	endfunction

endclass
