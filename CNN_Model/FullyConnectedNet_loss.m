function [loss, grads, scores] = FullyConnectedNet_loss(X, y, params, num_layers, reg)
%     """
%     Compute loss and gradient for the fully-connected net.
% 
%     Input / output: Same as TwoLayerNet above.
%     """

%     ############################################################################
%     # TODO: Implement the forward pass for the fully-connected net, computing  #
%     # the class scores for X and storing them in the scores variable.          #
%     #                                                                          #
%     # When using dropout, you'll need to pass self.dropout_param to each       #
%     # dropout forward pass.                                                    #
%     #                                                                          #
%     # When using batch normalization, you'll need to pass self.bn_params[0] to #
%     # the forward pass for the first batch normalization layer, pass           #
%     # self.bn_params[1] to the forward pass for the second batch normalization #
%     # layer, etc.                                                              #
%     ############################################################################

	x_dim = size(X);
    x_dim_loss = x_dim;
    W1_dim_loss = size(cell2mat(params(1)));
    b1_dim_loss = size(cell2mat(params(2)));
    W2_dim_loss = size(cell2mat(params(3)));
    b2_dim_loss = size(cell2mat(params(4)));
    
    if num_layers == 2 
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        [HL1_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [HL2_out, fc_x, fc_w, fc_b] = affine_forward(HL1_out, transpose(W2), transpose(b2));
        scores = HL2_out;

        
    elseif num_layers == 3 
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        [HL1_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [HL2_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [HL3_out, fc_x, fc_w, fc_b] = affine_forward(HL2_out, transpose(W3), transpose(b3));
        scores = HL3_out;

        
    elseif num_layers == 4 
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        W4 = cell2mat(params(7));
        b4 = cell2mat(params(8));
        [HL1_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [HL2_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [HL3_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL2_out, W3, transpose(b3));
        [HL4_out, fc_x, fc_w, fc_b] = affine_forward(HL3_out, transpose(W4), transpose(b4));
        scores = HL4_out;

        
    elseif num_layers == 5
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        W4 = cell2mat(params(7));
        b4 = cell2mat(params(8));
        W5 = cell2mat(params(9));
        b5 = cell2mat(params(10));
        [HL1_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [HL2_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [HL3_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL2_out, W3, transpose(b3));
        [HL4_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL3_out, W4, transpose(b4));
        [HL5_out, fc_x, fc_w, fc_b] = affine_forward(HL4_out, transpose(W5), transpose(b5));
        scores = HL5_out;

        
    elseif num_layers == 6 
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        W4 = cell2mat(params(7));
        b4 = cell2mat(params(8));
        W5 = cell2mat(params(9));
        b5 = cell2mat(params(10));
        W6 = cell2mat(params(11));
        b6 = cell2mat(params(12));
        [HL1_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [HL2_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [HL3_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL2_out, W3, transpose(b3));
        [HL4_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL3_out, W4, transpose(b4));
        [HL5_out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL4_out, W5, transpose(b5));
        [HL6_out, fc_x, fc_w, fc_b] = affine_forward(HL5_out, transpose(W6), transpose(b6));
        scores = HL6_out;

    end 

%     ############################################################################
%     #                             END OF YOUR CODE                             #
%     ############################################################################

%     # If test mode return early

%     ############################################################################
%     # TODO: Implement the backward pass for the fully-connected net. Store the #
%     # loss in the loss variable and gradients in the grads dictionary. Compute #
%     # data loss using softmax, and make sure that grads[k] holds the gradients #
%     # for self.params[k]. Don't forget to add L2 regularization!               #
%     #                                                                          #
%     # When using batch normalization, you don't need to regularize the scale   #
%     # and shift parameters.                                                    #
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
	
    data_loss = -1*log(Py); 
    data_loss;
    reg; 
	
    avg_data_loss =  (1/softmax_input_trans_dim(2)) * sum(data_loss);
	
    if num_layers == 2
        reg_loss = 0.5*reg*(sum(sum(W1.^2)) + sum(sum(W2.^2)));
    elseif num_layers == 3 
        reg_loss = 0.5*reg*(sum(sum(W1.^2)) + sum(sum(W2.^2)) + sum(sum(W3.^2)));
    elseif num_layers == 4 
        reg_loss = 0.5*reg*(sum(sum(W1.^2)) + sum(sum(W2.^2)) + sum(sum(W3.^2)) + sum(sum(W4.^2)));
    elseif num_layers == 5 
        reg_loss = 0.5*reg*(sum(sum(W1.^2)) + sum(sum(W2.^2)) + sum(sum(W3.^2)) + sum(sum(W4.^2)) + sum(sum(W5.^2)));
    elseif num_layers == 6 
        reg_loss = 0.5*reg*(sum(sum(W1.^2)) + sum(sum(W2.^2)) + sum(sum(W3.^2)) + sum(sum(W4.^2)) + sum(sum(W5.^2)) + sum(sum(W6.^2)));
    end 
	
    loss = avg_data_loss + reg_loss;
	
    % compute the gradient on scores
    dscores = P;
    P;
    P_dim = size(P);
    
    for i = 1:1:y_dim(1)
         dscores(y(i),i) = dscores(y(i),i) - 1.0; 
    end 
    
    dscores = dscores / x_dim(1);
	
    if num_layers == 2
	
        [out,fc_x, fc_w, fc_b] = affine_forward(HL1_out, W2, b2);
        [dx2,dW2,db2] = affine_backward(transpose(dscores), fc_x, fc_w, fc_b);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X,W1,b1);
        [dx1,dW1,db1] = affine_relu_backward(dx2, fc_x, fc_w, fc_b, relu_x);
		
        dW2 = dW2 + reg.*W2;
        dW1 = dW1 + reg.*W1;
	
        grads = {dW1, db1, dW2, db2};

    elseif num_layers == 3
	
        [out,fc_x, fc_w, fc_b] = affine_forward(HL2_out, transpose(W3), transpose(b3));
        [dx3,dW3,db3] = affine_backward(transpose(dscores), fc_x, transpose(fc_w), fc_b);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [dx2,dW2,db2] = affine_relu_backward(dx3, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [dx1,dW1,db1] = affine_relu_backward(dx2, fc_x, transpose(fc_w), fc_b, relu_x);
		
        dW3 = dW3 + reg.*W3;
        dW2 = dW2 + reg.*W2;
        dW1 = dW1 + reg.*W1;
	
        grads = {dW1, db1, dW2, db2, dW3, db3};
		
    elseif num_layers == 4

        [out, fc_x, fc_w, fc_b] = affine_forward(HL3_out, transpose(W4), transpose(b4));
        [dx4,dW4,db4] = affine_backward(transpose(dscores), fc_x, transpose(fc_w), fc_b);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL2_out, W3, transpose(b3));
        [dx3,dW3,db3] = affine_relu_backward(dx4, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [dx2,dW2,db2] = affine_relu_backward(dx3, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [dx1,dW1,db1] = affine_relu_backward(dx2, fc_x, transpose(fc_w), fc_b, relu_x);
        
        dW4 = dW4 + reg.*W4;
        dW3 = dW3 + reg.*W3;
        dW2 = dW2 + reg.*W2;
        dW1 = dW1 + reg.*W1;
	
        grads = {dW1, db1, dW2, db2, dW3, db3, dW4, db4};
		
		
    elseif num_layers == 5

        [out, fc_x, fc_w, fc_b] = affine_forward(HL4_out, transpose(W5), transpose(b5));
        [dx5,dW5,db5] = affine_backward(transpose(dscores), fc_x, transpose(fc_w), fc_b);

        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL3_out, W4, transpose(b4));
        [dx4,dW4,db4] = affine_relu_backward(dx5, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL2_out, W3, transpose(b3));
        [dx3,dW3,db3] = affine_relu_backward(dx4, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [dx2,dW2,db2] = affine_relu_backward(dx3, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [dx1,dW1,db1] = affine_relu_backward(dx2, fc_x, transpose(fc_w), fc_b, relu_x);
		
        dW5 = dW5 + reg.*W5;
        dW4 = dW4 + reg.*W4;
        dW3 = dW3 + reg.*W3;
        dW2 = dW2 + reg.*W2;
        dW1 = dW1 + reg.*W1;
	
        grads = {dW1, db1, dW2, db2, dW3, db3, dW4, db4, dW5, db5};
		
		
    elseif num_layers == 6

        [out, fc_x, fc_w, fc_b] = affine_forward(HL5_out, transpose(W6), transpose(b6));
        [dx6,dW6,db6] = affine_backward(transpose(dscores), fc_x, transpose(fc_w), fc_b);

        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL4_out, W5, transpose(b5));
        [dx5,dW5,db5] = affine_relu_backward(dx6, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL3_out, W4, transpose(b4));
        [dx4,dW4,db4] = affine_relu_backward(dx5, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL2_out, W3, transpose(b3));
        [dx3,dW3,db3] = affine_relu_backward(dx4, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(HL1_out, W2, transpose(b2));
        [dx2,dW2,db2] = affine_relu_backward(dx3, fc_x, transpose(fc_w), fc_b, relu_x);
		
        [out, fc_x, fc_w, fc_b, relu_x] = affine_relu_forward(X, W1, transpose(b1));
        [dx1,dW1,db1] = affine_relu_backward(dx2, fc_x, transpose(fc_w), fc_b, relu_x);
		
        dW6 = dW6 + reg.*W6;
        dW5 = dW5 + reg.*W5;
        dW4 = dW4 + reg.*W4;
        dW3 = dW3 + reg.*W3;
        dW2 = dW2 + reg.*W2;
        dW1 = dW1 + reg.*W1;
	
        grads = {dW1, db1, dW2, db2, dW3, db3, dW4, db4, dW5, db5, dW6, db6};
    end 
end

