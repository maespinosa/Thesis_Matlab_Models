function [dx_error, dw_error, db_error] = convolutional_sandwich_layers()

%     x = np.random.randn(2, 3, 16, 16)
%     w = np.random.randn(3, 3, 3, 3)
%     b = np.random.randn(3,)
%     dout = np.random.randn(2, 3, 8, 8)
    
    
    x_shape = [2, 3, 16, 16];
    w_shape = [3, 3, 3, 3]; 
    x = linspace(-1, 1, prod(x_shape)); 
    x = reshape(x, 16, 16, 3, 2); 
    x = permute(x, [4, 3, 2, 1]); 
    w = linspace(-1, 1, prod(w_shape)); 
    w = reshape(w, 3, 3, 3, 3); 
    w = permute(w, [4, 3, 2,1]);
    b = linspace(-1, 1, 3); 
    
    dout_shape = [2, 3, 8, 8];
    dout = linspace(-1, 1, prod(dout_shape));
    dout = reshape(dout, 8, 8, 3, 2); 
    dout = permute(dout, [4, 3, 2,1]); 
    
    conv_stride = 1; 
    conv_pad = 1; 
    
    pool_height = 2; 
    pool_width = 2; 
    pool_stride = 2; 
    
    conv_param = {conv_stride, conv_pad}; 
    pool_param = {pool_height, pool_width, pool_stride}; 

    [out, conv_cache, relu_x, pool_x, pool_param] = conv_relu_pool_forward(x, w, b, conv_param, pool_param);
    
    x == cell2mat(conv_cache(1));
    w == cell2mat(conv_cache(2)); 
    b == cell2mat(conv_cache(3)); 

    [dx, dw, db] = conv_relu_pool_backward(dout, conv_cache, conv_param, relu_x, pool_x, pool_param);

    [dx_num, dw_num, db_num] = eval_numerical_gradient_array(x, w, b, dout, 1e-5, 'conv_relu_pool_forward', conv_param, pool_param);
    
    dx_num_dim = size(dx_num)
    dw_num_dim = size(dw_num) 
    db_num_dim = size(db_num) 
    
    dx_dim = size(dx)
    dw_dim = size(dw) 
    db_dim = size(db) 
    
    disp ('Testing conv_relu_pool')
    dx_error = rel_error(dx_num, dx); 
    dw_error = rel_error(dw_num, dw); 
    db_error = rel_error(db_num, db); 

end 