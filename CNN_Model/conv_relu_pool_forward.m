function [out, conv_cache, relu_x, pool_x, pool_param] = conv_relu_pool_forward(x, w, b, conv_param, pool_param)

    %disp('EXECUTING CONV RELU POOL FORWARD')
%   """
%   Convenience layer that performs a convolution, a ReLU, and a pool.
% 
%   Inputs:
%   - x: Input to the convolutional layer
%   - w, b, conv_param: Weights and parameters for the convolutional layer
%   - pool_param: Parameters for the pooling layer
% 
%   Returns a tuple of:
%   - out: Output from the pooling layer
%   - cache: Object to give to the backward pass
%   """
  %x_dim = size(x);
  %w_dim = size(w);
  %b_dim = size(b); 
  %disp('Conv Forward')
  %tic
  [a, conv_cache] = conv_forward_naive(x, w, b, conv_param);
  %toc
  %a_dim = size(a);
  %disp('Relu Forward')
  %tic
  [s, relu_x] = relu_forward(a); 
  %toc
  %disp('Max Pool Forward')
  %tic
  [out, pool_x, pool_param] = max_pool_forward_naive(s, pool_param); 
  %toc
  
  
  %cache = {conv_cache, relu_x, pool_x, pool_param}; 
end 

