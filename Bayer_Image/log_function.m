function [z,err] = log_function(x0, precision)

% NOTE: This function accepts POSITIVE NORMALIZED FRACTIONS ONLY. 
%       Domain for x0 is: 
%            0.21 <= x0 <= 3.45

% Multiplicative Normalization 

%Solve for y = log(x0)
% (i)   x_i+1 = xi * bi
% (ii)  y_i+1 = yi - g(bi)

% bi is selected so that x_i+1 approaches 1, i.e.
%
%           x_i+1 = x0(Product[l=0, i](bl)) ==> 1 

% Thus after m steps 
%
%           Product[l=0,m-1] (bl) = 1/x0  (the multiplicative inverse)

% If si is element of set {-1, 0, 1} then 
%
%           bi = (1+si*2^(-i))

% The One-sided selection rule with si element of set {0,1} can be employed
% here.  If xi already has i leading 1's then the multiplication 
%
%           x_i+1 = xi*bi = xi + xi*si*2^(-i) 
%
% with si = 1 will produce (i+1) leading 1's in x_i+1 

% Therefore formula (ii) is
%
%            y_i+1 = y0 - Sum[l=0,i](g*bl)
%
% If g*bl = ln bl, then 
%
%           y_i+1 = y0 - Sum[l=0,i](ln*bl) = y0 - ln*Product[l=0,i](bl)
%
% Therefore, when x_i+1 approaches 1, y_i+1 converges to 
%
%           ym = y0 - ln(1/x0) = y0 + ln(x0)

% y_i+1 approaches y0 + ln(x0) when x_i+1 approaches 1


% In step (i+1) we form the difference 
%   D = xi*(1+2^(-i))
%        si =   { 1  if  D >= 0 
%               { 0  if  D < 0

%     x_i+1 =   { D  if  D >= 0
%               { xi if  D < 0

%     y_i+1 =   { yi*(1+2^(-i)) if D >= 0
%               { yi            if D < 0



y0 = 0;
truth = log(x0)

x = zeros(1,precision+2);
x(1,1) = x0;
y = zeros(1,precision+2);
y(1,1) = y0;

i = 0:1:precision;

bi_P1 = 1 + 2.^(-1.*i)
bi_P1_scaled = (1024)*bi_P1
bi_P1_bin = dec2bin(bi_P1_scaled)


ci_P1 = log(bi_P1)
ci_P1_scaled = (1024)*ci_P1
ci_P1_bin = dec2bin(ci_P1_scaled)


bi_N1 = 1 - 2.^(-1.*i)
bi_N1_scaled = (1024)*bi_N1
bi_N1_bin = dec2bin(bi_N1_scaled)


ci_N1 = log(bi_N1)
ci_check = ~isinf(ci_N1)*1024
ci_N1_scaled = -1.*(ci_check).*ci_N1
ci_N1_bin = dec2bin(ci_N1_scaled(2:end))

% b(6:end) = 2.^(-1.*i(6:end));

s = zeros(1,precision+1);
P = zeros(1,precision+1);

for j = 1:1:precision+1 
    
    P(j) = x(j) * bi_P1(j);

    if (P(j) <= 1)
        s(j) = 1;
        x(j+1) = x(j) * bi_P1(j);
        y(j+1) = y(j)+ci_P1(j);
    else
        s(j) = 0;
        x(j+1) = x(j);
        y(j+1) = y(j);
    end 
end 
y
x

y = dec2bin(y)
x = dec2bin(x)
z = bin2dec(y(end))

% z(integer_part >= 1) = integer_part * y(end);
%err = truth - z;



