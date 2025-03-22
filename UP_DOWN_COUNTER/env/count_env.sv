class count_env; 
 
 virtual count_if.DRV_MP dr_if; 
 virtual count_if.WR_MON_MP wrmon_if; 
 virtual count_if.RD_MON_MP rdmon_if; 
 
 mailbox #(count_trans)gen2dr= new(); 
 mailbox #(count_trans)mon2rm= new(); 
 mailbox #(count_trans)mon2sb= new(); 
 mailbox #(count_trans)rm2sb= new(); 
 
 count_gen gen_h; 
 write_drv wr_dr_h; 
 wr_mon  wr_mon_h; 
 rd_mon  rd_mon_h; 
 ref_model model_h; 
 count_sb sb_h; 
 
  
 
 function new( virtual count_if.DRV_MP dr_if, 
   virtual count_if.WR_MON_MP wrmon_if, 
   virtual count_if.RD_MON_MP rdmon_if); 
  this.dr_if=dr_if; 
  this.wrmon_if=wrmon_if; 
  this.rdmon_if=rdmon_if; 
 endfunction 
 
 
 task build(); 
  gen_h=new(gen2dr); 
  wr_dr_h=new(dr_if,gen2dr); 
  wr_mon_h=new(wrmon_if,mon2rm); 
  rd_mon_h=new(rdmon_if,mon2sb); 
  model_h=new(mon2rm,rm2sb); 
  sb_h=new(rm2sb,mon2sb); 
 endtask 
 
 task reset(); 
  begin 
                  dr_if.drv_cb.reset<=1'b0; 
     
  @(dr_if.drv_cb); 
   dr_if.drv_cb.reset<=1'b1; 
   dr_if.drv_cb.up_down<=1'b0; 
   dr_if.drv_cb.load<=1'b0; 
  @(dr_if.drv_cb); 
   dr_if.drv_cb.reset<=1'b0; 
  end 
 endtask 
  
 task start(); 
  gen_h.start(); 
  wr_dr_h.start(); 
  wr_mon_h.start(); 
  rd_mon_h.start(); 
  model_h.start(); 
  sb_h.start(); 
 endtask 
 
 task stop(); 
  wait(sb_h.DONE.triggered); 
 endtask 
 
 task run(); 
  reset(); 
  start(); 
  stop(); 
  sb_h.report(); 
 endtask 
endclass 
