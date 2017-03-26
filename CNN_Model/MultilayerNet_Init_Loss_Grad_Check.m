function [dW1_error, db1_error, dW2_error, db2_error, dW3_error, db3_error] = MultilayerNet_Init_Loss_Grad_Check()

% Initial loss and gradient check

% As a sanity check, run the following to check the initial loss and to 
%   gradient check the network both with and without regularization. 
%   Do the initial losses seem reasonable?

% For gradient checking, you should expect to see errors around 1e-6 or 
%   less.

    disp('EXECUTING MULTILAYER NETWORK INTIAL LOSS AND GRADIENT CHECK'); 
    disp('===================================================================')

    N = 2; 
    D = 15; 
    H1 = 20; 
    H2 = 30; 
    C = 10;

    X = randn(N, D);
    %y = np.random.randint(C, size=(N,))
    X_dim = size(X); 
    y = randi(C, N);
    y_dim = size(y);
    h = 1e-5; 

    regs = [0, 3.14]; 

    for i = 1:1:length(regs)
      disp('Running numeric gradient check with reg = ')
      reg = regs(i);
      [params, num_layers] = FullyConnectedNet_Init([H1, H2], D, C, 0, 0, reg, 5e-2)

      [loss, grads, scores] = FullyConnectedNet_loss(X, y, params, num_layers, reg); 
      disp('Initial loss: ')
      loss

      grad_num = eval_numerical_gradient_params(X,y,h,params,reg, num_layers)


      dW1 = cell2mat(grads(1)); db1 = cell2mat(grads(2));
      dW2 = cell2mat(grads(3)); db2 = cell2mat(grads(4)); 
      dW3 = cell2mat(grads(5)); db3 = cell2mat(grads(6)); 
      
      db3_dim = size(db3)
      
      dW1_num = cell2mat(grad_num(1)); db1_num = cell2mat(grad_num(2));
      dW2_num = cell2mat(grad_num(3)); db2_num = cell2mat(grad_num(4)); 
      dW3_num = cell2mat(grad_num(5)); db3_num = cell2mat(grad_num(6)); 
      
      db3_num_dim = size(db3_num)
      
      dW1_error = rel_error(dW1_num, dW1);
      db1_error = rel_error(db1_num, db1);
      dW2_error = rel_error(dW2_num, dW2);
      db2_error = rel_error(db2_num, db2);
      dW3_error = rel_error(dW3_num, dW3);
      db3_error = rel_error(transpose(db3_num), db3);
    end
    %MRN: 000025037658 GRP: 102930-0 
end 