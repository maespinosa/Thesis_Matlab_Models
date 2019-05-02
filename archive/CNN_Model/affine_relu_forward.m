function [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(x, w, b)

%   Convenience layer that perorms an affine transform followed by a ReLU
% 
%   Inputs:
%   - x: Input to the affine layer
%   - w, b: Weights for the affine layer
% 
%   Returns a tuple of:
%   - out: Output from the ReLU
%   - cache: Object to give to the backward pass

  [a, fc_x, fc_w, fc_b] = affine_forward(x, transpose(w), b); 
  [out, relu_x] = relu_forward(a); 

end 