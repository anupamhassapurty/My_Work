class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)

	function new(input string name = "transaction");
		super.new(name);
	endfunction

	rand bit [3:0]a;
    rand bit [3:0]b;
    	 bit [3:0]sum;
    	 bit carry;

endclass
