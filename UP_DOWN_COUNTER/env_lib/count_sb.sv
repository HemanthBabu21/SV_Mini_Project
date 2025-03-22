class count_sb; 
   
 event DONE;  
 count_trans rm_data; 
 count_trans sb_data; 
 
 static int ref_data,rdata,data_verified; 
 
 mailbox#(count_trans) ref2sb; 
 mailbox#(count_trans) rdm2sb; 
  
 function new(mailbox#(count_trans) ref2sb, 
   mailbox#(count_trans) rdm2sb); 
  this.ref2sb=ref2sb; 
  this.rdm2sb=rdm2sb; 
 endfunction 
 
        virtual task start(); 
  fork 
   while(1) 
   begin 
    ref2sb.get(rm_data); 
    ref_data++; 
    rdm2sb.get(sb_data); 
    rdata++; 
    check(sb_data); 
   end 
  join_none 
 endtask 
 
 virtual task check(count_trans rd_data); 
  begin 
  if(rm_data.count!=rd_data.count) 
   begin  
   $display("count not Matches"); 
   //rm_data.display("SB:received data"); 
  // rd_data.display("SB: data sent to dut"); 
                         $display("rm out:%0d",rm_data.count); 
                         $display("rd out:%0d",rd_data.count); 
                      //   $finish; 
   end 
  else 
   begin 
   $display("count matches"); 
  // rm_data.display("SB:received data"); 
  // rd_data.display("SB: data sent to dut"); 
                         $display("rm out:%0d",rm_data.count); 
                         $display("rd out:%0d",rd_data.count); 
 
   end 
 
  end 
data_verified++; 
if(data_verified>=no_of_transcations) 
begin ->DONE; 
end 
endtask 
virtual function void report(); 
$display("=========================scoreboard report=================================="); 
$display("Data Generated from reference =%0d",ref_data); 
$display("Data Generated from read_monitor=%0d",rdata); 
$display("Data Verified=%0d",data_verified); 
$display("============================================================================"); 
endfunction 
endclass
