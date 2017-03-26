function [dW1_error, db1_error, dW2_error, db2_error] = two_layer_network_solver()
    % Two-layer network
    %  In the previous assignment you implemented a two-layer neural network in
    %  a single monolithic class. Now that you have implemented modular 
    %  versions of the necessary layers, you will reimplement the two layer 
    %  network using these modular implementations.

    %  Open the file `cs231n/classifiers/fc_net.py` and complete the 
    %  implementation of the `TwoLayerNet` class. This class will serve as a 
    %  model for the other networks you will implement in this assignment, so 
    %  read through it to make sure you understand the API. You can run the 
    %  cell below to test your implementation.

    % Solver
    % In the previous assignment, the logic for training models was coupled to 
    %  the models themselves. Following a more modular design, for this 
    %  assignment we have split the logic for training models into a separate 
    %  class.

    % Open the file `cs231n/solver.py` and read through it to familiarize 
    % yourself with the API. After doing so, use a `Solver` instance to train a 
    % `TwoLayerNet` that achieves at least `50%`accuracy on the validation set.

    disp('EXECUTING TWO LAYER NETWORK SOLVER')
    disp('===================================================================')
    N = 3; 
    D = 5; 
    H = 50; 
    C = 7; 

    X = randn(N, D);
    X_dim = size(X) 
    y = randi(C, N);
    y_dim = size(y)

    std_dev = 1e-2; 
    reg = 0.0; 
    [W1,b1,W2,b2] = TwoLayerNet_init(D, H, C, std_dev); 
    
    W1;
    
    W1_dim = size(W1)
    b1_dim = size(b1); 
    W2_dim = size(W2); 
    b2_dim = size(b2); 
    
    
    disp('Testing initialization ... ')
    W1_std = abs(std2(W1) - std_dev)
    W2_std = abs(std2(W2) - std_dev)

    assert(W1_std < (std_dev / 10.0), 'First layer weights do not seem right')
    assert(all(b1 == 0), 'First layer biases do not seem right')
    assert(W2_std < (std_dev / 10.0), 'Second layer weights do not seem right')
    assert(all(b2 == 0), 'Second layer biases do not seem right')

    disp('Testing test-time forward pass ... ')
    W1 = linspace(-0.7, 0.3, D*H);
    W1 = reshape(W1,H,D); 
    W1 = transpose(W1); 
    solver_W1_dim = size(W1);
    b1 = linspace(-0.1, 0.9, H);
    solver_b1_dim = size(b1);
    W2 = linspace(-0.3, 0.4, H*C);
    W2 = reshape(W2,C,H);
    W2 = transpose(W2);
    solver_W2_dim = size(W2);
    b2 = linspace(-0.9, 0.1, C);
    solver_b2_dim = size(b2);
    X = linspace(-5.5, 4.5, N*D);
    X = reshape(X,N,D)
    [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(X,y,reg,W1,b1,W2,b2); 
    scores
    correct_scores = [11.53165108,  12.2917344,   13.05181771,  13.81190102,  14.57198434, 15.33206765,  16.09215096; 
                      12.05769098,  12.74614105,  13.43459113,  14.1230412,   14.81149128, 15.49994135,  16.18839143;
                      12.58373087,  13.20054771,  13.81736455,  14.43418138,  15.05099822, 15.66781506,  16.2846319]; 
                  
    scores_diff = abs(scores - correct_scores);
    scores_diff = sum(sum(scores_diff));
    assert (scores_diff < 1e-6, 'Problem with test-time forward pass')

    disp('Testing training loss (no regularization)')
    y = [0+1; 5+1; 1+1]; 
    reg = 0.0; 
    [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(X, y, reg, W1, b1, W2, b2); 
    loss
    correct_loss = 3.4702243556
    assert(abs(loss - correct_loss) < 1e-10, 'Problem with training-time loss')

    reg = 1.0;
    [loss, grads] = TwoLayerNet_loss(X, y, reg, W1, b1, W2, b2);
    loss
    correct_loss = 26.5948426952
   
    assert(abs(loss - correct_loss) < 1e-10, 'Problem with regularization loss')
    
    regs = [0.0, 0.7]; 
    h = 0.00001;
    
    for i = 1:1:length(regs)
      disp('Running numeric gradient check with reg = ')
      reg = regs(i);
      
      [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(X, y, reg, W1, b1, W2, b2);
      loss; 

      [dx_num, dW1_num, db1_num, dW2_num, db2_num] = eval_numerical_gradient(X,y,h,W1,b1,W2,b2,reg); 
      
      size(db1_num);
      size(db1);
      
      dW1
      db1
      dW2
      db2
   
      dW1_error = rel_error(dW1_num, dW1)
      db1_error = rel_error(db1_num, db1)
      dW2_error = rel_error(dW2_num, dW2)
      db2_error = rel_error(db2_num, db2)
    
    end 
end 
