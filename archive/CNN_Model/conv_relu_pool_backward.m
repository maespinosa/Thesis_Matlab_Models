function [dx, dw, db] = conv_relu_pool_backward(dout, conv_cache, conv_param, relu_x, pool_x, pool_param)

  %disp('EXECUTING CONV RELU POOL BACKWARD')

%   """
%   Backward pass for the conv-relu-pool convenience layer
%   """
  %disp('Max Pool Backward')
  %tic
  dx = max_pool_backward_naive(dout, pool_x, pool_param); 
  %toc
  %disp('Relu Backward')
  %tic
  da = relu_backward(dx, relu_x);
  %toc
  %conv_cache;
  x = cell2mat(conv_cache(1)); 
  w = cell2mat(conv_cache(2)); 
  b = cell2mat(conv_cache(3));
  %disp('Conv Backward Naive') 
  %tic 
  [dx, dw, db] = conv_backward_naive(da, x,w,b, conv_param); 
  %toc
end 
