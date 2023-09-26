class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)

	function new(input string name = "driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	transaction tr;
	virtual add_if aif;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual add_if)::get(this,"","aif",aif))
			`uvm_error("DRV", "Unable to access Interface");
	endfunction

	virtual task run_phase(uvm_phase phase);
		tr = transaction::type_id::create("tr");
		forever begin
			seq_item_port.get_next_item(tr);
				aif.a <= tr.a;
				aif.b <= tr.b;
				`uvm_info("DRV", $sformatf("a : %0d, b : %0d, Result : %0d",tr.a,tr.b,{tr.carry,tr.sum}),UVM_NONE)
			seq_item_port.item_done();

          repeat(2) @(posedge aif.clk);
		end
	endtask

endclass
