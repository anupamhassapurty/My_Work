class test;

	environment e;

	virtual mul_if mif;

	function new(virtual mul_if mif);
		this.mif = mif;

		e = new(mif);

	endfunction

	task run;
		e.g.count = 10;
		e.run;
	endtask

endclass
