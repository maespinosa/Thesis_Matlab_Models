function [dW1_rel_error, db1_rel_error, dW2_rel_error, db2_rel_error, dW3_rel_error, db3_rel_error] = gradient_check()
    num_inputs = 2; 
    input_dim = [3, 16, 16]; 
    reg = 0.0; 
    num_classes = 10; 
    num_filters = 3; 
    filter_size = 3; 
    hidden_dim = 7; 
    weight_scale = 1e-3; 
    h = 1e-6; 


    X = randn([num_inputs,input_dim]);
    %y = randint(num_classes, size=num_inputs)
    y = randi([0, 9], num_inputs,1);% randint(10, N); 

    params = ThreeLayerConvNet_init(input_dim, num_filters, filter_size, hidden_dim, num_classes, weight_scale);
    disp('=====FINDING LOSS AND GRADS FOR THREE LAYER CONVOLUTIONAL NETWORK=====')
    [loss, grads, scores] = ThreeLayerConvNet_loss(X, y, reg, params);

    dW1 = cell2mat(grads(1)); 
    db1 = cell2mat(grads(2)); 
    dW2 = cell2mat(grads(3)); 
    db2 = cell2mat(grads(4)); 
    dW3 = cell2mat(grads(5)); 
    db3 = cell2mat(grads(6)); 

    num_layers = 3; 
    disp('=====NUMERICALLY EVALUATING GRADS FOR THREE LAYER CONVOLUTIONAL NETWORK=====')
    grads = eval_numerical_gradient_params(X, y, h, params, reg, num_layers, 'ThreeLayerConvNet_loss'); 

    dW1_num = cell2mat(grads(1)); 
    db1_num = cell2mat(grads(2)); 
    dW2_num = cell2mat(grads(3)); 
    db2_num = cell2mat(grads(4)); 
    dW3_num = cell2mat(grads(5)); 
    db3_num = cell2mat(grads(6)); 


    dW1_rel_error = rel_error(dW1_num, dW1);
    db1_rel_error = rel_error(db1_num, db1);
    dW2_rel_error = rel_error(dW2_num, dW2);
    db2_rel_error = rel_error(db2_num, db2);
    dW3_rel_error = rel_error(dW3_num, dW3);
    db3_rel_error = rel_error(transpose(db3_num), db3);
end 

    