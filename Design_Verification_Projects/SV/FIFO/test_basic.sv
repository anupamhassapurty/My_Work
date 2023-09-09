class test;
  
	environment e;
  
	virtual fifo_if fif;
  
	function new(virtual fifo_if fif);
		this.fif = fif;
    	e = new(fif);
	endfunction
	
	task run;
      $display("\t*****************BASIC READ AND WRITE CHECK ******************");
		e.g.count = 10;
		e.run;
	endtask
endclass
