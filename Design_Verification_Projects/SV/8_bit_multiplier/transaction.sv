class transaction;
	rand bit [7:0]m,n;
	bit [15:0]mul;

	constraint data{
		m>0;
		n>0;
	}

	function void display(input string tag,status);
		$display("---------------------DATA %0s------------------------",status);
		$display("\t%0t [%0s] : m : %0d\t n:%0d\t mul : %0d\t ", $time,tag, m, n, mul);
	endfunction

	function transaction copy();
		copy = new;
		copy.m = this.m;
		copy.n = this.n;
		copy.mul = this.mul;
	endfunction

endclass
