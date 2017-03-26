function [out,x] = relu_forward(x)

    % Computes the forward pass for a layer of rectified linear units (ReLUs).
    % 
    % Input:
    % - x: Inputs, of any shape
    % 
    % Returns a tuple of:
    % - out: Output, of the same shape as x
    % - cache: x
    
    %x_dim_relu_forward = size(x)
    out = x; 
    out(out <= 0) = 0; 
    
    %out_relu_forward_dim = size(out)
end 