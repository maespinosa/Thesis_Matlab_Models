% Load the (preprocessed) CIFAR10 data.
disp('============LOADING CIFAR-10 DATA============')
%==========================================================================

[X_train,X_val,X_test,y_train,y_val,y_test] = get_CIFAR10_data(); 
% 
 X_train_dim = size(X_train);
 X_val_dim = size(X_val);
 X_test_dim = size(X_test);
 y_train_dim = size(y_train);
 y_val_dim = size(y_val);
 y_test_dim = size(y_test);
%==========================================================================


% Affine layer: foward
%==========================================================================
% Open the file cs231n/layers.py and implement the affine_forward function.
% Once you are done you can test your implementaion by running the 
% following:

% Test the affine_forward function
disp('============Testing Forward Pass of Affine Layer============')
difference = affine_layer_test()
%==========================================================================


% Affine layer: backward
%==========================================================================
% Now implement the `affine_backward` function and test your 
%  implementation using numeric gradient checking.
% 
% Test the affine_backward function
disp('============Testing Backward Pass of Affine Layer============')
[dx_error, dw_error, db_error] = affine_layer_backward_test()
%==========================================================================


%  ReLU layer: forward
%==========================================================================
%  Implement the forward pass for the ReLU activation function in the 
%  `relu_forward` function and test your implementation using the 
%  following:"

%  Test the relu_forward function,
disp('============Testing Forward Pass of Relu Layer============')
difference = relu_forward_test()
%==========================================================================


% ReLU layer: backward
%==========================================================================
% Now implement the backward pass for the ReLU activation function in the 
%  `relu_backward` function and test your implementation using numeric 
%  gradient checking:"
disp('============Testing Backward Pass of Relu Layer============')
dx_error = relu_backward_test()
%==========================================================================


% Sandwich layers
%==========================================================================
%There are some common patterns of layers that are frequently used in 
% neural nets. For example, affine layers are frequently followed by a 
% ReLU nonlinearity. To make these common patterns easy, we define 
% several convenience layers in the file `cs231n/layer_utils.py`.\n",

%For now take a look at the `affine_relu_forward` and 
% `affine_relu_backward` functions, and run the following to 
% numerically gradient check the backward pass:"
disp('============Executing Sandwich Layers============')
[dx_error, dw_error, db_error] = sandwich_layers()
%==========================================================================



% Two-layer network
%==========================================================================
%  In the previous assignment you implemented a two-layer neural network in
%  a single monolithic class. Now that you have implemented modular 
%  versions of the necessary layers, you will reimplement the two layer 
%  network using these modular implementations.

%  Open the file `cs231n/classifiers/fc_net.py` and complete the 
%  implementation of the `TwoLayerNet` class. This class will serve as a 
%  model for the other networks you will implement in this assignment, so 
%  read through it to make sure you understand the API. You can run the 
%  cell below to test your implementation.
disp('============Testing Two Layer Network============')
[dW1_error, db1_error, dW2_error, db2_error] = two_layer_network_solver();
%==========================================================================



% Two-Layer Network Training
%==========================================================================
% # TODO: Use a Solver instance to train a TwoLayerNet that achieves at 
%    least 50% accuracy on the validation set.                                        
disp('============Training Two Layer Network============')
TwoLayerNet_Trainer(X_train, y_train, X_val, y_val); 


% Initial loss and gradient check
%==========================================================================
% As a sanity check, run the following to check the initial loss and to 
%   gradient check the network both with and without regularization. 
%   Do the initial losses seem reasonable?

% For gradient checking, you should expect to see errors around 1e-6 or 
%   less.

disp('============Checking Gradients of Multilayer Network============')
[dW1_error, db1_error, dW2_error, db2_error, dW3_error, db3_error] = MultilayerNet_Init_Loss_Grad_Check()


% As another sanity check, make sure you can overfit a small dataset of 50 
% images. First we will try a three-layer network with 100 units in each 
% hidden layer. You will need to tweak the learning rate and initialization 
% scale, but you should be able to overfit and achieve 100% training 
% accuracy within 20 epochs.
disp('============Testing Three Layer Net with 50 images============')
[loss_history, train_acc_history, val_acc_history] = ThreeLayerNet_50_test(X_train, y_train, X_val, y_val);


% Now try to use a five-layer network with 100 units on each layer to overfit 
% 50 training examples. Again you will have to adjust the learning rate and 
% weight initialization, but you should be able to achieve 100% training 
% accuracy within 20 epochs.
disp('============Testing Five Layer Net with 50 images============')
[loss_history, train_acc_history, val_acc_history] = FiveLayerNet_50_test(X_train, y_train, X_val, y_val); 


%# Update rules
% So far we have used vanilla stochastic gradient descent (SGD) as our 
% update rule. More sophisticated update rules can make it easier to train 
% deep networks. We will implement a few of the most commonly used update 
% rules and compare them to vanilla SGD.

%# SGD+Momentum
% Stochastic gradient descent with momentum is a widely used update rule 
% that tends to make deep networks converge faster than vanilla stochstic 
% gradient descent.

% Open the file `cs231n/optim.py` and read the documentation at the top of 
% the file to make sure you understand the API. Implement the SGD+momentum 
% update rule in the function `sgd_momentum` and run the following to check 
% your implementation. You should see errors less than 1e-8.

%[next_w_error, velocity_error] = SGD_Momentum_test(X_train, y_train, X_val, y_val)


%# RMSProp and Adam
% RMSProp [1] and Adam [2] are update rules that set per-parameter learning 
% rates by using a running average of the second moments of gradients.

% In the file `cs231n/optim.py`, implement the RMSProp update rule in the 
% `rmsprop` function and implement the Adam update rule in the `adam` 
% function, and check your implementations using the tests below.

%[1] Tijmen Tieleman and Geoffrey Hinton. "Lecture 6.5-rmsprop: Divide the 
% gradient by a running average of its recent magnitude." COURSERA: Neural 
% Networks for Machine Learning 4 (2012).

%[2] Diederik Kingma and Jimmy Ba, "Adam: A Method for Stochastic 
% Optimization", ICLR 2015.
disp('============Testing RMSProp Update Rule============')
[next_w_error, cache_error] = RMSProp_test()
disp('============Testing Adam Update Rule============')
[next_w_error, v_error, m_error] = Adam_test()


% Once you have debugged your RMSProp and Adam implementations, run the 
% following to train a pair of deep networks using these new update rules:
disp('============Plotting results of Adam Update Rule============')
adam_rmsprop_plot(X_train, y_train, X_val, y_val)
