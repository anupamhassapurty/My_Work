class environment;

	generator g;
	driver d;
	monitor m;
	scoreboard s;
	
	mailbox #(transaction) gen2drv;
	mailbox #(transaction) mon2scb;
	
	event nextgs;
	
	virtual mem_if mif;
	
  function new(virtual mem_if mif);
		gen2drv = new;
		g = new(gen2drv);
		d = new(gen2drv);
		
		mon2scb = new;
		m  = new(mon2scb);
		s  = new(mon2scb);
		
		this.mif = mif;
		
		d.mif = this.mif;
		m.mif = this.mif;
		
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
  
  //For Testcases
  
   task test_write;
		fork
			g.run;
			d.run;
			m.run;
			s.run_write_check;
		join_any
	endtask
	
  task test_read;
		fork
			g.run;
			d.run;
			m.run;
			s.run_read_check;
		join_any
	endtask
  
endclass
