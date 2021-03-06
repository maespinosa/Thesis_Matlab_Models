% Load the (preprocessed) CIFAR10 data.
%==========================================================================
disp('============LOADING CIFAR-10 DATA============')
[X_train,X_val,X_test,y_train,y_val,y_test] = get_CIFAR10_data(); 
% 
 X_train_dim = size(X_train);
 X_val_dim = size(X_val);
 X_test_dim = size(X_test);
 y_train_dim = size(y_train);
 y_val_dim = size(y_val);
 y_test_dim = size(y_test);
%==========================================================================

% Convolution: Naive forward pass
%  The core of a convolutional network is the convolution operation. In the 
%  file `cs231n/layers.py`, implement the forward pass for the convolution 
%  layer in the function `conv_forward_naive`. 

% You don't have to worry too much about efficiency at this point; just 
% write the code in whatever way you find most clear.

% You can test your implementation by running the following:
disp('============Testing Forward Pass of Convolutional Layer============')
difference = Conv_Naive_Forward_test()


% Convolution: Naive backward pass
%  Implement the backward pass for the convolution operation in the 
%  function `conv_backward_naive` in the file `cs231n/layers.py`. Again, 
%  you don't need to worry too much about computational efficiency.

% When you are done, run the following to check your backward pass with a 
% numeric gradient check.
disp('============Testing Backward Pass of Convolutional Layer============')
[dx_error, dw_error, db_error] = Conv_Naive_Backward_test()

%Max pooling: Naive forward
% Implement the forward pass for the max-pooling operation in the function 
%  `max_pool_forward_naive` in the file `cs231n/layers.py`. Again, don't 
%  worry too much about computational efficiency.

% Check your implementation by running the following:
disp('============Testing Foward Pass of Max Pooling Layer============')
difference = max_pooling_test()

%Max pooling: Naive backward
% Implement the backward pass for the max-pooling operation in the function 
% `max_pool_backward_naive` in the file `cs231n/layers.py`. You don't need 
% to worry about computational efficiency.
 
% Check your implementation with numeric gradient checking by running the 
% following:
disp('============Testing Backward Pass of Max Pooling Layer============')
dx_error = max_pool_backward_test()

%Convolutional "sandwich" layers
% Previously we introduced the concept of "sandwich" layers that combine 
% multiple operations into commonly used patterns. In the file 
% `cs231n/layer_utils.py` you will find sandwich layers that implement a 
% few commonly used patterns for convolutional networks.
disp('============Executing Convolutional Sandwich Layers============')
[dx_error, dw_error, db_error] = convolutional_sandwich_layers()


% Three-layer ConvNet
%  Now that you have implemented all the necessary layers, we can put them 
%  together into a simple convolutional network.

% Open the file `cs231n/cnn.py` and complete the implementation of the 
%  `ThreeLayerConvNet` class. Run the following cells to help you debug:

% Sanity check loss
%  After you build a new network, one of the first things you should do is 
%  sanity check the loss. When we use the softmax loss, we expect the loss 
%  for random weights (and no regularization) to be about `log(C)` for `C` 
%  classes. When we add regularization this should go up.
disp('============Sanity Checking Loss============')
sanity_check_loss()

% Gradient check
%  After the loss looks reasonable, use numeric gradient checking to make 
%  sure that your backward pass is correct. When you use numeric gradient 
%  checking you should use a small amount of artifical data and a small 
%  number of neurons at each layer.
disp('============Checking Gradients============') 
[dW1_rel_error, db1_rel_error, dW2_rel_error, db2_rel_error, dW3_rel_error, db3_rel_error] = gradient_check()

% Overfit small data
%  A nice trick is to train your model with just a few training samples. 
%  You should be able to overfit small datasets, which will result in very 
%  high training accuracy and comparatively low validation accuracy.
disp('============Overfitting Small Data============')
[loss_history, train_acc_history, val_acc_history] = overfit_small_data(X_train, y_train, X_val, y_val)