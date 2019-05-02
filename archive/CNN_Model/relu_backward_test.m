function dx_error = relu_backward_test()   
    % ReLU layer: backward\n",
    % Now implement the backward pass for the ReLU activation function in the `relu_backward` function and test your implementation using numeric gradient checking:"

    disp('RELU LAYER BACKWARD TEST')
    disp('===================================================================')
    x = randn(10, 5); 
    x_dim = size(x); 
    dout = randn(10, 5);
    h = 1e-5; 
    
    x; 
    dout; 
    
    [dx_num, dw_num, db_num] = eval_numerical_gradient_array(x, 0, 0, dout, h, 'relu', {0,0}, {0,0,0});
    dx_num;  
    
    [out, cache] = relu_forward(x); 
    dx = relu_backward(dout, cache); 
    
    % The error should be around 1e-12
    disp('Testing relu_backward function:')
    dx_error = rel_error(dx_num, dx); 
end
