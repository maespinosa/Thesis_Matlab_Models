function difference = max_pooling_test()

    x_shape = [2, 3, 4, 4]; 
    x = linspace(-0.3, 0.4, prod(x_shape)); 
    x = reshape(x, 4, 4, 3, 2); 
    x = permute(x, [4, 3, 2, 1]); 
    
    pool_width = 2; 
    pool_height = 2; 
    stride = 2; 
    difference = 1; 
    pool_param = {pool_width, pool_height, stride}; 

   [out, cache] = max_pool_forward_naive(x, pool_param);

    correct_out(1,1,:,:) = [-0.26315789, -0.24842105; 
                            -0.20421053, -0.18947368]; 

    correct_out(1,2,:,:) = [-0.14526316, -0.13052632;
                            -0.08631579, -0.07157895]; 

    correct_out(1,3,:,:) = [-0.02736842, -0.01263158; 
                             0.03157895,  0.04631579]; 

    correct_out(2,1,:,:) = [ 0.09052632,  0.10526316; 
                             0.14947368,  0.16421053]; 

    correct_out(2,2,:,:) = [ 0.20842105,  0.22315789;
                             0.26736842,  0.28210526]; 

    correct_out(2,3,:,:) = [ 0.32631579,  0.34105263; 
                             0.38526316,  0.4       ]; 



     % Compare your output with ours. Difference should be around 1e-8.
     disp ('Testing max_pool_forward_naive function:')
     difference = rel_error(out, correct_out); 

end 