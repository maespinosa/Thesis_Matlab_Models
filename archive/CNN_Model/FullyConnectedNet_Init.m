function [params, num_layers] = FullyConnectedNet_Init(hidden_dims, input_dim, num_classes, dropout, use_batchnorm, reg, weight_scale)	
%   """
%   A fully-connected neural network with an arbitrary number of hidden layers,
%   ReLU nonlinearities, and a softmax loss function. This will also implement
%   dropout and batch normalization as options. For a network with L layers,
%   the architecture will be
%   
%   {affine - [batch norm] - relu - [dropout]} x (L - 1) - affine - softmax
%   
%   where batch normalization and dropout are optional, and the {...} block is
%   repeated L - 1 times.
% 	
%   Similar to the TwoLayerNet above, learnable parameters are stored in the
%   self.params dictionary and will be learned using the Solver class.
%   """

  if(input_dim == 0)
      input_dim = 3*32*32;
  end
  if (num_classes == 0)
      num_classes = 10 ;
  end 
  if (weight_scale == 0)
      weight_scale = 1e-2; 
  end 
  
               
%     """
%     Initialize a new FullyConnectedNet.
% 
%     
%     Inputs:
%     - hidden_dims: A list of integers giving the size of each hidden layer.
%     - input_dim: An integer giving the size of the input.
%     - num_classes: An integer giving the number of classes to classify.
%     - dropout: Scalar between 0 and 1 giving dropout strength. If dropout=0 then
%       the network should not use dropout at all.
%     - use_batchnorm: Whether or not the network should use batch normalization.
%     - reg: Scalar giving L2 regularization strength.
%     - weight_scale: Scalar giving the standard deviation for random
%       initialization of the weights.
%     - dtype: A numpy datatype object; all computations will be performed using
%       this datatype. float32 is faster but less accurate, so you should use
%       float64 for numeric gradient checking.
%     - seed: If not None, then pass this random seed to the dropout layers. This
%       will make the dropout layers deteriminstic so we can gradient check the
%       model.
%     """


    reg = reg;
    num_layers = 1 + length(hidden_dims);
    params = {};

%     ############################################################################
%     # TODO: Initialize the parameters of the network, storing all values in    #
%     # the self.params dictionary. Store weights and biases for the first layer #
%     # in W1 and b1; for the second layer use W2 and b2, etc. Weights should be #
%     # initialized from a normal distribution with standard deviation equal to  #
%     # weight_scale and biases should be initialized to zero.                   #
%     #                                                                          #
%     # When using batch normalization, store scale and shift parameters for the #
%     # first layer in gamma1 and beta1; for the second layer use gamma2 and     #
%     # beta2, etc. Scale parameters should be initialized to one and shift      #
%     # parameters should be initialized to zero.                                #
%     ############################################################################



    if num_layers == 2

        W1 = normrnd(0,weight_scale,input_dim,hidden_dims(1));
        W1_dim = size(W1);
        b1 = zeros(hidden_dims(1),1);  
        b1_dim = size(b1);
        W2 = normrnd(0,weight_scale,hidden_dims(1), num_classes);
        W2_dim = size(W2);
        b2 = zeros(num_classes,1);
        b2_dim = size(b2);
		
        params = {W1,b1,W2,b2};
		
    elseif num_layers == 3
        
        W1 = normrnd(0,weight_scale,input_dim,hidden_dims(1));
        W1_dim = size(W1);
        b1 = zeros(hidden_dims(1),1);  
        b1_dim = size(b1);
        
        W2 = normrnd(0,weight_scale,hidden_dims(1), hidden_dims(2));
        W2_dim = size(W2);
        b2 = zeros(hidden_dims(2),1);
        b2_dim = size(b2);
        
        W3 = normrnd(0,weight_scale,hidden_dims(2), num_classes);
        W3_dim = size(W3);
        b3 = zeros(num_classes,1);
        b3_dim = size(b3);
		
        params = {W1, b1, W2, b2, W3, b3};
		
    elseif num_layers == 4

        W1 = normrnd(0,weight_scale,input_dim,hidden_dims(1));
        W1_dim = size(W1);
        b1 = zeros(hidden_dims(1),1);  
        b1_dim = size(b1);
        
        W2 = normrnd(0,weight_scale,hidden_dims(1), hidden_dims(2));
        W2_dim = size(W2);
        b2 = zeros(hidden_dims(2),1);
        b2_dim = size(b2);
        
        W3 = normrnd(0,weight_scale,hidden_dims(2),hidden_dims(3));
        W3_dim = size(W3);
        b3 = zeros(hidden_dims(3),1);
        b3_dim = size(b3);
        
        W4 = normrnd(0,weight_scale,hidden_dims(3), num_classes);
        W4_dim = size(W4);
        b4 = zeros(num_classes,1);
        b4_dim = size(b4);
		
        params = {W1, b1, W2, b2, W3, b3, W4, b4};
		
    elseif num_layers == 5
        
        W1 = normrnd(0,weight_scale,input_dim,hidden_dims(1));
        W1_dim = size(W1);
        b1 = zeros(hidden_dims(1),1);  
        b1_dim = size(b1);
        
        W2 = normrnd(0,weight_scale,hidden_dims(1), hidden_dims(2));
        W2_dim = size(W2);
        b2 = zeros(hidden_dims(2),1);
        b2_dim = size(b2);
        
        W3 = normrnd(0,weight_scale,hidden_dims(2),hidden_dims(3));
        W3_dim = size(W3);
        b3 = zeros(hidden_dims(3),1);
        b3_dim = size(b3);
        
        W4 = normrnd(0,weight_scale,hidden_dims(3), hidden_dims(4));
        W4_dim = size(W4);
        b4 = zeros(hidden_dims(4),1);
        b4_dim = size(b4);
        
        W5 = normrnd(0,weight_scale,hidden_dims(4), num_classes);
        W5_dim = size(W5);
        b5 = zeros(num_classes,1);
        b5_dim = size(b5);
        
		
        params = {W1, b1, W2, b2, W3, b3, W4, b4, W5, b5};
		
    elseif num_layers == 6

        W1 = normrnd(0,weight_scale,input_dim,hidden_dims(1));
        W1_dim = size(W1);
        b1 = zeros(hidden_dims(1),1);  
        b1_dim = size(b1);
        
        W2 = normrnd(0,weight_scale,hidden_dims(1), hidden_dims(2));
        W2_dim = size(W2);
        b2 = zeros(hidden_dims(2),1);
        b2_dim = size(b2);
        
        W3 = normrnd(0,weight_scale,hidden_dims(2),hidden_dims(3));
        W3_dim = size(W3);
        b3 = zeros(hidden_dims(3),1);
        b3_dim = size(b3);
        
        W4 = normrnd(0,weight_scale,hidden_dims(3), hidden_dims(4));
        W4_dim = size(W4);
        b4 = zeros(hidden_dims(4),1);
        b4_dim = size(b4);
        
        W5 = normrnd(0,weight_scale,hidden_dims(4), hidden_dims(5));
        W5_dim = size(W5);
        b5 = zeros(hidden_dims(5),1);
        b5_dim = size(b5);
        
        W6 = normrnd(0,weight_scale,hidden_dims(5), num_classes);
        W6_dim = size(W6);
        b6 = zeros(num_classes,1);
        b6_dim = size(b6);
		
        params = {W1, b1, W2, b2, W3, b3, W4, b4, W5, b5, W6, b6}; 

    end 
end 
      
      
      
      
