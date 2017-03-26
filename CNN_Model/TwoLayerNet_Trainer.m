function TwoLayerNet_Trainer(X_train, y_train, X_val, y_val)
% ##############################################################################
% # TODO: Use a Solver instance to train a TwoLayerNet that achieves at least  #
% # 50% accuracy on the validation set.                                        #
% ##############################################################################
  
  disp('EXECUTING TWOLAYERNET_TRAINER'); 
  disp('===================================================================')
  num_train = 100;
  
  X_train_dim_trainer = size(X_train); 
  y_train_dim_trainer = size(y_train);
  
  X_train = X_train(1:num_train,:,:,:); 
  y_train = y_train(1:num_train,:); 
  
  X_train_dim_trainer = size(X_train);
  y_train_dim_trainer = size(y_train);
  
  [W1,b1,W2,b2] = TwoLayerNet_init(3*32*32, 100, 10, 1e-3); 

  [loss_history, train_acc_history, val_acc_history]= Solver_train(X_train, y_train, X_val, y_val,10, 50, 'sgd', 1e-3, 1.0,'true', W1, b1, W2, b2);
  
  % Run this cell to visualize training loss and train / val accuracy

  subplot(2, 1, 1)
  plot(loss_history, '-o')
  title('Training loss')
  xlabel('Iteration')

  number_of_points = length(train_acc_history); 
  xaxis = 1:1:number_of_points; 
  
  subplot(2, 1, 2)
  plot(xaxis, train_acc_history, 'b--o',xaxis, val_acc_history, 'r-+')
  title('Accuracy')
  xlabel('Epoch')

end 

