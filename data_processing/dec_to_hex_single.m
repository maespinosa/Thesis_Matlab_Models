function hex_value = dec_to_hex_single(x)

[M,N] = size(x);

if(x ==0 ) 
    is_zero = 1; 
else 
    is_zero = 0; 
end 

integer = abs(x) - mod(abs(x),1); 
mantissa =  mod(abs(x),1) ; 
denominator = 2; 
bin_array = zeros(1,64); %[]; 
mantissa_bin_array = zeros(1,64); 
exp_bin_array = zeros(1,8); %[];
bit_field = []; 

%Calculate the Sign bit

if(x >= 0) 
    sign_bit = 0;
else 
    sign_bit = 1 ;
end 

%Calculate Binary of integer if greater than 0
bin_index = 1; 
if(integer ~=0)
    while(integer ~= 1)
        bin_value = mod(integer,2);
        bin_array(1,bin_index) = bin_value; 
        if(bin_value == 0) 
            numerator = integer/denominator; 
            integer = numerator; 
        else 
            numerator = (integer-bin_value)/2; 
            integer = numerator;
        end
        bin_index = bin_index + 1; 
    end 

    bin_array(bin_index) = 1;
    bin_array = fliplr(bin_array); 
else 
    bin_array = zeros(1,64); %[0, bin_array]; 
end 

%Calculate Fractional bits if greater than zero
bit_counter = 64;
mantissa_index = 1; 

if(mantissa > 0) 
    while(bit_counter ~= 0) 
        mantissa = mantissa*2; 
        if(mantissa >=1) 
            bit_value = 1;
            mantissa = mantissa - 1; 
        else 
            bit_value = 0; 
        end 
        %mantissa_bin_array = [mantissa_bin_array, bit_value];
        mantissa_bin_array(1,mantissa_index) = bit_value; 
        mantissa_index = mantissa_index + 1; 
        bit_counter = bit_counter - 1;
    end 
else 
    mantissa_bin_array = zeros(1,64);
end 

% Find the exponent from the integer bit array
bit_counter = 1; %length(bin_array); 
exp_found = 0; 
exponent = 0; 

while(exp_found == 0 && bit_counter ~= length(bin_array) && is_zero == 0)%0) 
    if(bin_array(bit_counter) == 1) 
        exponent = length(bin_array)-bit_counter; 
        exp_found = 1; 
    else 
        bit_counter = bit_counter + 1; 
        exp_found = 0; 
    end 
end

% Find the exponent from the mantissa bit array
if(exponent == 0 && bin_array(end) == 0 && exp_found == 0 && is_zero ==0)
    bit_counter = 1; 
    while(exp_found == 0 && bit_counter ~= length(mantissa_bin_array))
        if(mantissa_bin_array(bit_counter) == 1) 
            exponent = -1*bit_counter; 
            exp_found = 1; 
        else 
            bit_counter = bit_counter + 1; 
            exp_found = 0; 
        end 
    end
end 

% Calculate the Floating Point Exponent Field value 
exponent_value = 127+exponent;
exp_index = 1; 
while(exponent_value ~= 1 && is_zero ==0)
    exp_bin_value = mod(exponent_value,2);
    %exp_bin_array = [exp_bin_array, exp_bin_value]; 
    exp_bin_array(1,exp_index) = exp_bin_value; 
    if(exp_bin_value == 0) 
        numerator = exponent_value/denominator; 
        exponent_value = numerator; 
    else 
        numerator = (exponent_value-exp_bin_value)/2; 
        exponent_value = numerator;
    end
    exp_index = exp_index + 1; 
end 

%exp_bin_array = [exp_bin_array, 1];
exp_bin_array(1,exp_index) = 1; 

exp_bin_array = fliplr(exp_bin_array); 

% pad_length = (8-length(exp_bin_array))-1; 
% 
% for i=0:1:pad_length 
%     exp_bin_array = [0,exp_bin_array]; 
% end 


bit_field = [bin_array, mantissa_bin_array]; 

% 
bit_counter = 1; 
exp_found = 0; 
mantissa_bits = zeros(1,23); %[]; 
mantissa_done = 0; 

while(mantissa_done == 0 && bit_counter <= length(bit_field)) 
    if(bit_field(bit_counter) == 1) 
      
       mantissa_done = 1;  
       mantissa_bits = bit_field(bit_counter+1:end); 
        
    else 
        bit_counter = bit_counter + 1; 
        mantissa_done = 0; 
    end 
end
mantissa_bits; 
exp_sign_length = length(exp_bin_array) + 1; 

%final_bin_value = []; 
final_bin_value = zeros(1,32);
if(is_zero == 1) 
    final_bin_value = zeros(1,32); 
else
    %final_bin_value = [sign_bit,exp_bin_array,mantissa_bits(1:32-exp_sign_length)];
    final_bin_value = [sign_bit,exp_bin_array,mantissa_bits];
end 
hex_value = char(1,8); 
final_counter = 1; 
for i = 1:4:32
    i;
    if(final_bin_value(i:i+3) == [0,0,0,0])
        hex_value(final_counter) = '0'; 
    elseif(final_bin_value(i:i+3) == [0,0,0,1])
        hex_value(final_counter) = '1';     
    elseif(final_bin_value(i:i+3) == [0,0,1,0])
        hex_value(final_counter) = '2';       
     elseif(final_bin_value(i:i+3) == [0,0,1,1])
        hex_value(final_counter) = '3';     
    elseif(final_bin_value(i:i+3) == [0,1,0,0])
        hex_value(final_counter) = '4';  
    elseif(final_bin_value(i:i+3) == [0,1,0,1])
        hex_value(final_counter) = '5';     
    elseif(final_bin_value(i:i+3) == [0,1,1,0])
        hex_value(final_counter) = '6';       
     elseif(final_bin_value(i:i+3) == [0,1,1,1])
        hex_value(final_counter) = '7';     
    elseif(final_bin_value(i:i+3) == [1,0,0,0])
        hex_value(final_counter) = '8'; 
    elseif(final_bin_value(i:i+3) == [1,0,0,1])
        hex_value(final_counter) = '9';     
    elseif(final_bin_value(i:i+3) == [1,0,1,0])
        hex_value(final_counter) = 'a';       
     elseif(final_bin_value(i:i+3) == [1,0,1,1])
        hex_value(final_counter) = 'b';     
    elseif(final_bin_value(i:i+3) == [1,1,0,0])
        hex_value(final_counter) = 'c';  
    elseif(final_bin_value(i:i+3) == [1,1,0,1])
        hex_value(final_counter) = 'd';     
    elseif(final_bin_value(i:i+3) == [1,1,1,0])
        hex_value(final_counter) = 'e';       
    elseif(final_bin_value(i:i+3) == [1,1,1,1])
        hex_value(final_counter) = 'f';   
    end 
    
    final_counter = final_counter + 1 ;
end 

hex_value = transpose(hex_value); 
        
        
        
        
        
        
        
        
%hex_value = binaryVectorToHex(sym(final_bin_value)); 

    
    
        
        