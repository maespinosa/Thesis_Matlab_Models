function difference = affine_layer_test()

    % Affine layer: foward
    % 
    % Open the file cs231n/layers.py and implement the affine_forward function.
    % Once you are done you can test your implementaion by running the following:

    % Test the affine_forward function

    disp('EXECUTING AFFINE LAYER FORWARD TEST')
    disp('===================================================================')
    num_inputs = 2; 
    input_shape = [4, 5, 6]; 
    output_dim = 3;

    input_size = num_inputs * prod(input_shape);
    weight_size = output_dim * prod(input_shape);

    x = linspace(-0.1, 0.5, input_size);
    x = reshape(x, [num_inputs, input_shape]);

    w = linspace(-0.2, 0.3,weight_size);
    %w = reshape(w, [prod(input_shape), output_dim]);
    w = reshape(w, [output_dim, prod(input_shape)]);

    b = linspace(-0.3, 0.1, output_dim);

    [out,cache] = affine_forward(x, w, b);
    correct_out = [1.49834967,  1.70660132,  1.91485297;
                   3.25553199,  3.5141327,   3.77273342];

    % Compare your output with ours. The error should be around 1e-9.
    disp('Testing affine_forward function:');
    difference = rel_error(out, correct_out);
end 
