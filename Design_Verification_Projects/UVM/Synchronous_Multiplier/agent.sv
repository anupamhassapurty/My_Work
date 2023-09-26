class agent extends uvm_agent;
	`uvm_component_utils(agent)

	function new(input string name = "agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction

  uvm_sequencer#(transaction) seqr;
	driver d;
	monitor m;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		d = driver::type_id::create("d",this);
		m = monitor::type_id::create("m",this);
		seqr = uvm_sequencer#(transaction)::type_id::create("seqr",this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		d.seq_item_port.connect(seqr.seq_item_export);
	endfunction

endclass
