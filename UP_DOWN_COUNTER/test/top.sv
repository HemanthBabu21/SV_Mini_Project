module top(); 
 
import count_pkg::*; 
 
parameter cycle=10; 
reg clock; 
 
 count_if DUV_IF(clock); 
 test test_h; 
 updown UD(.clock(clock), 
   .din(DUV_IF.din), 
   .load(DUV_IF.load), 
   .up_down(DUV_IF.up_down), 
   .count(DUV_IF.count), 
   .reset(DUV_IF.reset)); 
 
 initial 
  begin 
  // test test_h; 
   test_h=new(DUV_IF,DUV_IF,DUV_IF);  
   test_h.build_and_run(); 
  end 
 
 initial 
  begin 
   clock=1'b0; 
   forever #(cycle/2) clock=~clock; 
  end 
endmodule
