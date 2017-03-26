function params = ThreeLayerConvNet_init(input_dim, num_filters, filter_size, hidden_dim, num_classes, weight_scale)
%   """
%   A three-layer convolutional network with the following architecture:
%   
%   conv - relu - 2x2 max pool - affine - relu - affine - softmax
%   
%   The network operates on minibatches of data that have shape (N, C, H, W)
%   consisting of N images, each with height H and width W and with C input
%   channels.
%   """
  
%   def __init__(self, input_dim=(3, 32, 32), num_filters=32, filter_size=7,
%                hidden_dim=100, num_classes=10, weight_scale=1e-3, reg=0.0,
%                dtype=np.float32):
               
%     """
%     Initialize a new network.
%     
%     Inputs:
%     - input_dim: Tuple (C, H, W) giving size of input data
%     - num_filters: Number of filters to use in the convolutional layer
%     - filter_size: Size of filters to use in the convolutional layer
%     - hidden_dim: Number of units to use in the fully-connected hidden layer
%     - num_classes: Number of scores to produce from the final affine layer.
%     - weight_scale: Scalar giving standard deviation for random initialization
%       of weights.
%     - reg: Scalar giving L2 regularization strength
%     - dtype: numpy datatype to use for computation.
%     """
    
%     ############################################################################
%     # TODO: Initialize weights and biases for the three-layer convolutional    #
%     # network. Weights should be initialized from a Gaussian with standard     #
%     # deviation equal to weight_scale; biases should be initialized to zero.   #
%     # All weights and biases should be stored in the dictionary self.params.   #
%     # Store weights and biases for the convolutional layer using the keys 'W1' #
%     # and 'b1'; use keys 'W2' and 'b2' for the weights and biases of the       #
%     # hidden affine layer, and keys 'W3' and 'b3' for the weights and biases   #
%     # of the output affine layer.                                              #
%     ############################################################################

	disp('=====INITIALIZING THREE LAYER CONVOLUTIONAL NETWORK=====');

    W1 = normrnd(0,weight_scale,num_filters, 3, filter_size, filter_size); 
    %W1_dim = size(W1);
    
    b1 = zeros(num_filters,1); 
    %b1_dim = size(b1);
   
    W2 = normrnd(0,weight_scale,(input_dim(2)/2)*(input_dim(2)/2)*num_filters, hidden_dim);
    %W2_dim = size(W2);
    b2 = zeros(hidden_dim,1); 
    %b2_dim = size(b2);

    
    W3 = normrnd(0,weight_scale,hidden_dim, num_classes);
    %W3_dim = size(W3);
    b3 = zeros(num_classes,1); 	
    %b3_dim = size(b3);
	
    params = {W1, b1, W2, b2, W3, b3}; 
end 
