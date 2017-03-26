function acc = Solver_check_accuracy(X, y, num_samples, batch_size, W1, b1, W2, b2)

%     """
%     Check accuracy of the model on the provided data.
%     
%     Inputs:
%     - X: Array of data, of shape (N, d_1, ..., d_k)
%     - y: Array of labels, of shape (N,)
%     - num_samples: If not None, subsample the data and only test the model
%       on num_samples datapoints.
%     - batch_size: Split X and y into batches of this size to avoid using too
%       much memory.
%       
%     Returns:
%     - acc: Scalar giving the fraction of instances that were correctly
%       classified by the model.
%     """

    %disp('SOLVER_CHECK_ACCURACY EXECUTING'); 
    X_dim = size(X); 
    
    y; 


    if (batch_size == 0.0) batch_size = 100; 
    else batch_size = batch_size;
    end 
    
    
    % Maybe subsample the data
    N = X_dim(1); 
    if (num_samples ~= 0) && (N > num_samples)
      mask = datasample(1:N,num_samples, 1)
      N = num_samples; 
      X = X(mask); 
      y = y(mask); 
    end

    % Compute predictions in batches
    num_batches = N / batch_size; 
    if (mod(N, batch_size) ~= 0) 
      num_batches = num_batches + 1;
    end 
    y_pred = []; 
    for i = 1:1:num_batches 
      i; 
      start = (i * batch_size) - (batch_size - 1);
      end_value = (i) * batch_size;
      X_dim = size(X);

      [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(X(start:end_value,:,:,:), y(start:end_value,:), 0, W1, b1, W2, b2); 
      [max_value, max_index] = max(scores,[],2);
      max_value; 
      y_pred = [y_pred;max_index];
    end 
    y_pred; 
    y_pred_dim = size(y_pred);
    y_mask = zeros(y_pred_dim); 
    y_mask(y_pred == y) = 1;
    
    y_mask_dim = size(y_mask);
    y_mask_n = sum(y_mask); 
    y_pred = y_mask.*y_pred; 
    acc = sum(y_pred)/ y_mask_n; 
end 
    
