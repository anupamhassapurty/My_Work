class test;
 //Test case 1: Write and Read Data 
	environment e;
  
	virtual ram_if rif;
  
   class trans1 extends transaction;
    
    constraint data {
    a_wr ==1;
    a_addr == 92;
    a_din == 2841;  
      
    b_wr ==1;
    b_addr == 186;
    b_din == 8947;
  }
  endclass
  
  class trans2 extends transaction;
    
   constraint data {    
  	a_wr ==0;
    a_addr == 92;
    a_din == 0;
      
    b_wr ==0;
    b_addr == 186;
    b_din == 0;
  }
  endclass
  
  trans1 tr1;
  trans2 tr2;
  
  function new(virtual ram_if rif);
		this.rif = rif;
    	e = new(rif);
    	tr1 = new;
    	tr2 = new;
	endfunction
	
	task run;
      
      e.pre_test;
      
      fork
      	e.g.t1 = tr1;
        $display("\t***************** WRITE OPERATION******************");
      	e.g.count = 1;
      	e.test;
      join
      
      disable fork;
      
      fork
      	e.g.t1 = tr2;
      	$display("\t*****************READ OPERATION******************");
      	e.g.count = 1;
        e.test;
      join
        
      disable fork;

      e.post_test;

    endtask
  
endclass

