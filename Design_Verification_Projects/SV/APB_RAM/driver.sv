class driver;
  
	virtual abp_if vif;
  
	mailbox #(transaction) mbx;
  
	transaction tdc;
  
	event nextdrv;
 
    function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
	endfunction; 

	task reset();
		vif.presetn <= 1'b0;
		vif.psel    <= 1'b0;
		vif.penable <= 1'b0;
		vif.pwdata  <= 0;
		vif.paddr   <= 0;
		vif.pwrite  <= 1'b0;
    
		repeat(5) @(posedge vif.pclk);
			vif.presetn <= 1'b1;
		repeat(5) @(posedge vif.pclk);
		
		$display("[DRV] : RESET COMPLETE");
	endtask

	task run();
		forever begin
			mbx.get(tdc);
      
			if(tdc.opsel == 0) begin ///write
				@(posedge vif.pclk);
				vif.psel <= 1'b1;
				vif.penable <= 1'b0;
				vif.pwdata <= tdc.pwdata;
				vif.paddr <= tdc.paddr;
				vif.pwrite <= 1'b1;
          
				@(posedge vif.pclk);
				vif.penable <= 1'b1; 
          
				repeat(2) @(posedge vif.pclk); 
				vif.psel <= 1'b0;
				vif.penable <= 1'b0;
				vif.pwrite <= 1'b0;
          
              $display("[DRV] : DATA WRITE OP addr : %0d, data : %0d", tdc.paddr,tdc.pwdata);          
			end 
			else if (tdc.opsel == 1) begin //read
				@(posedge vif.pclk);
				vif.psel <= 1'b1;
				vif.penable <= 1'b0;
				vif.pwdata <= tdc.pwdata;
				vif.paddr <= tdc.paddr;
				vif.pwrite <= 1'b0;
          
				@(posedge vif.pclk);
				vif.penable <= 1'b1; 
          
				repeat(2) @(posedge vif.pclk); 
				vif.psel <= 1'b0;
				vif.penable <= 1'b0;
				vif.pwrite <= 1'b0;
          
              $display("[DRV] : DATA READ OP addr : %0d, data : %0d", tdc.paddr,tdc.pwdata); 
			end
			else if (tdc.opsel == 2) begin ///random
				@(posedge vif.pclk);
				vif.psel 	<= 1;
				vif.penable <= 0;
				vif.pwdata 	<= tdc.pwdata;
				vif.paddr 	<= tdc.paddr;
				vif.pwrite 	<= tdc.pwrite;
          
				@(posedge vif.pclk);
				vif.penable <= 1; 
				
				repeat(2) @(posedge vif.pclk); 
				vif.psel 	<= 1'b0;
				vif.penable <= 1'b0;
				vif.pwrite 	<= 1'b0;
          
				$display("[DRV] : RANDOM OPERATION");          
			end 
			else if (tdc.opsel == 3) begin///slv error
				@(posedge vif.pclk);
				vif.psel 	<= 1;
				vif.penable <= 0;
				vif.pwdata 	<= tdc.pwdata;
				vif.paddr 	<= $urandom_range(32,100);
				vif.pwrite 	<= tdc.pwrite;
          
				@(posedge vif.pclk);
				vif.penable <= 1; 
				
				repeat(2) @(posedge vif.pclk); 
				vif.psel 	<= 1'b0;
				vif.penable <= 1'b0;
				vif.pwrite 	<= 1'b0;
          
				$display("[DRV] : SLV ERROR");       
			end
			->nextdrv;
		end
	endtask
endclass : driver 
