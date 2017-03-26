function [dx_error, dw_error, db_error] = Conv_Naive_Backward_test()
    disp('EXECUTING CONV NAIVE BACKWARD TEST'); 
%     x = randn(4, 3, 5, 5);
%     w = randn(2, 3, 3, 3); 
%     b = randn(2,1);
%     dout = randn(4, 2, 5, 5);
    dx_error = 0; 
    dw_error = 0; 
    db_error = 0; 

    x_shape = [4, 3, 5, 5];
    w_shape = [2, 3, 3, 3]; 
    x = linspace(-1, 1, prod(x_shape)); 
    x = reshape(x, 5, 5, 3, 4); 
    x = permute(x, [4, 3, 2, 1]); 
    w = linspace(-1, 1, prod(w_shape)); 
    w = reshape(w, 3, 3, 3, 2); 
    w = permute(w, [4, 3, 2,1]);
    b = linspace(-1, 1, 2); 
    
    dout_shape = [4, 2, 5, 5];
    dout = linspace(-1, 1, prod(dout_shape));
    dout = reshape(dout, 5, 5, 2, 4); 
    dout = permute(dout, [4, 3, 2,1]); 
    
    stride = 1;
    pad = 1;
    conv_param = {pad, stride}; 

    [dx_num, dw_num, db_num] = eval_numerical_gradient_array(x, w, b, dout, 1e-5, 'conv_forward_naive', conv_param, {0,0,0}); 
    dx_num_temp = dx_num(1,1,:,:); 
    %dx_num = dx_num(:); 
    %[out, x, w, b] = conv_forward_naive(x, w, b, pad, stride); 
    %dx, dw, db = conv_backward_naive(dout, cache)
    [dx, dw, db] = conv_backward_naive(dout, x, w, b, conv_param);

    %# Your errors should be around 1e-9' 
    disp ('Testing conv_backward_naive function')
    dx_error = rel_error(dx, dx_num); 
     dw_error = rel_error(dw, dw_num);
    db_error = rel_error(db, db_num);

end 