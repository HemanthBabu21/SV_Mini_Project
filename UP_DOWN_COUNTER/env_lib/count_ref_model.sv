class ref_model; 
 
 count_trans w_data; 
  
 static logic [3:0]ref_count=0; 
 
 mailbox#(count_trans) wrmon2rm; 
 mailbox#(count_trans) rm2sb; 
 
 function new(mailbox#(count_trans) wrmon2rm, 
   mailbox#(count_trans) rm2sb); 
  this.wrmon2rm=wrmon2rm; 
  this.rm2sb=rm2sb; 
  this.w_data=new; 
 endfunction 
 
 virtual task count_mod(count_trans model_counter); 
 begin 
  if(model_counter.load) 
   ref_count<=model_counter.din; 
 // else if(model_counter.load==0) 
  else if(model_counter.up_down==0) 
   begin 
    if(ref_count>=4'd11) 
     ref_count<=4'b0; 
    else 
     ref_count<=ref_count+1'b1; 
   end 
   
  else 
                        begin   
   if(model_counter.up_down==1) 
    begin 
    if((ref_count>=4'd11)) 
     ref_count<=4'd10; 
    else if((ref_count<1)) 
     ref_count<=4'd11; 
    else 
     ref_count<=ref_count-1'b1; 
    end 
   end 
    
        end 
 endtask 
 
 virtual task start(); 
  fork 
  begin 
   forever 
    begin 
     wrmon2rm.get(w_data); 
     count_mod(w_data); 
w_data.count=ref_count; 
rm2sb.put(w_data); 
end 
end 
join_none 
endtask 
endclass
