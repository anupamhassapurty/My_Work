class scoreboard;
	parameter DATA = 72; 
	parameter ADDR = 10;
	
	transaction t4;
	mailbox #(transaction) mbx;
	
	event next;
	
	//array to use as local memory
    bit [DATA-1:0] mem [(2**ADDR)-1:0];
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
	endfunction

  task write_check_a(input transaction t4);
    if(t4.a_wr) begin
      $display("*******************PORT A : WRITE CHECK **********************");
      mem[t4.a_addr] = t4.a_din;
      $display("%0t [SCB] : wr_enb = %0b,addr = %0h, wr_data = %0h, data_written = %0h",$time,t4.a_wr,t4.a_addr,t4.a_din,mem[t4.a_addr]);   
      $display("*****************************************************");
    end
  endtask
  
  task read_check_a(input transaction t4);
    if(!t4.a_wr) begin
       $display("********************PORT A : READ CHECK*********************");
      if(mem[t4.a_addr] != t4.a_dout)
        $error("%0t [SCB] : Read Data MisMatch ! wr_enb = %0b, addr = %0h, Expected = %0h, Actual = %0h",$time,t4.a_wr,t4.a_addr,mem[t4.a_addr],t4.a_dout);
      else if (mem[t4.a_addr] == t4.a_dout)
        $display("%0t [SCB] : Read Data Match ! wr_enb = %0b, addr = %0h, Expected = %0h, Actual = %0h",$time,t4.a_wr,t4.a_addr,mem[t4.a_addr],t4.a_dout);
      else 
        $display("No check");
      $display("*****************************************************");
    end
  endtask
  
   task write_check_b(input transaction t4);
    if(t4.b_wr) begin
      $display("********************PORT B : WRITE CHECK **********************");
      mem[t4.b_addr] = t4.b_din;
      $display("%0t [SCB] : wr_enb = %0b,addr = %0h, wr_data = %0h, data_written = %0h",$time,t4.b_wr,t4.b_addr,t4.b_din,mem[t4.b_addr]);   
      $display("*****************************************************");
    end
  endtask
  
  task read_check_b(input transaction t4);
    if(!t4.b_wr) begin
      $display("**********************PORT B : READ CHECK*********************");
      if(mem[t4.b_addr] != t4.b_dout)
        $error("%0t [SCB] : Read Data MisMatch ! wr_enb = %0b, addr = %0h, Expected = %0h, Actual = %0h",$time,t4.b_wr,t4.b_addr,mem[t4.b_addr],t4.b_dout);
      else if (mem[t4.b_addr] == t4.b_dout)
        $display("%0t [SCB] : Read Data Match ! wr_enb = %0b, addr = %0h, Expected = %0h, Actual = %0h",$time,t4.b_wr,t4.b_addr,mem[t4.b_addr],t4.b_dout);
      else 
        $display("No check");
      $display("*****************************************************");
    end
  endtask
  
  virtual task run;
		forever begin
			mbx.get(t4);
			
			t4.display_a("SCB","RCVD");
          	t4.display_b("SCB","RCVD");
			
          fork
            write_check_a(t4);
            read_check_a(t4);
          join
		
		  disable fork;

		  fork
            write_check_b(t4);
            read_check_b(t4);
          join
		
		  disable fork;
		
		->next;	
		end
	endtask
    
endclass
