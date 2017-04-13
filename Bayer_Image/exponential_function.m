function [z,err] = exponential_function(x0, precision)

%Solve for y = exp(x0)
% (i)   x_i+1 = xi - ln(bi)
% (ii)  y_i+1 = yi*bi

% bi's are selected in such a way that the elements of the sequence
% x0,x1,...,xm approach 0 where m = # of iterations needed to ensure
% convergence to zero (xm = 0). 
%
% m is a linear function of the number of bits (n)

% bi's given the form 
%   bi = (1 + si*2^(-i))       where     si is element of set {-1,0,1}

% Therefore, 
%   (i)  x_i+1 = xi - ln(1 + si*2^(-i)), 
%   (ii) y_i+1 = yi*(1+si*2^(-i))

% One-sided selection rule si is element of set {0,1}

% In step (i+1) we form the difference 
%   D = xi - ln(1`+ 2^(-i))
%        si =   { 1  if  D >= 0 
%               { 0  if  D < 0

%     x_i+1 =   { D  if  D >= 0
%               { xi if  D < 0

%     y_i+1 =   { yi*(1+2^(-i)) if D >= 0
%               { yi            if D < 0


%x0 = 1.25
truncated_x0(x0 > 0) = floor(x0); 

integer_part = 0;
integer_part(truncated_x0 >= 1) = 2^truncated_x0

mantissa = x0 - truncated_x0

y0 = 1;
y0(truncated_x0 >= 1) = truncated_x0;


truth = exp(x0)

x = zeros(1,precision+2);
x(1,1) = mantissa;
y = zeros(1,precision+2);
y(1,1) = y0;

i = 0:1:precision;
a = 1 + 2.^(-1.*i);
b = log(a);
b(6:end) = 2.^(-1.*i(6:end));

s = zeros(1,precision+1);
D = zeros(1,precision+1);

for j = 1:1:precision+1 
    
    D(j) = x(j) - b(j);

    if (D(j) >= 0)
        s(j) = 1;
        x(j+1) = D(j);
        y(j+1) = y(j)*a(j);
    else
        s(j) = 0;
        x(j+1) = x(j);
        y(j+1) = y(j);
    end 
end 

y;
x;
z = y(end);
z(integer_part >= 1) = integer_part * y(end);
err = truth - z;



