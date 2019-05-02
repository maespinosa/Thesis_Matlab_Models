function [q] = div_by_mult(Num, Den)

q = 100000.0;
Den_new = Den; 
Num_new = Num; 
count = 0; 

while(Den_new ~= 1)
    while(Den_new > 1)
        Den_new = Den_new/2; 
        Num_new = Num_new/2;
    end 
    
    x = 2-Den_new; 

    Den_new = Den_new*x; 
    Num_new = Num_new*x; 
    
    count = count + 1 

    
end

q = Num_new;



