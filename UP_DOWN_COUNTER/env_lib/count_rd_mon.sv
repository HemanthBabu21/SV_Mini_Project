class rd_mon; 
 
 virtual count_if.RD_MON_MP rdmon_if; 
 
 count_trans data2sb; 
 count_trans rd_data; 
// count_trans disp_rd; 
 
 mailbox#(count_trans) mon2sb; 
  
 function new(virtual count_if.RD_MON_MP rdmon_if, 
   mailbox#(count_trans) mon2sb); 
  this.rdmon_if=rdmon_if; 
  this.mon2sb=mon2sb; 
  this.rd_data=new; 
 endfunction 
 
 virtual task monitor(); 
 begin 
   @(rdmon_if.rd_mon_cb);   
  rd_data.count=rdmon_if.rd_mon_cb.count; 
 // rd_data.display("Datas from read monitor"); 
 end 
 endtask 
 
 virtual task start(); 
 fork 
  forever 
  begin 
   monitor(); 
   data2sb=new rd_data; 
   mon2sb.put(data2sb); 
   //disp_rd.display("READ Monitor"); 
  end 
 join_none 
 endtask 
 
endclass
