function sanity_check_loss()

    N = 50; 
    %X = randn(N, 3, 32, 32); 
    y = randi([0, 9], N,1);% randint(10, N); 
    
    X_shape = [N, 3, 32, 32];
    X = linspace(-1, 1, prod(X_shape)); 
    X = reshape(X, 32, 32, 3, N); 
    X = permute(X, [4, 3, 2, 1]); 

    reg = 0.0; 
    params = ThreeLayerConvNet_init([3,32,32], 32, 7,100, 10, 1e-3); 
    [loss, grads, scores] = ThreeLayerConvNet_loss(X, y, reg, params); 

    disp ('Initial loss (no regularization): ')
    loss

    reg = 0.5; 
    [loss, grads, scores] = ThreeLayerConvNet_loss(X, y, reg, params); 

    disp('Initial loss (with regularization): ')
    loss


end
