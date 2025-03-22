class test; 
virtual count_if.DRV_MP dr_if; 
virtual count_if.WR_MON_MP wrmon_if; 
virtual count_if.RD_MON_MP rdmon_if; 
count_env env_h; 
function new(virtual count_if.DRV_MP dr_if, 
virtual count_if.WR_MON_MP wrmon_if, 
virtual count_if.RD_MON_MP rdmon_if); 
this.dr_if=dr_if; 
this.wrmon_if=wrmon_if; 
this.rdmon_if=rdmon_if; 
env_h=new(dr_if,wrmon_if,rdmon_if); 
endfunction 
task build_and_run(); 
begin 
no_of_transcations=20; 
env_h.build(); 
env_h.run(); 
//#1000; 
$finish; 
end 
endtask 
endclass
