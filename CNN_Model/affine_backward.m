function [dx, dw, db] = affine_backward(dout, x, w, b)

    % Computes the backward pass for an affine layer.
    % 
    % Inputs:
    % - dout: Upstream derivative, of shape (N, M)
    % - cache: Tuple of:
    % - x: Input data, of shape (N, d_1, ... d_k)
    % - w: Weights, of shape (D, M)
    % 
    % Returns a tuple of:
    % - dx: Gradient with respect to x, of shape (N, d1, ..., d_k)
    % - dw: Gradient with respect to w, of shape (D, M)
    % - db: Gradient with respect to b, of shape (M,)

    %dx = [];
    %dw = []; 
    %db = [];

    %dout_dim = size(dout); 
    x_dim = size(x);  
    %b_dim = size(b);  

    %x_length = length(x);
    %if(x_length > 1) 
    D = prod(x_dim(2:end));

    x_reshaped = reshape(x,D, x_dim(1));
    x_reshaped = transpose(x_reshaped);
    %x_reshaped_dim = size(x_reshaped);

    xr_transposed = transpose(x_reshaped);
    %xr_transposed_dim = size(xr_transposed); 

    w_transposed = transpose(w); 
    %w_transposed_dim = size(w_transposed); 

    dw = xr_transposed*dout; 
    %dw_dim = size(dw);

    %6x5 = 6x10 * 10x5
    dx = dout*w_transposed; 
    dx = transpose(dx); 
    dx = reshape(dx, x_dim);
    %dx = reshape(dx,x_dim); 
    dx_dim = size(dx); 

    %10x6 = 10x5 * 5x6 

    db = sum(dout,1); 
    %db_dim = size(db); 
end 
