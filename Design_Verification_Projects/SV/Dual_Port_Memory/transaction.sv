class transaction;
	parameter DATA = 72; 
	parameter ADDR = 10;
  
// Port A 
	rand bit a_wr;
	rand bit [ADDR-1:0] a_addr; 
	rand bit [DATA-1:0] a_din;
		 bit [DATA-1:0] a_dout; 
 
// Port B 
	rand bit b_wr;
	rand bit [ADDR-1:0] b_addr; 
	rand bit [DATA-1:0] b_din; 
		 bit [DATA-1:0] b_dout; 
  
	constraint data{ 
		a_din>0;
		b_din>0;
	
      a_wr dist {0:=30, 1:=70};
      b_wr dist {0:=30, 1:=70};
	}
	
	function void display_a(input string tag,status);
      $display("-----------------PORT A : DATA %0s------------------------",status);
      $display("%0t [%0s]: wr_enb :%0b\t addr :%0h\t wr_data :%0h\t rd_data :%0h", $time,tag,a_wr,a_addr,a_din,a_dout);		
	endfunction
	
	function void display_b(input string tag,status);
      $display("-----------------PORT B : DATA %0s------------------------",status);
      $display("%0t [%0s]: wr_enb :%0b\t addr :%0h\t wr_data :%0h\t rd_data :%0h", $time,tag,b_wr,b_addr,b_din,b_dout);		
	endfunction
	
	function transaction copy();
		copy = new;
		// Port A 
		copy.a_wr   = this.a_wr;
		copy.a_addr = this.a_addr; 
		copy.a_din  = this.a_din;
		copy.a_dout = this.a_dout; 
		// Port B 
		copy.b_wr   = this.b_wr;
		copy.b_addr = this.b_addr; 
		copy.b_din  = this.b_din; 
		copy.b_dout = this.b_dout; 
	endfunction
endclass
