function [dx_error, dw_error, db_error] = affine_layer_backward_test()
    % Affine layer: backward
    %Now implement the `affine_backward` function and test your implementation using numeric gradient checking.

    % Test the affine_backward function

    disp('EXECUTING AFFINE LAYER BACKWARD TEST')
    disp('===================================================================')
    x = randn(10, 2, 3);
    w = randn(6, 5);
    b = randn(1,5);
    dout = randn(10, 5);
    h = 1e-5; 

    [dx_num, dw_num, db_num] = eval_numerical_gradient_array(x, w, b, dout, h, 'affine', {0,0}, {0,0,0});

    [out, x, w, b] = affine_forward(x, transpose(w), b); 
    [dx, dw, db] = affine_backward(dout, x, transpose(w), b); 
    
    % The error should be around 1e-10
    disp ('Testing affine_backward function:'); 
    dx_error = rel_error(dx_num, dx); 
    dw_error = rel_error(dw_num, dw);
    db_error = rel_error(db_num, db);

end 