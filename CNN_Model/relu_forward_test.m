function difference = relu_forward_test()

    %  ReLU layer: forward\n",
    %  Implement the forward pass for the ReLU activation function in the `relu_forward` function and test your implementation using the following:"
 
    %  Test the relu_forward function,

    disp('RELU LAYER FORWARD TEST')
    disp('===================================================================')
    x = linspace(-0.5, 0.5, 12); 
    x = reshape(x, 4,3);
    x_dim = size(x); 
    x = transpose(x);
    [out, cache] = relu_forward(x); 
    out; 
    correct_out = [ 0.,          0.,          0.,          0.; 
                    0.,          0.,          0.04545455,  0.13636364; 
                    0.22727273,  0.31818182,  0.40909091,  0.5]; 
    
    %  Compare your output with ours. The error should be around 1e-8\n",
    disp('Testing relu_forward function:')
    difference = rel_error(out, correct_out); 
end 
   
  