function dx_error = max_pool_backward_test()

%     x = randn(3, 2, 8, 8);
%     dout = randn(3, 2, 4, 4);

    x_shape = [3, 2, 8, 8];
    x = linspace(-1, 1, prod(x_shape)); 
    x = reshape(x, 8, 8, 2, 3); 
    x = permute(x, [4, 3, 2, 1]); 
    
    dout_shape = [3, 2, 4, 4];
    dout = linspace(-1, 1, prod(dout_shape));
    dout = reshape(dout, 4, 4, 2, 3); 
    dout = permute(dout, [4, 3, 2, 1]); 
    
    
    pool_height = 2; 
    pool_width = 2; 
    stride = 2; 
    
    pool_param = {pool_height, pool_width, stride}; 
     
    [dx_num, dw_num, db_num] = eval_numerical_gradient_array(x, 0, 0, dout, 1e-5, 'max_pool_forward_naive', {0,0}, pool_param ); 
    dx_num_temp = dx_num(1,1,:,:);
    dx = max_pool_backward_naive(dout, x, pool_param); 
    dx_temp = dx(1,1,:,:);

    % Your error should be around 1e-12
    disp ('Testing max_pool_backward_naive function:')
    dx_dim = size(dx);
    dx_num_dim = size(dx_num);
    
    dx_error = rel_error(dx, dx_num) ;

end 