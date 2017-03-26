function [dx] = relu_backward(dout, x)

    % Computes the backward pass for a layer of rectified linear units (ReLUs).
    % 
    % Input:
    % - dout: Upstream derivatives, of any shape
    % - cache: Input x, of same shape as dout
    % 
    % Returns:
    % - dx: Gradient with respect to x

    %dx = []; 

    dout; 
    %dout_dim = size(dout);

    %x; 
    x_dim = size(x); 
    %x_relu_backward_dim = size(x)

%     dx = zeros(x_dim(1), x_dim(2));

     mask = zeros(x_dim);
% 
%     for i = 1:1:x_dim(1)
%        for j = 1:1:x_dim(2)
%             x(i,j);
%             if (x(i,j) > 0.0) 
%                 mask(i,j) = 1; 
%             end
%        end
%     end 

    mask(x > 0.0) = 1; 

    %mask_dim = size(mask);
    %x;  

    dx = dout.*mask; 
    %dx_dim = size(dx); 
    
    %out_relu_backward_dim = size(dx)

end 
