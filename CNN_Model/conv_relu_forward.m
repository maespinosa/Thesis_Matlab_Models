function [out, conv_x, conv_w, conv_b, relu_x] = conv_relu_forward(x, w, b, pad, stride)
%   """
%   A convenience layer that performs a convolution followed by a ReLU.
% 
%   Inputs:
%   - x: Input to the convolutional layer
%   - w, b, conv_param: Weights and parameters for the convolutional layer
%   
%   Returns a tuple of:
%   - out: Output from the ReLU
%   - cache: Object to give to the backward pass
%   """

  
  [a, conv_x, conv_w, conv_b] = conv_forward_fast(x, w, b, pad, stride); 
  [out, relu_x] = relu_forward(a); 
end 
