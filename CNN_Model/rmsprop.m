function [next_x, learning_rate, decay_rate, epsilon] = rmsprop(x, dx, learning_rate, decay_rate, epsilon, cache)
%   """
%   Uses the RMSProp update rule, which uses a moving average of squared gradient
%   values to set adaptive per-parameter learning rates.
% 
%   config format:
%   - learning_rate: Scalar learning rate.
%   - decay_rate: Scalar between 0 and 1 giving the decay rate for the squared
%     gradient cache.
%   - epsilon: Small scalar used for smoothing to avoid dividing by zero.
%   - cache: Moving average of second moments of gradients.
%   """
  if(learning_rate == 0) 
      learning_rate = 1e-2; 
  end; 
  
  if(decay_rate == 0)
      decay_rate = 0.99; 
  end; 
  
  if(epsilon == 0) 
      epsilon = 1e-8; 
  end; 

%   #############################################################################
%   # TODO: Implement the RMSprop update formula, storing the next value of x   #
%   # in the next_x variable. Don't forget to update cache value stored in      #  
%   # config['cache'].                                                          #
%   #############################################################################
  
  cache = decay_rate * cache + (1 - decay_rate) * dx.^2; 
  
  x_dim = size(x);
  dx_dim = size(dx);
  cache_dim = size(cache);
  x = x + (-1*learning_rate) .* dx ./ (cache.^2 + 1e-7); 
  next_x = x; 
end 
