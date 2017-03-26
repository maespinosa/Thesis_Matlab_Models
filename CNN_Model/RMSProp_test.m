function [next_w_error, cache_error] = RMSProp_test()

    %# RMSProp and Adam
    % RMSProp [1] and Adam [2] are update rules that set per-parameter learning 
    % rates by using a running average of the second moments of gradients.

    % In the file `cs231n/optim.py`, implement the RMSProp update rule in the 
    % `rmsprop` function and implement the Adam update rule in the `adam` 
    % function, and check your implementations using the tests below.

    %[1] Tijmen Tieleman and Geoffrey Hinton. "Lecture 6.5-rmsprop: Divide the 
    % gradient by a running average of its recent magnitude." COURSERA: Neural 
    % Networks for Machine Learning 4 (2012).

    %[2] Diederik Kingma and Jimmy Ba, "Adam: A Method for Stochastic 
    % Optimization", ICLR 2015.


    %# Test RMSProp implementation; you should see errors less than 1e-7
    %  from cs231n.optim import rmsprop
    disp('EXECUTING RMSPROP TEST'); 
    disp('===================================================================')
    N = 4; 
    D = 5; 
    w = linspace(-0.4, 0.6, N*D);
    w = reshape(w, D, N);
    dw = linspace(-0.6, 0.4, N*D);
    dw = reshape(dw, D, N);
    cache = linspace(0.6, 0.9, N*D);
    cache = reshape(cache, D, N);

    learning_rate = 1e-2; 

    [next_w, learning_rate, decay_rate, epsilon] = rmsprop(w, dw, learning_rate, 0, 0, cache);

    expected_next_w = [ -0.39223849, -0.34037513, -0.28849239, -0.23659121, -0.18467247; 
                        -0.132737,   -0.08078555, -0.02881884,  0.02316247,  0.07515774; 
                         0.12716641,  0.17918792,  0.23122175,  0.28326742,  0.33532447; 
                         0.38739248,  0.43947102,  0.49155973,  0.54365823,  0.59576619]; 

    expected_cache =  [  0.5976,      0.6126277,   0.6277108,   0.64284931,  0.65804321; 
                         0.67329252,  0.68859723,  0.70395734,  0.71937285,  0.73484377; 
                         0.75037008,  0.7659518,   0.78158892,  0.79728144,  0.81302936; 
                         0.82883269,  0.84469141,  0.86060554,  0.87657507,  0.8926    ]; 

    next_w_error = rel_error(transpose(expected_next_w), next_w); 
    cache_error = rel_error(transpose(expected_cache), cache); 
end 