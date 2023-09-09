class transaction;
  parameter M=3, N=4;
  
	rand bit [M-1: 0] addr; 
	rand bit wr_enb; 
	rand bit [N-1: 0] wr_data; 
	bit [N-1:0] rd_data;
  
  constraint data{
   
    wr_data>0;
    
    wr_enb dist {0:=50, 1:=50};
  }
	function void display(input string tag,status);
	  $display("---------------------DATA %0s------------------------",status);
      $display("%0t [%0s]: addr : %0d\t wr_enb :%0d\t wr_data : %0d\t rd_data : %0d", $time,tag,addr, wr_enb, wr_data, rd_data);		
	endfunction
	
	function transaction copy();
		copy = new;
		copy.addr = this.addr;
		copy.wr_enb = this.wr_enb;
		copy.wr_data = this.wr_data;
      	copy.rd_data = this.rd_data;
	endfunction

endclass
