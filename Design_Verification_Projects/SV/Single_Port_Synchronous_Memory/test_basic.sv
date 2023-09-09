class test;
  
	environment e;
  
	virtual mem_if mif;
  
	function new(virtual mem_if mif);
		this.mif = mif;
    	e = new(mif);
	endfunction
	
	task run;
		e.g.count = 10;
		e.run;
	endtask
  
endclass
