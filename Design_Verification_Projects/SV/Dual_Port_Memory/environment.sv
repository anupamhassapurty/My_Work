class environment;

	generator g;
	driver d;
	monitor m;
	scoreboard s;
	
	mailbox #(transaction) gen2drv;
	mailbox #(transaction) mon2scb;
	
	event nextgs;
	
	virtual ram_if rif;
	
  function new(virtual ram_if rif);
		gen2drv = new;
		g = new(gen2drv);
		d = new(gen2drv);
		
		mon2scb = new;
		m  = new(mon2scb);
		s  = new(mon2scb);
		
		this.rif = rif;
		
		d.rif = this.rif;
		m.rif = this.rif;
		
		g.next = nextgs;
		s.next = nextgs;
	endfunction

	task pre_test;
		d.reset;
	endtask

	task test;
		fork
			g.run;
			d.run;
			m.run;
			s.run;
		join_any
	endtask
	
	task post_test;
		wait(g.done.triggered);
		$finish();
	endtask

	task run;
		pre_test;
		test;
		post_test;
	endtask
endclass
