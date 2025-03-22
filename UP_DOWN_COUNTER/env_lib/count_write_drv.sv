class write_drv; 
 
 virtual count_if.DRV_MP dr_if; 
  
 count_trans data2duv; 
  
 mailbox#(count_trans) gen2dr; 
 
 function new(virtual count_if.DRV_MP dr_if, 
   mailbox#(count_trans)gen2dr); 
  this.dr_if=dr_if; 
  this.gen2dr=gen2dr; 
 endfunction 
 
 virtual task drive(); 
 begin 
  @(dr_if.drv_cb); 
  dr_if.drv_cb.load<=data2duv.load; 
  dr_if.drv_cb.up_down<=data2duv.up_down; 
  dr_if.drv_cb.din<=data2duv.din; 
 end 
 endtask 
 
 virtual task start(); 
 fork 
  forever 
  begin 
   gen2dr.get(data2duv); 
   drive(); 
  end 
 join_none 
 endtask 
 
endclass
