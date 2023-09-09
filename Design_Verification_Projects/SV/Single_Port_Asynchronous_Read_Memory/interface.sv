interface mem_if();
  logic clk; 
  logic [2:0]addr; 
  logic wr_enb;
  logic [3:0]wr_data; 
  logic [3:0]rd_data;
endinterface
