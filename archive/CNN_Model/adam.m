function [next_x, m, v, t] = adam(x, dx, learning_rate, beta1, beta2, epsilon, m, v, t)
%   """
%   Uses the Adam update rule, which incorporates moving averages of both the
%   gradient and its square and a bias correction term.
% 
%   config format:
%   - learning_rate: Scalar learning rate.
%   - beta1: Decay rate for moving average of first moment of gradient.
%   - beta2: Decay rate for moving average of second moment of gradient.
%   - epsilon: Small scalar used for smoothing to avoid dividing by zero.
%   - m: Moving average of gradient.
%   - v: Moving average of squared gradient.
%   - t: Iteration number.
%   """
  if(learning_rate == 0) 
      learning_rate = 1e-3; 
  end; 
  
  if(beta1 == 0) 
      beta1 = 0.9; 
  end; 
  
  if(beta2 == 0)
      beta2 = 0.999; 
  end; 
  
  if(epsilon == 0)
      epsilon = 1e-8; 
  end; 

%   #############################################################################
%   # TODO: Implement the Adam update formula, storing the next value of x in   #
%   # the next_x variable. Don't forget to update the m, v, and t variables     #
%   # stored in config.                                                         #
%   #############################################################################

%   #print('dx shape = ', dx.shape)
%   #print('x shape = ', x.shape)
  x_dim = size(x);
  dx_dim = size(dx); 
  m_dim = size(m); 
  v_dim = size(v); 
  
  
  x_reshaped = reshape(x, x_dim(1), (prod(x_dim(2:end)))); 
  dx_reshaped = reshape(dx, dx_dim(1), (prod(dx_dim(2:end))));

  m = reshape(m, m_dim(1),(prod(m_dim(2:end))));
  v = reshape(v, v_dim(1),(prod(v_dim(2:end))));
  
  m = beta1 .* m + (1-beta1).*dx_reshaped;  
  %#print('m shape = ', m.shape)
  v = beta2 .* v + (1-beta2).*(dx_reshaped.^2); 
  %#print('v shape = ', v.shape)
  mb = m ./((1-beta1)^t); 
  %#print('mb shape = ', mb.shape)
  vb = v ./((1-beta2)^t); 
  %#print('vb shape = ', vb.shape)
  x_reshaped = x_reshaped + (-1*learning_rate) .* mb ./ (vb.^2 + 1e-7); 
  %#print('x shape = ', x.shape)
  next_x = reshape(x,x_dim);
  
  m = reshape(m, m_dim);
  v = reshape(v, v_dim);
  t = t;
end 

  