class test extends uvm_test;
	`uvm_component_utils(test)

	function new(input string name = "test", uvm_component parent);
		super.new(name,parent);
	endfunction

	env e;
	sequence1 seq;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		e = env::type_id::create("env",this);
		seq = sequence1::type_id::create("seq");
	endfunction

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			seq.start(e.a.seqr);
			#20;
		phase.drop_objection(this);
	endtask

endclass	
