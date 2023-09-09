class test;
//1// Test case: Full
	environment e;
  
	virtual fifo_if fif;
  
   class trans1 extends transaction;
    
    constraint data {
    
    rst == 0;
    write_enable == 1;
    read_enable == 0;
   	 
      unique{data_in};
  }  
  endclass
  
  class trans2 extends transaction;
    
   constraint data {
   	rst == 0;
    write_enable == 1;
    read_enable == 0;
   	 
    data_in == 'hff;     
  }
  endclass
  
  trans1 tr1;
  trans2 tr2;
  
      function new(virtual fifo_if fif);
		this.fif = fif;
        e = new(fif);
    	tr1 = new;
    	tr2 = new;
	endfunction
  
  task run;
      
      e.pre_test;
      
      fork
      	e.g.t1 = tr1;
        $display("\t*****************FILL FIFO TO MAXIMUM ******************");
      	e.g.count = 16;
      	e.test;
      join
  	
    disable fork;
    
      fork
      	e.g.t1 = tr2;
        $display("\t*****************WRITING IN FULL FIFO******************");
      	e.g.count = 3;
      	e.test;
      join
        
      disable fork;
    
      e.post_test;

    endtask
  
endclass
