function w = sgd(w, dw, learning_rate)
%   """
%   Performs vanilla stochastic gradient descent.
% 
%   config format:
%   - learning_rate: Scalar learning rate.
%   """
  if (learning_rate == 0)
    learning_rate = 1e-2; 
  else 
    learning_rate = learning_rate; 
  end 

  w = w - (learning_rate * dw); 
end 


  