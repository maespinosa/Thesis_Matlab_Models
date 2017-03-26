function [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(X, y, reg, W1, b1, W2, b2)
%     """
%     Compute loss and gradient for a minibatch of data.
% 
%     Inputs:
%     - X: Array of input data of shape (N, d_1, ..., d_k)
%     - y: Array of labels, of shape (N,). y[i] gives the label for X[i].
% 
%     Returns:
%     If y is None, then run a test-time forward pass of the model and return:
%     - scores: Array of shape (N, C) giving classification scores, where
%       scores[i, c] is the classification score for X[i] and class c.
% 
%     If y is not None, then run a training-time forward and backward pass and
%     return a tuple of:
%     - loss: Scalar value giving the loss
%     - grads: Dictionary with the same keys as self.params, mapping parameter
%       names to gradients of the loss with respect to those parameters.
%     """  

%     ############################################################################
%     # TODO: Implement the forward pass for the two-layer net, computing the    #
%     # class scores for X and storing them in the scores variable.              #
%     ############################################################################
 

	x_dim = size(X);
    x_dim_loss = x_dim;
    W1_dim_loss = size(W1);
    b1_dim_loss = size(b1);
    W2_dim_loss = size(W2);
    b2_dim_loss = size(b2);
    
    [HL1_out, fc_x, fc_w, fc_b] = affine_forward(X, transpose(W1), b1); 
	HL1_out;
    HL1_out_dim = size(HL1_out);
    [RELU1_out, relu_x] = relu_forward(HL1_out); 
	
    [HL2_out, fc_x, fc_w, fc_b] = affine_forward(RELU1_out, transpose(W2), b2); 
	
    scores = HL2_out; 
    scores_dim = size(scores);
    
    loss = 0; 
    grads = []; 
%     ############################################################################
%     # TODO: Implement the backward pass for the two-layer net. Store the loss  #
%     # in the loss variable and gradients in the grads dictionary. Compute data #
%     # loss using softmax, and make sure that grads[k] holds the gradients for  #
%     # self.params[k]. Don't forget to add L2 regularization!                   #
%     #                                                                          #
%     # NOTE: To ensure that your implementation matches ours and you pass the   #
%     # automated tests, make sure that your L2 regularization includes a factor #
%     # of 0.5 to simplify the expression for the gradient.                      #
%     ############################################################################
    y;
    y_dim = size(y);
	
    softmax_input = scores;
    softmax_input_dim = size(softmax_input);
	
    softmax_input_trans = transpose(softmax_input);
    softmax_input_trans_dim = size(softmax_input_trans); 
	
    exp_scores = exp(softmax_input_trans);
    exp_scores_dim = size(exp_scores);
	
    sum_exp_scores = sum(exp_scores, 1); 
		
    P = zeros(softmax_input_trans_dim); 
    Py = zeros(y_dim); 
    
    for i = 1:1:y_dim(1)
         P(:,i) = exp_scores(:,i) / sum_exp_scores(i); 
    end 
    
    %disp("Probabilities = ", P)
    for i = 1:1:y_dim(1)
         Py(i) = P(y(i,1),i);   
    end 
    Py; 	
	
    data_loss = -1*log(Py(:,1)); 
    data_loss;
    reg; 
	
    avg_data_loss =  (1/softmax_input_trans_dim(2)) * sum(data_loss);
	
    reg_loss = (reg*sum(sum(W2.^2)) + reg*sum(sum(W1.^2)))/2; 
	
    loss = avg_data_loss + reg_loss; 
	
    % compute the gradient on scores
    dscores = P; 
    P;
    P_dim = size(P); 
    
    for i = 1:1:y_dim(1)
         dscores(y(i,1),i)  = dscores(y(i,1),i) - 1.0; 
    end 
    dscores;
    %dscores /= X.shape[0]
    dscores = dscores/x_dim(1); 
	
	
    [out, fc_x, fc_w, fc_b] = affine_forward(RELU1_out, transpose(W2), b2); 
    [dX_H2, dW2, db2] = affine_backward(transpose(dscores), fc_x, transpose(fc_w), fc_b);
	
    [out, relu_x] = relu_forward(HL1_out); 
    dX_RELU = relu_backward(dX_H2, relu_x); 

    [out, fc_x, fc_w, fc_b] = affine_forward(X, transpose(W1), b1); 
    [dX_H1, dW1, db1] = affine_backward(dX_RELU, fc_x, transpose(fc_w), fc_b); 
	
    dW2_dim = size(dW2); 
    W2_dim = size(W2);
    
    dW2 = dW2 + reg.*W2;
    dW1 = dW1 + reg.*W1;
    

end 


				