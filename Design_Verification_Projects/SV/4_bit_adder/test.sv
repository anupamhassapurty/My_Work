class test;
  
	environment e;
  
	virtual add_if aif;
  
	function new(virtual add_if aif);
		this.aif = aif;
    	e = new(aif);
	endfunction
	
	task run;
		e.g.count = 10;
		e.run;
	endtask
  
endclass
