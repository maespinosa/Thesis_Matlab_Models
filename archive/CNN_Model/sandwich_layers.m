function [dx_error, dw_error, db_error] = sandwich_layers()    
    % Sandwich layers
    %There are some common patterns of layers that are frequently used in 
    % neural nets. For example, affine layers are frequently followed by a 
    % ReLU nonlinearity. To make these common patterns easy, we define 
    % several convenience layers in the file `cs231n/layer_utils.py`.\n",
    
    %For now take a look at the `affine_relu_forward` and 
    % `affine_relu_backward` functions, and run the following to 
    % numerically gradient check the backward pass:"

    x = randn(2, 3, 4);
    w = randn(12, 10);
    b = randn(1,10);
    dout = randn(2, 10); 
    h = 1e-5; 
    
    [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(x, w, b); 
    [dx, dw, db] = affine_relu_backward(dout, fc_x, transpose(fc_w), fc_b, relu_x); 
      
    [dx_num, dw_num, db_num] = eval_numerical_gradient_array(x, w, b, dout, h, 'affine_relu', {0,0}, {0,0,0});
    
    disp('Testing affine_relu_forward:')
    dx_error = rel_error(dx_num, dx); 
    dw_error = rel_error(dw_num, dw);
    db_error = rel_error(db_num, db); 
    
end 
