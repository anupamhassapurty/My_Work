class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)

	function new(input string name = "driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	transaction tr;
	virtual mul_if mif;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual mul_if)::get(this,"","mif",mif))
			`uvm_error("DRV", "Unable to access interface");
	endfunction

	virtual task run_phase(uvm_phase phase);
		tr  = transaction::type_id::create("tr");
		forever begin
			seq_item_port.get_next_item(tr);
				mif.m <= tr.m;
				mif.n <= tr.n;
				`uvm_info("DRV", $sformatf("m = %0d n = %0d mul = %0d",tr.m,tr.n,tr.mul), UVM_NONE)
			seq_item_port.item_done();

			repeat(2) @(posedge mif.clk);
		end
	endtask

endclass
   			
