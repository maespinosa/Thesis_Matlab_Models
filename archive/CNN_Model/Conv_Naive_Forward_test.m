function difference = Conv_Naive_Forward_test()
    disp('EXECUTING CONV NAIVE FORWARD TEST'); 

    x_shape = [2, 3, 4, 4];
    w_shape = [3, 3, 4, 4]; 
    x = linspace(-0.1, 0.5, prod(x_shape)); 
    x = reshape(x, 4, 4, 3, 2); 
    x = permute(x, [4, 3, 2,1]); 
    w = linspace(-0.2, 0.3, prod(w_shape)); 
    w = reshape(w, 4, 4, 3, 3); 
    w = permute(w, [4, 3, 2,1]); 
    b = linspace(-0.1, 0.2, 3); 
    
    test1 = x(1,1,:,:);
    test2 = x(1,2,:,:);
    
    stride = 2;
    pad = 1;
    
    conv_param = {pad, stride}; 
    
    [out, cache] = conv_forward_naive(x, w, b, conv_param); 
    
    output = out(1,1,:,:);
    out_dim = size(out);
    difference = 0; 
    correct_out = zeros(2,3,2,2); 
    
    correct_out(1,1,:,:) = [-0.08759809, -0.10987781;
                            -0.18387192, -0.2109216 ]; 
                        
    correct_out(1,2,:,:) = [ 0.21027089,  0.21661097; 
                             0.22847626,  0.23004637]; 
                         
    correct_out(1,3,:,:) = [ 0.50813986,  0.54309974;
                             0.64082444,  0.67101435];         
                         
    correct_out(2,1,:,:) = [-0.98053589, -1.03143541;
                            -1.19128892, -1.24695841];      
                        
    correct_out(2,2,:,:) = [ 0.69108355,  0.66880383; 
                             0.59480972,  0.56776003];   
                        
    correct_out(2,3,:,:) = [ 2.36270298,  2.36904306; 
                             2.38090835,  2.38247847];   


    % Compare your output to ours; difference should be around 1e-8
    disp ('Testing conv_forward_naive')
    difference = rel_error(out, correct_out); 
    
end 