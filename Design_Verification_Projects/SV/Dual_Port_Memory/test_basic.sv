class test;
  
	environment e;
  
	virtual ram_if rif;
  
	function new(virtual ram_if rif);
		this.rif = rif;
      e = new(rif);
	endfunction
	
	task run;
		e.g.count = 10;
		e.run;
	endtask
  
endclass
