interface count_if(input bit clock); 
logic [3:0] din; 
logic [3:0] count; 
logic reset; 
logic up_down; 
logic load; 
clocking drv_cb@(posedge clock); 
default input #1 output #1; 
output din; 
output reset; 
output up_down; 
output load; 
endclocking 
clocking wr_mon_cb@(posedge clock); 
default input #1 output #1; 
input din; 
input reset; 
input up_down; 
input load; 
endclocking 
clocking rd_mon_cb@(posedge clock); 
default input #1 output #1; 
input count; 
endclocking 
modport DRV_MP(clocking drv_cb); 
modport WR_MON_MP(clocking wr_mon_cb); 
modport RD_MON_MP(clocking rd_mon_cb); 
endinterface
