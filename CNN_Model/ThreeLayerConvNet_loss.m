function  [loss, grads, scores] = ThreeLayerConvNet_loss(X, y, reg, params)
%     """
%     Evaluate loss and gradient for the three-layer convolutional network.
%     
%     Input / output: Same API as TwoLayerNet in fc_net.py.
%     """
    disp('=====CALCULATING LOSS=====');
    tic
    y_dim = size(y);
    x_dim = size(X);
    
    W1 = cell2mat(params(1)); 
    b1 = cell2mat(params(2)); 
    W2 = cell2mat(params(3)); 
    b2 = cell2mat(params(4)); 
    W3 = cell2mat(params(5)); 
    b3 = cell2mat(params(6)); 

    W1_dim = size(W1); 
    
    % pass conv_param to the forward pass for the convolutional layer
    filter_size = W1_dim(3); 
    
    conv_stride = 1; 
    conv_pad = (filter_size - 1) / 2; 
    conv_param = {conv_pad,conv_stride}; 

    % pass pool_param to the forward pass for the max-pooling layer
    pool_height = 2; 
    pool_width = 2; 
    pool_stride = 2; 
    
    pool_param = {pool_height, pool_width, pool_stride}; 

%     ############################################################################
%     # TODO: Implement the forward pass for the three-layer convolutional net,  #
%     # computing the class scores for X and storing them in the scores          #
%     # variable.                                                                #
%     ############################################################################

	
	%conv - relu - 2x2 max pool - affine - relu - affine - softmax

    [Layer1_out, conv_cache, relu_x, pool_x, pool_param] = conv_relu_pool_forward(X, W1, b1, conv_param, pool_param); 
    %layer1_out_dim = size(Layer1_out);
    %layer1_out_temp = Layer1_out(1,1,:,:); 
	
    [Layer2_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(Layer1_out, W2, transpose(b2));
    [Layer3_out,fc_x, fc_w, fc_b,] = affine_forward(Layer2_out, transpose(W3), transpose(b3));
    scores = Layer3_out;
    %scores_dim = size(scores)
	  
%     ############################################################################
%     #                             END OF YOUR CODE                             #
%     ############################################################################
    
    loss = 0; 
    grads = []; 
%     ############################################################################
%     # TODO: Implement the backward pass for the three-layer convolutional net, #
%     # storing the loss and gradients in the loss and grads variables. Compute  #
%     # data loss using softmax, and make sure that grads[k] holds the gradients #
%     # for self.params[k]. Don't forget to add L2 regularization!               #
%     ############################################################################

	toc
    disp('=====CALCULATING GRADIENTS=====');
    
	%y;
    y_dim = size(y); 
	
    softmax_input = scores;
    %softmax_input_dim = size(softmax_input); 	
	
    softmax_input_trans = transpose(softmax_input); 
    softmax_input_trans_dim = size(softmax_input_trans);
	
    exp_scores = exp(softmax_input_trans) ;
    %exp_scores_dim = size(exp_scores) ;
	
    sum_exp_scores = sum(exp_scores, 1);
	
	
    P = zeros(softmax_input_trans_dim); 
    Py = zeros(y_dim(1)); 
    parfor i = 1:1:y_dim(1)
         P(:,i) = exp_scores(:,i) / sum_exp_scores(i); 
    end  
    
    %disp("Probabilities = ", P)
    parfor i = 1:1:y_dim(1)
         Py(i) = P(y(i,1)+1,i);   
    end 
    %Py;
	
    data_loss = -1*log(Py(:,1));
    
    avg_data_loss =  (1/softmax_input_trans_dim(2)) * sum(sum(data_loss));
	%avg_data_loss_dim = size(avg_data_loss);
    reg_loss = (reg*sum(sum(sum(sum(W2.^2)))) + reg*sum(sum(sum(sum(W1.^2)))) + reg*sum(sum(sum(sum(W3.^2)))))/2;
	%reg_loss_dim = size(reg_loss);
    loss = avg_data_loss + reg_loss;

	
    % compute the gradient on scores
    dscores = P; 
    %P;
    %P_dim = size(P); 
    
    for i = 1:1:y_dim(1)
         dscores(y(i,1)+1,i)  = dscores(y(i,1)+1,i) - 1.0; 
    end 
    %dscores;
    %dscores /= X.shape[0]
    dscores = dscores/x_dim(1); 
	
   
    [out,fc_x, fc_w, fc_b] = affine_forward(Layer2_out, transpose(W3), transpose(b3));
    [dx3, dW3, db3] = affine_backward(transpose(dscores), fc_x, transpose(fc_w), fc_b);
    
    
    [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(Layer1_out, W2, transpose(b2));
    [dx2,dW2,db2] = affine_relu_backward(dx3, fc_x, transpose(fc_w), fc_b, relu_x);
   
    
    [out, conv_cache, relu_x, pool_x, pool_param] = conv_relu_pool_forward(X, W1, b1, conv_param, pool_param);
    [dx1, dW1, db1] = conv_relu_pool_backward(dx2, conv_cache, conv_param, relu_x, pool_x, pool_param);
    
    
    dW3 = dW3 + reg.*W3; 
    dW2 = dW2 + reg.*W2; 
    dW1 = dW1 + reg.*W1; 
	
    grads = {dW1, db1, dW2, db2, dW3, db3};
    
end 
	
