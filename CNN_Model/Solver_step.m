function [loss_history, W1, b1, W2, b2] = Solver_step(X_train, y_train, batch_size, loss_history, learning_rate, W1, b1, W2, b2)
%     """
%     Make a single gradient update. This is called by train() and should not
%     be called manually.
%     """
    % Make a minibatch of training data
    %disp('SOLVER_STEP EXECUTING'); 
    X_train; 
    X_train_dim = size(X_train);
    W1_dim_solver_step = size(W1);
    b1_dim_solver_step = size(b1);
    W2_dim_solver_step = size(W2);
    b2_dim_solver_step = size(b2);
    
    num_train = X_train_dim(1);
    batch_mask = datasample(1:num_train, batch_size);
    X_batch = X_train(batch_mask,:,:,:);
    y_batch = y_train(batch_mask,:);

    % Compute loss and gradient

    [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(X_batch, y_batch, 0, W1, b1, W2, b2); 
    loss_history = [loss_history; loss];  

    % Perform a parameter update
    W1 = sgd(W1, dW1, learning_rate); 
    b1 = sgd(b1, db1, learning_rate); 
    W2 = sgd(W2, dW2, learning_rate); 
    b2 = sgd(b2, db2, learning_rate);
