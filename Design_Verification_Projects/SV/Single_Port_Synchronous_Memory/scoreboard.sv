class scoreboard;

	transaction t4;
	mailbox #(transaction) mbx;
	
	event next;
	
	//array to use as local memory
    bit [3:0] mem[8];
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
	endfunction

  task write_check(input transaction t4);
    if(t4.wr_enb) begin
      $display("******************** WRITE CHECK **********************");
      mem[t4.addr] = t4.wr_data;
      $display("%0t [SCB] : wr_enb = %0b,addr = %0d, wr_data = %0d, data_written = %0d",$time,t4.wr_enb,t4.addr,t4.wr_data,mem[t4.addr]);   
      $display("*****************************************************");
    end
  endtask
  
  task read_check(input transaction t4);
    if(!t4.wr_enb) begin
       $display("**********************READ CHECK*********************");
      if(mem[t4.addr] != t4.rd_data)
        $error("[SCB] : Read Data MisMatch ! addr = %0d, Expected = %0d, Actual =%0d",t4.addr,mem[t4.addr],t4.rd_data);
      else if (mem[t4.addr] == t4.rd_data)
        $display("[SCB] : Read Data Match ! addr = %0d, Expected = %0d, Actual =%0d",t4.addr,mem[t4.addr],t4.rd_data);
      else 
        $display("No check");
      $display("*****************************************************");
    end
  endtask
  
  virtual task run;
		forever begin
			mbx.get(t4);
			
			t4.display("SCB","RCVD");
			
          fork
            write_check(t4);
            read_check(t4);
          join
        
		->next;	
		end
		
	endtask	
  //For Testcases
  virtual task run_write_check;
		forever begin
			mbx.get(t4);
			
			t4.display("SCB","RCVD");
			
            write_check(t4);
         
		->next;	
		end
		
	endtask	
  
  virtual task run_read_check;
		forever begin
			mbx.get(t4);
			
			t4.display("SCB","RCVD");
			
            read_check(t4);
        
		->next;	
		end
		
	endtask	
  
endclass
