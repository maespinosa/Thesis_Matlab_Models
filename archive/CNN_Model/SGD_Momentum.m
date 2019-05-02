function [next_w, velocity, learning_rate, momentum] = SGD_Momentum(w, dw, velocity, learning_rate, momentum)
%   """
%   Performs stochastic gradient descent with momentum.
% 
%   config format:
%   - learning_rate: Scalar learning rate.
%   - momentum: Scalar between 0 and 1 giving the momentum value.
%     Setting momentum = 0 reduces to sgd.
%   - velocity: A numpy array of the same shape as w and dw used to store a moving
%     average of the gradients.
%   """
  if(learning_rate == 0) 
      learning_rate = 1e-2; 
  end;  
  
  if(momentum == 0)
      momentum = 0.9; 
  end;
  
%   if(velocity == 0)
%     v = zeros(w); 
%   end; 
  
%   #############################################################################
%   # TODO: Implement the momentum update formula. Store the updated value in   #
%   # the next_w variable. You should also use and update the velocity v.       #
%   #############################################################################
  v = velocity; 
  v = momentum * v - learning_rate * dw; 
  w = w + v; 
  next_w = w; 
  
  velocity = v; 

