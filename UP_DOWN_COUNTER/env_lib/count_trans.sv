class count_trans; 
 
 rand bit [3:0]din; 
 rand bit up_down; 
 rand bit load; 
 bit reset; 
 bit [3:0]count; 
 
 constraint c1{ din inside{[0:11]};} 
 constraint c2{up_down dist{1:=50,0:=50};} 
 constraint c3{load dist{1:=5,0:=95};} 
 
 function void display(input string s); 
  begin 
 
 $display("++++++++++++++++++++++++++%s+++++++++++++++++++++++++++",s); 
  $display("UP_DOWN=%0d",up_down); 
  $display("LOAD=%0d",load); 
  $display("DATA_IN=%0d",din); 
  $display("COUNT=%0d",count); 
  $display("reset=%0d",reset); 
 
 $display("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
 ; 
         end 
 endfunction 
   
endclass
