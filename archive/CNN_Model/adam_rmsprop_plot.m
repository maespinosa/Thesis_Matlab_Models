function adam_rmsprop_plot(X_train, y_train, X_val, y_val)
    num_train = 4000; 
    X_train_dim_trainer = size(X_train); 
    y_train_dim_trainer = size(y_train);

    X_train = X_train(1:num_train,:,:,:); 
    y_train = y_train(1:num_train,:); 

    X_train_dim_trainer = size(X_train);
    y_train_dim_trainer = size(y_train);
    
    learning_rate = [1e-4, 1e-3]; 
    update_rule = {'rmsprop', 'adam'}; 
    
    loss_history_update_rule = []; 
    train_acc_history_update_rule = [];
    val_acc_history_update_rule = []; 
    
    for i = 1:1:length(update_rule)
      
      disp ('running with ')
      cell2mat(update_rule(i));
      
      [params, num_layers] = FullyConnectedNet_Init([100, 100, 100, 100, 100], 0, 0, 0, 0, 0, 5e-2); 	
      [loss_history, train_acc_history, val_acc_history] = Solver_train_params(X_train, y_train, X_val, y_val, 5, 1000, cell2mat(update_rule(i)), learning_rate(i), 1.0, 'true', params)

      loss_history_update_rule = [loss_history_update_rule, loss_history]
      train_acc_history_update_rule = [train_acc_history_update_rule, train_acc_history]
      val_acc_history_update_rule = [val_acc_history_update_rule, val_acc_history]
    end 

    number_of_points = length(loss_history_update_rule)
    xaxis = 1:1:number_of_points; 
    
    subplot(3, 1, 1)
    plot(xaxis, loss_history_update_rule(1), 'b',xaxis, loss_history_update_rule(2), 'r')
    title('Training loss')
    xlabel('Iteration')

    subplot(3, 1, 2)
    plot(xaxis, train_acc_history_update_rule(1), 'b--o',xaxis, train_acc_history_update_rule(2), 'r-+')
    title('Training accuracy')
    xlabel('Epoch')

    subplot(3, 1, 3)
    plot(xaxis, val_acc_history_update_rule(1), 'b--o',xaxis, val_acc_history_update_rule(2), 'r-+')
    title('Validation accuracy')
    xlabel('Epoch')
    
end 