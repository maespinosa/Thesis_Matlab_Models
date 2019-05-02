function [loss, dx] = svm_loss(x, y)
%   """
%   Computes the loss and gradient using for multiclass SVM classification.
% 
%   Inputs:
%   - x: Input data, of shape (N, C) where x[i, j] is the score for the jth class
%     for the ith input.
%   - y: Vector of labels, of shape (N,) where y[i] is the label for x[i] and
%     0 <= y[i] < C
% 
%   Returns a tuple of:
%   - loss: Scalar giving the loss
%   - dx: Gradient of the loss with respect to x
%   """
  x_dim = size(x)
  
  N = x_dim(1)
  correct_class_scores = zeros(N,1); 

  for i = 1:1:N
      correct_class_scores(i,1) = x(i,y(i,1)); 
  end 
  
  margins = max(0, x - correct_class_scores(:, np.newaxis) + 1.0)
  
  margins[np.arange(N), y] = 0; 
  loss = sum(margins) / N; 
  num_pos = sum(margins > 0, 2); 
  dx = zeros(x_dim);
  dx[margins > 0] = 1
  dx[np.arange(N), y] -= num_pos
  dx /= N
end 
siz