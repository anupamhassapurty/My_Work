class test;
 // Test case 2: Write and Read from Different Addresses
	environment e;
  
	virtual mem_if mif;
  
   class trans1 extends transaction;
    
    constraint data {
    wr_enb ==1;
    addr == 2;
    wr_data == 10;  
  }
  endclass
  
  class trans2 extends transaction;
    
   constraint data {
    
    wr_enb ==1;
    addr == 6;
    wr_data == 13;  
  }
  endclass
  
  class trans3 extends transaction;
    
   constraint data {
    
    wr_enb == 0;
    addr == 2;
    wr_data == 0;  
  }
  endclass
  
  trans1 tr1;
  trans2 tr2;
  trans3 tr3;
  
  
  function new(virtual mem_if mif);
		this.mif = mif;
    	e = new(mif);
    	tr1 = new;
    	tr2 = new;
    	tr3 = new;
	endfunction
	
	task run;
      
      e.pre_test;
  
      fork 	
      	e.g.t1 = tr1;
      	$display("\t*****************WRITE OPERATION******************");
      	e.g.count = 1;
      	e.test_write;
      join
      
      disable fork;
 
      fork  
      	e.g.t1 = tr2;
      	$display("\t*****************WRITE OPERATION******************");
      	e.g.count = 1;
      	e.test_write;
      join
      
      disable fork;
        
      fork
      	e.g.t1 = tr3;
      	$display("\t*****************READ OPERATION******************");
      	e.g.count = 1;
      	e.test_read;
      join
      
      disable fork;
      
      e.post_test;
          
    endtask
  
endclass
