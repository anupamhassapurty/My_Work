class transaction;
  rand bit [3:0]a,b; 
  bit [3:0]sum;
  bit carry;
	
	constraint data{
		a>0;
		b>0;
	}
	
	function void display(input string tag,status);
		$display("---------------------DATA %0s------------------------",status);
      $display("\t%0t [%0s] : a : %0d\t b:%0d\t sum : %0d\t ", $time,tag, a, b, {carry,sum});		
	endfunction
	
	function transaction copy();
		copy = new;
		copy.a = this.a;
		copy.b = this.b;
		copy.sum = this.sum;
      	copy.carry = this.carry;
	endfunction

endclass
