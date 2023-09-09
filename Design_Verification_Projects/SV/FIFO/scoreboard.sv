class scoreboard;
	parameter DEPTH = 16;
    parameter WIDTH = 8;

	transaction t4;
	mailbox #(transaction) mbx;
	
	event next;
  
  	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
	endfunction
  
  	//local array to generate expected data
  	bit [WIDTH-1:0] memory [0:DEPTH-1];
	bit [4:0] write_pointer = 0;	
	bit [4:0] read_pointer = 0;
  
  	int no_transaction = 0;
    
    task status_check(input transaction t4);
      $display("*************************************");
      no_transaction++;
      if(t4.data_in) 	   $display("%0t [SCB] : DATA WRITTEN : %0h",$time,t4.data_in);
      if(t4.full == 1)     $display("%0t [SCB] : FIFO IS FULL !",$time);
      if(t4.empty == 1)    $display("%0t [SCB] : FIFO IS EMPTY !",$time);
      if(t4.overflow == 1) $display("%0t [SCB] : OVERFLOW -> FIFO IS FULL !",$time);
      if(t4.underflow == 1)$display("%0t [SCB] : UNDERFLOW -> FIFO IS EMPTY !",$time);
      if(t4.overrun == 1)  $display("%0t [SCB] : OVERRUN -> READ IS SLOW THAN WRITE !",$time);
      if(t4.underrun == 1) $display("%0t [SCB] : UNDERRUN -> WRITE IS SLOW THAN READ !",$time);
      else $display("%0t [SCB] : No Status",$time);
      $display("%0t [SCB] : Transaction no : %0d",$time,no_transaction);
      $display("*************************************");
    endtask
    
  task fifo_check(input transaction t4);  
    if (t4.write_enable && !t4.full) begin
		if (write_pointer == DEPTH) begin
			write_pointer = 0;
		end
		else begin
			memory[write_pointer] = t4.data_in;
			write_pointer++;
		end
    end
	if (t4.read_enable && !t4.empty) begin
		if (read_pointer == DEPTH) begin
			read_pointer = 0;
		end
		else begin
			if (t4.data_out != memory[read_pointer]) begin
                $error("%0t [SCB] : DATA MISMATCH ! Expected = %0d, Actual = %0d",$time,memory[read_pointer],t4.data_out);
			end else if (t4.data_out == memory[read_pointer]) begin
                $display("%0t [SCB] : DATA MATCH ! Expected = %0d, Actual = %0d",$time,memory[read_pointer],t4.data_out);
				read_pointer++;
			end else $display("%0t [SCB] :READ CHECK FAILED",$time);
            $display("***********************************************");
		end
	end
  endtask
    
   task run;
		forever begin
			
          mbx.get(t4);
			
			t4.display("SCB","RCVD");
			
          fork
            status_check(t4);
            fifo_check(t4);
          join_any
          
          disable fork;
		->next;	
		end
	endtask	
endclass

