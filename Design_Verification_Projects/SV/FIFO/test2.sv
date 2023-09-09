class test;
//2// Test case: Empty
	environment e;
  
	virtual fifo_if fif;
  
   class trans1 extends transaction;
    
    constraint data {
    
    rst == 0;
    write_enable == 0;
    read_enable == 0;
   	 
    data_in == 'h0;   
  }  
  endclass
  
  trans1 tr1;
  
      function new(virtual fifo_if fif);
		this.fif = fif;
        e = new(fif);
    	tr1 = new;
	endfunction
  
  task run;
      
      e.pre_test;
      
      fork
      	e.g.t1 = tr1;
        $display("\t*****************EMPTY FIFO CHECK ******************");
      	e.g.count = 1;
      	e.test;
      join
  
      disable fork;
    
      e.post_test;

    endtask
  
endclass
