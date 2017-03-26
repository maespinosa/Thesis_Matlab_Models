function [W1,b1,W2,b2] = TwoLayerNet_init(input_dim, hidden_dim, num_classes, weight_scale)
%   """
%   A two-layer fully-connected neural network with ReLU nonlinearity and
%   softmax loss that uses a modular layer design. We assume an input dimension
%   of D, a hidden dimension of H, and perform classification over C classes.
%   
%   The architecure should be affine - relu - affine - softmax.
% 
%   Note that this class does not implement gradient descent; instead, it
%   will interact with a separate Solver object that is responsible for running
%   optimization.
% 
%   The learnable parameters of the model are stored in the dictionary
%   self.params that maps parameter names to numpy arrays.
%   """
  
%   def __init__(self, input_dim=3*32*32, hidden_dim=100, num_classes=10,
%                weight_scale=1e-3, reg=0.0):
%     """
%     Initialize a new network.
% 
%     Inputs:
%     - input_dim: An integer giving the size of the input
%     - hidden_dim: An integer giving the size of the hidden layer
%     - num_classes: An integer giving the number of classes to classify
%     - dropout: Scalar between 0 and 1 giving dropout strength.
%     - weight_scale: Scalar giving the standard deviation for random
%       initialization of the weights.
%     - reg: Scalar giving L2 regularization strength.
%     """
%     
%     ############################################################################
%     # TODO: Initialize the weights and biases of the two-layer net. Weights    #
%     # should be initialized from a Gaussian with standard deviation equal to   #
%     # weight_scale, and biases should be initialized to zero. All weights and  #
%     # biases should be stored in the dictionary self.params, with first layer  #
%     # weights and biases using the keys 'W1' and 'b1' and second layer weights #
%     # and biases using the keys 'W2' and 'b2'.                                 #
%     ############################################################################
	%disp('TWOLAYERNET_INIT EXECUTING'); 
    W1 = normrnd(0,weight_scale,input_dim,hidden_dim);
    %W1 = reshape(W1,hidden_dim,input_dim);
    W1_dim = size(W1);
    b1 = zeros(hidden_dim,1);  
    b1_dim = size(b1);
    W2 = normrnd(0,weight_scale,hidden_dim, num_classes);
    W2_dim = size(W2);
    %W2 = reshape(W2,num_classes, hidden_dim);
    b2 = zeros(num_classes,1);
    b2_dim = size(b2);
end 
	
	


