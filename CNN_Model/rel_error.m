function err = rel_error(x, y)

  %""" returns relative error """
  x_dim = size(x);
  y_dim = size(y);
  
%   for i = 1:1:x_dim(1)
%       for j = 1:1:x_dim(2)
%         err = max(abs(x(i,j) - y(i,j)) / (max(1e-8, abs(x(i,j)) + abs(y(i,j)))));
%       end 
%   end 
  
  x_minus_y = x-y;
  numer = abs(x_minus_y);
  abs_x = abs(x); 
  abs_y = abs(y); 
  absx_plus_absy = abs_x + abs_y; 
  denom = absx_plus_absy; %zeros(size(absx_plus_absy)); 
  denom(1e-8 > absx_plus_absy) = 1e-8; 
  %denom(1e-8 < absx_plus_absy) = absx_plus_absy;
  %denom(1e-8 <= absx_plus_absy) = 0;
  
  
  err = max(numer ./ denom);
  err_dim = size(err);
  
  %err = max(abs(x-y) ./ max(1e-8, abs(x) + abs(y))); 
  length(err);
  
  while (prod(size(err)) ~= 1)
      err = max(err);
      err_dim = size(err);
  end 
  
  err; 