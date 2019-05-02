function dec_value = hex_to_dec_single(x)
x;
size(x);
if(x == '00000000')
    bin_value = zeros(1,32);
else 
    %bin_value = hexToBinaryVector(x);
	bin_value = []; 
	j = 1; 
	for i = 1:1:length(x)
		if(x(i) == '0')
			bin_value = [bin_value,0,0,0,0]; 
		elseif(x(i) == '1')
			bin_value = [bin_value,0,0,0,1]; 
		elseif(x(i) == '2')
			bin_value = [bin_value,0,0,1,0]; 
		elseif(x(i) == '3')
			bin_value = [bin_value,0,0,1,1]; 
		elseif(x(i) == '4')
			bin_value = [bin_value,0,1,0,0]; 
		elseif(x(i) == '5')
			bin_value = [bin_value,0,1,0,1]; 
		elseif(x(i) == '6')
			bin_value = [bin_value,0,1,1,0]; 
		elseif(x(i) == '7')
			bin_value = [bin_value,0,1,1,1]; 
		elseif(x(i) == '8')
			bin_value = [bin_value,1,0,0,0]; 
		elseif(x(i) == '9')
			bin_value = [bin_value,1,0,0,1]; 
		elseif(x(i) == 'a' | x(i)=='A')
			bin_value = [bin_value,1,0,1,0]; 
		elseif(x(i) == 'b' | x(i)=='B')
			bin_value = [bin_value,1,0,1,1]; 
		elseif(x(i) == 'c' | x(i)=='C')
			bin_value = [bin_value,1,1,0,0]; 
		elseif(x(i) == 'd'| x(i)=='D')
			bin_value = [bin_value,1,1,0,1]; 
		elseif(x(i) == 'e' | x(i)=='E')
			bin_value = [bin_value,1,1,1,0]; 
		elseif(x(i) == 'f' | x(i)=='F')
			bin_value = [bin_value,1,1,1,1]; 
		end 
    end 
    bin_value;
    size(bin_value);
	j = j + 4; 	
end 
bit_counter = 0; 

if(length(bin_value) < 32)
    while (bit_counter <= 32-length(bin_value)) 
        bin_value = [0, bin_value];
        bit_counter = bit_counter + 1 ;
    end 
end 

size(bin_value);

if(bin_value(1) == 0) 
    sign = 1; 
else 
    sign = -1; 
end 

calc_value = []; 

for i = 2:1:9
    calc_value = [calc_value,bin_value(i)*(2^(8-(i-1)))]; 
end 

sum_exponent = sum(calc_value); 
dec_part_a = 2^(sum_exponent-127); 

calc_value_2 = []; 

for i = 10:1:32
    i;
    calc_value_2 = [calc_value_2,bin_value(i)*(2^(-1*(i-9)))]; 
end 

sum_mantissa = sum(calc_value_2); 
dec_part_b = sum_mantissa + 1; 

if(x == '00000000')
    dec_value = 0; 
else 
    dec_value = sign*dec_part_a*dec_part_b;
end

