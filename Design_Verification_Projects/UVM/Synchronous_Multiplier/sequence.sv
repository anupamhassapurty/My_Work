class sequence1 extends uvm_sequence#(transaction);
	`uvm_object_utils(sequence1)

	function new(input string name = "sequence1");
		super.new(name);
	endfunction

	transaction tr;

	virtual task body;
		repeat(10) begin
			tr = transaction::type_id::create("tr");
			start_item(tr);
				assert(tr.randomize);
				`uvm_info("SEQ", $sformatf("m = %0d n = %0d mul = %0d",tr.m,tr.n,tr.mul), UVM_NONE)
			finish_item(tr);
		end
	endtask

endclass	
