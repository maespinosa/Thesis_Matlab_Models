function [loss_history, train_acc_history, val_acc_history] = ThreeLayerNet_50_test(X_train, y_train, X_val, y_val)

% # TODO: Use a three-layer Net to overfit 50 training examples.
  
  disp('EXECUTING THREELAYERNET 50 TEST'); 
  disp('===================================================================')
  num_train = 50; 

  X_train_dim_trainer = size(X_train); 
  y_train_dim_trainer = size(y_train);
  
  X_train = X_train(1:num_train,:,:,:); 
  y_train = y_train(1:num_train,:); 
  
  X_train_dim_trainer = size(X_train);
  y_train_dim_trainer = size(y_train);
  
  
  weight_scale = 5e-2;
  learning_rate = 10e-4;
  
  [params, num_layers] = FullyConnectedNet_Init([100, 100], 0, 0, 0, 0, 0, weight_scale);

     
  [loss_history, train_acc_history, val_acc_history]= Solver_train_params(X_train, y_train, X_val, y_val, 20, 25, 'sgd', learning_rate, 1.0,'true', params);
  

  plot(loss_history, '-o')
  title('Three Layer Training loss history')
  xlabel('Iteration')
  ylabel('Training loss')
  
end 

