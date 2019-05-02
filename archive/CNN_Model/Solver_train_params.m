function   [loss_history, train_acc_history, val_acc_history] = Solver_train_params(X_train, y_train, X_val, y_val, num_epochs, batch_size, update_rule, learning_rate, lr_decay, verbose, params,type)
%     """
%     Run optimization to train the model.
%     """
    disp('SOLVER_TRAIN EXECUTING'); 
    epoch = 0;
    best_val_acc = 0;
    best_params = {};
    loss_history = [];
    train_acc_history = [];
    val_acc_history = [];

    X_train_dim = size(X_train);
    %y_train_dim = size(y_train); 
    if(strcmp(type, 'TwoLayerNet') == 1) y_train = y_train + 1; 
    elseif(strcmp(type, 'FullyConnectedNet') == 1) y_train = y_train + 1; 
    elseif(strcmp(type, 'ThreeLayerConvNet') == 1) y_train = y_train; 
    end 
    
    %X_val_dim = size(X_val); 
    %y_val_dim = size(y_val);
    if(strcmp(type, 'TwoLayerNet') == 1) y_val = y_val + 1; 
    elseif(strcmp(type, 'FullyConnectedNet') == 1) y_val = y_val + 1; 
    elseif(strcmp(type, 'ThreeLayerConvNet') == 1) y_val = y_val;   
    end 
    
%     b1_dim = size(b1); 
%     b2_dim = size(b2); 
%     
%     b1 = transpose(b1);
%     b2 = transpose(b2);
%     
%     W1_dim = size(W1);
%     W2_dim = size(W2);
%     b1_dim = size(b1);
%     b2_dim = size(b2);
    
    num_train = X_train_dim(1) ;
    iterations_per_epoch = max(num_train / batch_size, 1);
    num_iterations = num_epochs * iterations_per_epoch;
    loss_history = []; 
    
    for t = 1:1:num_iterations
%       disp('Iteration ');
%       t 
%       disp('of '); 
%       num_iterations
      [loss_history, params] = Solver_step_params(X_train, y_train, batch_size,loss_history, learning_rate, params, update_rule,type); 

      % Maybe print training loss
      if (strcmp(verbose, 'true') == 1)
        Iteration = t
        num_iterations
        loss_history
      end

      % At the end of every epoch, increment the epoch counter and decay the
      % learning rate.
      epoch_end = (t + 1); % iterations_per_epoch == 0
      if (epoch_end > 0)
        epoch = epoch + 1;
        learning_rate = learning_rate * lr_decay; 
      end

      % Check train and val accuracy on the first iteration, the last
      % iteration, and at the end of each epoch.
      first_it = (t == 0); 
      last_it = (t == num_iterations + 1); 
      if (first_it == 1 || last_it == 1 || epoch_end > 0)
        disp('=====TRAIN_ACC=====')
        train_acc = Solver_check_accuracy_params(X_train, y_train, 1000, batch_size, params,type);
        disp('=====VAL_ACC=====')
        val_acc = Solver_check_accuracy_params(X_val, y_val, 0, 100, params, type); 
        train_acc_history = [train_acc_history; train_acc]; 
        val_acc_history =  [val_acc_history; val_acc];

        if (strcmp(verbose, 'true') == 1)
          epoch
          num_epochs
          train_acc
          val_acc
        end 

        % Keep track of the best model
        if (val_acc > best_val_acc)
          best_val_acc = val_acc; 
          for p = 1:1:length(params)
            best_params(p) = params(p);
          end 

        end 
      end 

      % At the end of training swap the best params into the model
      params = best_params; 
  
    end 
end 

