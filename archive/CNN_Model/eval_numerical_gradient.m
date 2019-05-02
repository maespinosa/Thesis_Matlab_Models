function [dx_num, dW1_num, db1_num, dW2_num, db2_num] = eval_numerical_gradient(x, y, h, W1, b1, W2, b2, reg)
%   """ 
%   a naive implementation of numerical gradient of f at x 
%   - f should be a function that takes a single argument
%   - x is the point (numpy array) to evaluate the gradient at
%   """ 

  x; 

  x_dim = size(x); 
  W1_dim = size(W1);
  b1_dim = size(b1);
  W2_dim = size(W2);
  b2_dim = size(b2);
  
  x_dim = size(x);
  dx_num = zeros(x_dim);  
  
  D = prod(x_dim(2:end));
  x_reshaped = reshape(x,D, x_dim(1));
  x_reshaped = transpose(x_reshaped); 
  x_reshaped_dim = size(x_reshaped);
  
  
  for i = 1:1:x_reshaped_dim(1)
      for j = 1:1:x_reshaped_dim(2)
          oldval = x_reshaped(i,j); 
          
          x_reshaped(i,j) = (oldval + h); 
          x_pos = transpose(x_reshaped); 
          x_pos_dim = size(x_pos);
          x_pos = reshape(x_pos, x_dim); 
          x_pos_dim = size(x_pos);
          
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x_pos, y, reg, W1, b1, W2, b2);
          
          fx = loss; 
      
          pos = fx;
          pos_size = size(pos);
          
          x_reshaped(i,j) = (oldval - h); 
          x_neg = transpose(x_reshaped); 
          x_neg = reshape(x_neg, x_dim); 
          size(x_neg); 
          
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x_neg, y, reg, W1, b1, W2, b2);
          
          fx = loss; 
          
          neg = fx;
          neg_size = size(neg);
          x_reshaped(i,j) = oldval; 
          
          pos-neg; 

          sum_numerator = sum((pos-neg)); 
          
          if(length(sum_numerator) > 1)
            sum_numerator = sum(sum_numerator); 
          end 
          sum_numerator;
          dx_num(i,j) = sum_numerator / (2 * h);
      end 
  end 
  dx_num; 
  
  

  for i = 1:1:W1_dim(1)
      for j = 1:1:W1_dim(2)
          oldval = W1(i,j); 

          W1(i,j) = oldval + h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);

          fx = loss; 
          pos = fx; 
          pos_size = size(pos);

          W1(i,j) = oldval - h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);

          fx = loss; 
          neg = fx; 
          neg_size = size(neg);
          W1(i,j) = oldval; 

          pos-neg;

          sum_numerator = sum((pos-neg)); 

          if(length(sum_numerator) > 1)

            sum_numerator = sum(sum_numerator); 
          end 
          sum_numerator;
          dW1_num(i,j) = sum_numerator / (2 * h);
      end 
  end 
  dW1_num; 
  
  for i = 1:1:W2_dim(1)
      for j = 1:1:W2_dim(2)
          oldval = W2(i,j); 

          W2(i,j) = oldval + h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);

          fx = loss; 
          pos = fx; 
          pos_size = size(pos);

          W2(i,j) = oldval - h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);

          fx = loss; 
          neg = fx; 
          neg_size = size(neg);
          W2(i,j) = oldval; 

          pos-neg;

          sum_numerator = sum((pos-neg)); 

          if(length(sum_numerator) > 1)

            sum_numerator = sum(sum_numerator); 
          end 
          sum_numerator;
          dW2_num(i,j) = sum_numerator / (2 * h);
      end 
  end 
  dW2_num;   

  for i = 1:1:b1_dim(1)
      for j = 1:1:b1_dim(2)
          oldval = b1(i,j); 

          b1(i,j) = oldval + h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);

          fx = loss; 
          pos = fx; 
          pos_size = size(pos);

          b1(i,j) = oldval - h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);

          fx = loss; 
          neg = fx; 
          neg_size = size(neg);
          b1(i,j) = oldval; 

          pos-neg;
      
          sum_numerator = sum((pos-neg)); 

          if(length(sum_numerator) > 1)

            sum_numerator = sum(sum_numerator); 
          end 
          sum_numerator;
          db1_num(i,j) = sum_numerator / (2 * h);
      end 
  end 
  db1_num; 
  
  for i = 1:1:b2_dim(1)
      for j = 1:1:b2_dim(2)
          oldval = b2(i,j); 

          b2(i,j) = oldval + h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);
          fx = loss;
          pos = fx; 
          pos_size = size(pos);

          b2(i,j) = oldval - h; 
          [loss, dW1,db1,dW2,db2, scores] = TwoLayerNet_loss(x, y, reg, W1, b1, W2, b2);

          fx = loss;
          neg = fx; 
          neg_size = size(neg);
          b2(i,j) = oldval; 

          pos-neg;
   
          sum_numerator = sum((pos-neg)); 

          if(length(sum_numerator) > 1)

            sum_numerator = sum(sum_numerator); 
          end 
          sum_numerator;
          db2_num(i,j) = sum_numerator / (2 * h);
      end 
  end 
  db2_num; 
end 
  
          

  