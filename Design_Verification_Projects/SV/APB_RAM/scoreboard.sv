class scoreboard;
  
	mailbox #(transaction) mbx;
	transaction tr;
	event nextsco;
  
	bit [31:0] pwdata[12] = '{default:0};
	bit [31:0] rdata;
	int index;
  
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;     
	endfunction;
  
	task run();
		forever begin
      
			mbx.get(tr);
			$display("[SCO] : DATA RCVD wdata:%0d rdata:%0d addr:%0d write:%0b", tr.pwdata, tr.prdata, tr.paddr, tr.pwrite);
      
			if( (tr.pwrite == 1'b1) && (tr.pslverr == 1'b0)) begin   ///write access
				pwdata[tr.paddr] = tr.pwdata;
				$display("[SCO] : DATA STORED DATA : %0d ADDR: %0d",tr.pwdata, tr.paddr);
			end
			else if((tr.pwrite == 1'b0) && (tr.pslverr == 1'b0)) begin ///read access
				rdata = pwdata[tr.paddr];    
				if( tr.prdata == rdata)
					$display("[SCO] : Read/ Write APB-RAM Data Matched"); 
				else
					$display("[SCO] : Error In APB-RAM Read / Write"); 
			end 
			else if(tr.pslverr == 1'b1)	begin
				$display("[SCO] : SLV ERROR DETECTED");
			end
			->nextsco;
		end
	endtask
endclass

/////////////////////////////////ENVIRONMENT//////////////////////////////////////////
