function [next_w_error, velocity_error] = SGD_Momentum_test(X_train, y_train, X_val, y_val)

    % # SGD+Momentum
    % Stochastic gradient descent with momentum is a widely used update rule 
    % that tends to make deep networks converge faster than vanilla stochstic 
    % gradient descent.
    % 
    % Open the file `cs231n/optim.py` and read the documentation at the top of 
    % the file to make sure you understand the API. Implement the SGD+momentum 
    % update rule in the function `sgd_momentum` and run the following to check 
    % your implementation. You should see errors less than 1e-8.
    % 
    % from cs231n.optim import sgd_momentum

    N= 4; 
    D = 5; 
    w = linspace(-0.4, 0.6, N*D); 
    w = reshape(w, D,N); 
    dw = linspace(-0.6, 0.4, N*D); 
    dw = reshape(dw, D,N); 
    v = linspace(0.6, 0.9, N*D); 
    v = reshape(v, D,N); 

    %config = {'learning_rate': 1e-3, 'velocity': v}
    
    learning_rate = 1e-3;
    
    [next_w, velocity, learning_rate, momentum] = SGD_Momentum(w, dw, v, learning_rate, 0); 

    expected_next_w = [0.1406,      0.20738947,  0.27417895,  0.34096842,  0.40775789; 
                       0.47454737,  0.54133684,  0.60812632,  0.67491579,  0.74170526; 
                       0.80849474,  0.87528421,  0.94207368,  1.00886316,  1.07565263; 
                       1.14244211,  1.20923158,  1.27602105,  1.34281053,  1.4096    ]; 

    expected_velocity = [0.5406,      0.55475789,  0.56891579, 0.58307368,  0.59723158; 
                         0.61138947,  0.62554737,  0.63970526,  0.65386316,  0.66802105; 
                         0.68217895,  0.69633684,  0.71049474,  0.72465263,  0.73881053; 
                         0.75296842,  0.76712632,  0.78128421,  0.79544211,  0.8096    ]; 

    next_w_error = rel_error(transpose(next_w), expected_next_w); 
    velocity_error = rel_error(transpose(expected_velocity), velocity); 
    
    
    num_train = 4000; 
    X_train_dim_trainer = size(X_train); 
    y_train_dim_trainer = size(y_train);

    X_train = X_train(1:num_train,:,:,:); 
    y_train = y_train(1:num_train,:); 

    X_train_dim_trainer = size(X_train);
    y_train_dim_trainer = size(y_train);

    loss_history_update_rule = []; 
    train_acc_history_update_rule = [];
    val_acc_history_update_rule = []; 
    
    update_rule = {'sgd', 'sgd_momentum'};
    
    for i = 1:1:length(update_rule) 
      disp('running with ')
      update_rule(i)

      [params, num_layers] = FullyConnectedNet_Init([100, 100, 100, 100, 100], 0, 0, 0, 0, 0, 5e-2)	
      [loss_history, train_acc_history, val_acc_history] = Solver_train_params(X_train, y_train, X_val, y_val, 5, 100, cell2mat(update_rule(i)), 1e-2, 1.0, 'true', params);

      loss_history_update_rule = [loss_history_update_rule, loss_history]; 
      train_acc_history_update_rule = [train_acc_history_update_rule, train_acc_history];
      val_acc_history_update_rule = [val_acc_history_update_rule, val_acc_history]; 
    end; 

    number_of_points = length(loss_history_update_rule(1)); 
    xaxis = 1:1:number_of_points; 

    subplot(3, 1, 1);
    plot(xaxis, loss_history_update_rule(1), 'b--o',xaxis, loss_history_update_rule(2), 'r-+')
    title('Training loss');
    xlabel('Iteration');

    subplot(3, 1, 2);
    plot(xaxis, train_acc_history_update_rule(1), 'b--o',xaxis, train_acc_history_update_rule(2), 'r-+')
    title('Training accuracy');
    xlabel('Epoch');

    subplot(3, 1, 3);
    plot(xaxis, val_acc_history_update_rule(1), 'b--o',xaxis, val_acc_history_update_rule(2), 'r-+')
    title('Validation accuracy');
    xlabel('Epoch');

% for update_rule, solver in solvers.items():
%   subplot(3, 1, 1); 
%   plot(loss_history, 'o', label=update_rule); 
%   
%   subplot(3, 1, 2)
%   plot(train_acc_history, '-o', label=update_rule); 
% 
%   subplot(3, 1, 3)
%   plot(val_acc_history, '-o', label=update_rule)
  
% for i in [1, 2, 3]:
%   subplot(3, 1, i)
%   legend(loc='upper center', ncol=4)
% gcf().set_size_inches(15, 15)
% show()
end 