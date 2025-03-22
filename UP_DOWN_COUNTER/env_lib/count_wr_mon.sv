class wr_mon; 
  
 virtual count_if.WR_MON_MP wrmon_if; 
  
 count_trans data2rm; 
 count_trans wr_data; 
 //count_trans disp_wr; 
 
 mailbox#(count_trans) mon2rm; 
  
 function new(virtual count_if.WR_MON_MP wrmon_if, 
   mailbox#(count_trans) mon2rm); 
  this.wrmon_if=wrmon_if; 
  this.mon2rm=mon2rm; 
  this.wr_data=new; 
 endfunction 
 
 virtual task monitor(); 
  begin 
   @(wrmon_if.wr_mon_cb); 
   wr_data.up_down=wrmon_if.wr_mon_cb.up_down; 
   wr_data.load=wrmon_if.wr_mon_cb.load;  
   wr_data.din=wrmon_if.wr_mon_cb.din; 
  // wr_data.display("Datas from write monitor"); 
  end 
 endtask 
 
 virtual task start(); 
  fork 
  forever 
   begin 
    monitor(); 
    data2rm=new wr_data; 
    mon2rm.put(data2rm); 
   // disp_wr.display("Write Monitor"); 
   end 
  join_none 
 endtask 
endclass
