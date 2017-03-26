function [dx, dw, db] = affine_relu_backward(dout, fc_x, fc_w, fc_b, relu_x)

%   Backward pass for the affine-relu convenience layer

  da = relu_backward(dout, relu_x); 
  [dx, dw, db] = affine_backward(da, fc_x, fc_w, fc_b); 
end