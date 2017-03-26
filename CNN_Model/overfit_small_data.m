function [loss_history, train_acc_history, val_acc_history] = overfit_small_data(X_train, y_train, X_val, y_val)

    disp('EXECUTING THREELAYERCONVNET_TRAINER'); 
    disp('===================================================================')
    
    
    X_val_dim_trainer = size(X_val); 
    y_val_dim_trainer = size(y_val);
    
    num_train = 100; 

    X_train_dim_trainer = size(X_train); 
    y_train_dim_trainer = size(y_train);

    X_train = X_train(1:num_train,:,:,:); 
    y_train = y_train(1:num_train,:); 
    

    X_train_dim_trainer = size(X_train);
    y_train_dim_trainer = size(y_train);

    input_dim = [3,32,32]; 
    num_filters = 32; 
    filter_size = 7; 
    hidden_dim = 100;
    num_classes = 10; 
    weight_scale = 1e-3; 
    num_epochs = 10; 
    batch_size = 50; 
    update_rule = 'adam'; 
    learning_rate = 1e-3; 
    lr_decay = 1.0; 
    verbose = 'true'; 
    type = 'ThreeLayerConvNet'; 

    

    params = ThreeLayerConvNet_init(input_dim, num_filters, filter_size, hidden_dim, num_classes, weight_scale); 

    [loss_history, train_acc_history, val_acc_history] = Solver_train_params(X_train, y_train, X_val, y_val, num_epochs, batch_size, update_rule, learning_rate, lr_decay, verbose, params,type); 

end 
  
