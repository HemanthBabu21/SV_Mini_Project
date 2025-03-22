module updown( input clock,reset,load, 
 input [3:0] din, 
 input up_down, 
     output reg [3:0] count 
 ); 
 always@(posedge clock) 
 begin 
 if(reset) 
  count<=0; 
 else if(load) 
  count<=din; 
 else if(up_down==0) 
 begin 
  if(count>=4'd11) 
   count<=0; 
  else 
   count<=count+1'b1; 
 end 
 else 
 begin 
  if((count>=4'd11)) 
   count<=4'd10; 
  else if(count<4'd1) 
   count<=4'd11; 
  else 
   count<=count-1'b1; 
 end 
 end 
endmodule
