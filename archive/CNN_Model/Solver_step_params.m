function [loss_history, params] = Solver_step_params(X_train, y_train, batch_size, loss_history, learning_rate, params, update_rule,type)
%     """
%     Make a single gradient update. This is called by train() and should not
%     be called manually.
%     """
    % Make a minibatch of training data
    
    disp('=====SOLVER_STEP EXECUTING====='); 
    %X_train; 
    X_train_dim = size(X_train);
   
    num_train = X_train_dim(1);
    batch_mask = datasample(1:num_train, batch_size);
    X_batch = X_train(batch_mask,:,:,:);
    y_batch = y_train(batch_mask,:);

    % Compute loss and gradient
    if (strcmp(type, 'TwoLayerNet') == 1)
        [loss, grads, scores] = TwoLayerNet_loss(X_batch, y_batch, 0, params);
    elseif (strcmp(type, 'FullyConnectedNet') == 1)
        [loss, grads, scores] = FullyConnectedNet_loss(X_batch, y_batch, params, length(params)/2, 0); 
    elseif(strcmp(type, 'ThreeLayerConvNet') == 1)
        [loss, grads, scores] = ThreeLayerConvNet_loss(X_batch, y_batch, 0, params); 
    end 
        
    loss_history = [loss_history; loss];  

    % Perform a parameter update
    for p = 1:1:numel(params)
        if size(cell2mat(params(p))) ~= size(cell2mat(grads(p)))
            grads(p) = {transpose(cell2mat(grads(p)))}; 
        end 
        
        if(strcmp('sgd', update_rule) == 1)
            param_data = sgd(cell2mat(params(p)), cell2mat(grads(p)), learning_rate); 
            params(p) = {param_data}; 
        elseif (strcmp('SGD_Momentum', update_rule) == 1)
            [next_w, velocity, learning_rate, momentum] = SGD_Momentum(cell2mat(params(p)),  cell2mat(grads(p)), 0, learning_rate, 0)
            params(p) = {next_w}; 
        elseif (strcmp('rmsprop', update_rule) == 1) 
            [next_w, learning_rate, decay_rate, epsilon] = rmsprop(cell2mat(params(p)), cell2mat(grads(p)), learning_rate, 0, 0, 0.*cell2mat(params(p))); 
            params(p) = {next_w};
        elseif (strcmp('adam', update_rule) == 1) 
            [next_w, m, v, t] = adam(cell2mat(params(p)), cell2mat(grads(p)), learning_rate, 0, 0, 0, 0.*cell2mat(params(p)), 0.*cell2mat(params(p)), 0); 
            params(p) = {next_w};
        end 
        
    end
    
end 
