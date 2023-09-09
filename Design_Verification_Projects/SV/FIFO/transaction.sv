class transaction;
	parameter DEPTH = 16;
    parameter WIDTH = 8;  
	
	rand bit rst;
	rand bit write_enable;
    rand bit read_enable;
    rand bit [WIDTH-1:0] data_in;
    
	bit [WIDTH-1:0] data_out;
    bit full;
    bit empty;
    bit overflow;
    bit underflow;
    bit overrun;
    bit underrun;
  
  constraint data{   
    rst == 0;
    data_in>0;
    unique{data_in};
    write_enable != read_enable;
    
    write_enable dist {0:=50, 1:=50};
	read_enable  dist {0:=50, 1:=50};
  }
	function void display(input string tag,status);
	  $display("---------------------DATA %0s------------------------",status);
      $display("%0t [%0s]: rst :%0b, wr_en:%0b, rd_en :%0b, din :%0h, dout :%0h, full :%0b, empty :%0b, overflow :%0b, underflow :%0b, overrun :%0b, underrun :%0b,"
		,$time,tag,rst,write_enable,read_enable,data_in,data_out,full,empty,overflow,underflow,overrun,underrun);
	endfunction
	
	function transaction copy();
		copy = new;
		copy.rst        = this.rst;
		copy.write_enable = this.write_enable;
		copy.read_enable  = this.read_enable;
		copy.data_in      = this.data_in;
    
		copy.data_out  = this.data_out;
		copy.full      = this.full;
		copy.empty     = this.empty;
		copy.overflow  = this.overflow;
		copy.underflow = this.underflow;
		copy.overrun   = this.overrun;
		copy.underrun  = this.underrun;
	endfunction
endclass

