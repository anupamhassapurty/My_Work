class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)

	rand bit [7:0]m;
	rand bit [7:0]n;
		 bit [15:0]mul;

	function new(input string name = "transaction");
		super.new(name);
	endfunction

endclass
