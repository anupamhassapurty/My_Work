class test;
//4// Test case: Overrun
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
    write_enable == 0;
    read_enable == 1;
   	 
    data_in == 'h0;     
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
      
    repeat (17) begin  
      fork
      	e.g.t1 = tr1;
        $display("\t*****************FIFO : WRITE ******************");
      	e.g.count = 1;
      	e.test;
      join
  	
    	disable fork;
        end
        
      fork
      	e.g.t1 = tr2;
        $display("\t*****************FIFO : READ******************");
      	e.g.count = 2;
      	e.test;
      join
        
      disable fork;
    
      e.post_test;

    endtask
  
endclass

