function [out,x,w,b] = affine_forward(x, w, b)

%   Computes the forward pass for an affine (fully-connected) layer.
% 
%   The input x has shape (N, d_1, ..., d_k) and contains a minibatch of N
%   examples, where each example x[i] has shape (d_1, ..., d_k). We will
%   reshape each input into a vector of dimension D = d_1 * ... * d_k, and
%   then transform it to an output vector of dimension M.
% 
%   Inputs:
%   - x: A numpy array containing input data, of shape (N, d_1, ..., d_k)
%   - w: A numpy array of weights, of shape (D, M)
%   - b: A numpy array of biases, of shape (M,)
%   
%   Returns a tuple of:
%   - out: output, of shape (N, M)
%   - cache: (x, w, b)

%x;
%w;
%b;

%x_dim_affine_forward = size(x);
%w_dim_affine_forward = size(w);
%b_dim_affine_forward = size(b);

x_dim = size(x); 
%w_dim = size(w); 
b_dim = size(b);

x_length = length(x_dim);
D = prod(x_dim(2:end));

out = zeros(x_dim(1), b_dim(2));
if x_length > 2
    x_reshaped = reshape(x,D, x_dim(1));
    x_reshaped = transpose(x_reshaped);
    x_reshaped_dim = size(x_reshaped);
else 
    x_reshaped = x; 
    x_reshaped_dim = size(x_reshaped); 
end

w_transposed = transpose(w); 
%w_transposed_dim = size(w_transposed);

xr_transposed = transpose(x_reshaped);
%xr_transposed_dim = size(xr_transposed);

for i = 1:1:x_reshaped_dim(1)
        out(i,:) = w * xr_transposed(:,i) + transpose(b); 
end 

out;
end 