class transaction;
  
	typedef enum int {write = 0, read = 1, random = 2, error = 3} opr_mode;
  
	randc opr_mode opsel ;
  
	rand bit [31:0] paddr;
	rand bit [31:0] pwdata;
	rand bit psel;
	rand bit penable;
	rand bit pwrite;
  
	bit [31:0] prdata;
	bit pready;
	bit pslverr;
  
	constraint data {
		paddr > 10; paddr < 30;
		unique{pwdata};
	}
  
	function void display(input string tag);
		$display($time," [%0s] : OP:%0s  paddr:%0d  pwdata:%0d  psel:%0b  penable:%0b  pwrite:%0b  prdata:%0d  pready:%0b  pslverr:%0b",tag,opsel.name(),paddr,pwdata,psel, penable, pwrite, prdata, pready, pslverr, $time);
	endfunction
  
	function transaction copy();
		copy = new();
		copy.opsel    = this.opsel;
		copy.paddr   = this.paddr;
		copy.pwdata  = this.pwdata;
		copy.psel    = this.psel;
		copy.penable = this.penable;
		copy.pwrite  = this.pwrite;
		copy.prdata  = this.prdata;
		copy.pready  = this.pready;
		copy.pslverr = this.pslverr;
  endfunction
endclass : transaction

