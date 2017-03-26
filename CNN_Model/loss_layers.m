function [loss, dx_error] = loss_layers()
    % Loss layers: Softmax and SVM
    % You implemented these loss functions in the last assignment, so we'll 
    % give them to you for free here. You should still make sure you 
    % understand how they work by looking at the implementations in 
    % `cs231n/layers.py`.\n",
    
    % You can make sure that the implementations are correct by running the
    % following:"
   
    num_classes= 10;
    num_inputs = 50; 
    x = 0.001 * randn(num_inputs, num_classes); 
    y = int32(10*(randn(num_inputs,1) + 1)); 
    y(y <= 0) = 11; 
    y(y == 10) = 11;
    y(y < 10) = 15;
    y = y - 10; 
    y(y > 10) = 10;
    
    dx_num = eval_numerical_gradient(lambda x: svm_loss(x, y)[0], x, verbose=False)
    [loss, dx] = svm_loss(x, y); 
    
    % Test svm_loss function. Loss should be around 9 and dx error should be 1e-9
    disp('Testing svm_loss:')
    loss; 
    dx_error = rel_error(dx_num, dx); 
    
    dx_num = eval_numerical_gradient(lambda x: softmax_loss(x, y)[0], x, verbose=False)
    [loss, dx] = softmax_loss(x, y)
    
    % Test softmax_loss function. Loss should be 2.3 and dx error should be 1e-8
    disp('Testing softmax_loss:')
    loss; 
    dx_error = rel_error(dx_num, dx); 
end 
