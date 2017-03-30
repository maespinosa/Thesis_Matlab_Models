function grads = eval_numerical_gradient_params(x, y, h, params, reg, num_layers, type)
%   """ 
%   a naive implementation of numerical gradient of f at x 
%   - f should be a function that takes a single argument
%   - x is the point (numpy array) to evaluate the gradient at
%   """ 

  x; 
  x_dim = size(x); 
  
   if num_layers == 2 
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));

    elseif num_layers == 3 
        
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        
    elseif num_layers == 4 
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        W4 = cell2mat(params(7));
        b4 = cell2mat(params(8));
        
    elseif num_layers == 5
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        W4 = cell2mat(params(7));
        b4 = cell2mat(params(8));
        W5 = cell2mat(params(9));
        b5 = cell2mat(params(10));
        
    elseif num_layers == 6 
        W1 = cell2mat(params(1));
        b1 = cell2mat(params(2));
        W2 = cell2mat(params(3));
        b2 = cell2mat(params(4));
        W3 = cell2mat(params(5));
        b3 = cell2mat(params(6));
        W4 = cell2mat(params(7));
        b4 = cell2mat(params(8));
        W5 = cell2mat(params(9));
        b5 = cell2mat(params(10));
        W6 = cell2mat(params(11));
        b6 = cell2mat(params(12));
    end 
      
      
  grad_num = {};  

%   x_dim = size(x);
%   dx_num = zeros(x_dim);  
%   
%   D = prod(x_dim(2:end));
%   x_reshaped = reshape(x,D, x_dim(1));
%   x_reshaped = transpose(x_reshaped); 
%   x_reshaped_dim = size(x_reshaped);

  if (ndims(x) == 2)
      x_reshaped = permute(x, [2,1]);
      
  elseif (ndims(x) == 3)
      x_reshaped = permute(x, [3,2,1]);
      x_reshaped = reshape(x_reshaped, x_dim(3)*x_dim(2), x_dim(1)); 
  elseif (ndims(x) == 4)
      
      x_reshaped = permute(x, [4,3,2,1]);
      x_reshaped = reshape(x_reshaped, x_dim(4)*x_dim(3), x_dim(2), x_dim(1)); 
      x_reshaped = reshape(x_reshaped, x_dim(4)*x_dim(3)*x_dim(2), x_dim(1)); 
  end
  x_reshaped_dim = size(x_reshaped);  
  
  for i = 1:1:x_reshaped_dim(2)
      for j = 1:1:x_reshaped_dim(1)
          
          x_reshaped_dim
          i
          j
          
          oldval = x_reshaped(j,i); 
          
           x_reshaped(j,i) = (oldval + h); 
%           x_pos = transpose(x_reshaped); 
%           x_pos_dim = size(x_pos);
%           x_pos = reshape(x_pos, x_dim); 
%           x_pos_dim = size(x_pos);


          if(ndims(x) == 2)    
              x_pos = permute(x_reshaped, [2,1]);
          elseif(ndims(x) == 3) 
              x_pos = reshape(x_reshaped, x_dim(3), x_dim(2), x_dim(1));    
              x_pos = permute(x_pos, [3,2,1]);
          elseif(ndims(x) == 4)
              x_pos = reshape(x_reshaped, x_dim(4)*x_dim(3), x_dim(2), x_dim(1)); 
              x_pos = reshape(x_pos, x_dim(4), x_dim(3), x_dim(2), x_dim(1));    
              x_pos = permute(x_pos, [4,3,2,1]);
          end 

          if (strcmp(type, 'TwoLayerNet_loss') == 1) [loss, grads, scores]= TwoLayerNet_loss(x_pos, y, reg, params);
          elseif (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x_pos, y, params, num_layers, reg); 
          elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x_pos, y, reg, params);
          end 

          fx = loss;
      
          pos = fx;
          pos_size = size(pos);
          
          x_reshaped(j,i) = (oldval - h); 
          
%           x_neg = transpose(x_reshaped); 
%           x_neg = reshape(x_neg, x_dim); 
%           size(x_neg); 

          if(ndims(x) == 2)    
              x_neg = permute(x_reshaped, [2,1]);
          elseif(ndims(x) == 3) 
              x_neg = reshape(x_reshaped, x_dim(3), x_dim(2), x_dim(1));    
              x_neg = permute(x_neg, [3,2,1]);
          elseif(ndims(x) == 4)
              x_neg = reshape(x_reshaped, x_dim(4)*x_dim(3), x_dim(2), x_dim(1)); 
              x_neg = reshape(x_neg, x_dim(4), x_dim(3), x_dim(2), x_dim(1));    
              x_neg = permute(x_neg, [4,3,2,1]);
          end 

          if (strcmp(type, 'TwoLayerNet_loss') == 1) [loss, grads, scores]= TwoLayerNet_loss(x_neg, y, reg, params);
          elseif (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x_neg, y, params, num_layers, reg); 
          elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x_neg, y, reg, params);
          end 
       
          fx = loss; 
          
          neg = fx;
          neg_size = size(neg);
          x_reshaped(j,i) = oldval; 
          
          pos-neg; 

          sum_numerator = sum((pos-neg)); 

          while(prod(size(sum_numerator)) > 1)
            sum_numerator = sum(sum_numerator); 
            %size(sum_numerator);
            %prod(size(sum_numerator));
          end 
          
          sum_numerator;
          dx_num(j,i) = sum_numerator / (2 * h);
      end 
  end 
  dx_num;
  dx_num_dim = size(dx_num);
  
  
  if(ndims(x) == 2) 
    dx_num = permute(dx_num, [2,1]);
  elseif(ndims(x) == 3) 
    dx_num = reshape(dx_num, x_dim(3), x_dim(2), x_dim(1));    
    dx_num = permute(dx_num, [3,2,1]);
  elseif(ndims(x) == 4) 
    dx_num = reshape(dx_num, x_dim(4)*x_dim(3), x_dim(2), x_dim(1)); 
    dx_num = reshape(dx_num, x_dim(4), x_dim(3), x_dim(2), x_dim(1));    
    dx_num = permute(dx_num, [4,3,2,1]);
    
  end 

  dx_num_dim = size(dx_num);
  
  
  
  
  pararms_dims = numel(params);
  
  for p = 1:1:numel(params)
      p
      param_data = cell2mat(params(p));
      param_data_dim = size(param_data); 
      param_data_num = 0*param_data;
      
%       D = prod(param_data_dim(2:end));
%       param_data_reshaped = reshape(param_data,D, param_data_dim(1));
%       param_data_reshaped = transpose(param_data_reshaped); 
%       param_data_reshaped_dim = size(param_data_reshaped);
      
      if (ndims(param_data) == 2)
          
          param_data_reshaped = permute(param_data, [2,1]);
      elseif (ndims(param_data) == 3)

          param_data_reshaped = permute(param_data, [3,2,1]);
          param_data_reshaped = reshape(param_data_reshaped, param_data_dim(3)*param_data_dim(2), param_data_dim(1)); 
      elseif (ndims(param_data) == 4)
          param_data_reshaped = permute(param_data, [4,3,2,1]);
          param_data_reshaped = reshape(param_data_reshaped, param_data_dim(4)*param_data_dim(3), param_data_dim(2), param_data_dim(1)); 
          param_data_reshaped = reshape(param_data_reshaped, param_data_dim(4)*param_data_dim(3)*param_data_dim(2),param_data_dim(1)); 
      end
      param_data_reshaped_dim = size(param_data_reshaped);
  
      for i = 1:1:param_data_reshaped_dim(2)
          for j = 1:1:param_data_reshaped_dim(1)
              param_data_reshaped_dim
              i
              j
              oldval = param_data_reshaped(j,i); 

              param_data_reshaped(j,i) = oldval + h; 
              
%               param_data_pos = transpose(param_data_reshaped); 
%               param_data_pos = reshape(param_data_pos, param_data_dim); 
              
              if(ndims(param_data) == 2)    
                  param_data_pos = permute(param_data_reshaped, [2,1]);
              elseif(ndims(param_data) == 3) 
                  param_data_pos = reshape(param_data_reshaped, param_data_dim(3), param_data_dim(2), param_data_dim(1));    
                  param_data_pos = permute(param_data_pos, [3,2,1]);
              elseif(ndims(param_data) == 4)
                  param_data_pos = reshape(param_data_reshaped, param_data_dim(4)*param_data_dim(3), param_data_dim(2), param_data_dim(1)); 
                  param_data_pos = reshape(param_data_pos, param_data_dim(4), param_data_dim(3), param_data_dim(2), param_data_dim(1));    
                  param_data_pos = permute(param_data_pos, [4,3,2,1]);
              end 
              params(p) = {param_data_pos}; 
              
              if (strcmp(type, 'TwoLayerNet_loss') == 1) [loss, grads, scores]= TwoLayerNet_loss(x, y, reg, params);
              elseif (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x, y, params, num_layers, reg); 
              elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x, y, reg, params); 
              end 
              

              fx = loss; 
              pos = fx; 
              pos_size = size(pos);

              param_data_reshaped(j,i) = oldval - h; 
              
%               param_data_neg = transpose(param_data_reshaped); 
%               param_data_neg = reshape(param_data_neg, param_data_dim);
              
              if(ndims(param_data) == 2)    
                  param_data_neg = permute(param_data_reshaped, [2,1]);
              elseif(ndims(param_data) == 3) 
                  param_data_neg = reshape(param_data_reshaped, param_data_dim(3), param_data_dim(2), param_data_dim(1));    
                  param_data_neg = permute(param_data_neg, [3,2,1]);
              elseif(ndims(param_data) == 4)
                  param_data_neg = reshape(param_data_reshaped, param_data_dim(4)*param_data_dim(3), param_data_dim(2), param_data_dim(1)); 
                  param_data_neg = reshape(param_data_neg, param_data_dim(4), param_data_dim(3), param_data_dim(2), param_data_dim(1));    
                  param_data_neg = permute(param_data_neg, [4,3,2,1]);
              end 
              
              params(p) = {param_data_neg}; 
              
              if (strcmp(type, 'TwoLayerNet_loss') == 1) [loss, grads, scores]= TwoLayerNet_loss(x, y, reg, params);
              elseif (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x, y, params, num_layers, reg); 
              elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x, y, reg, params); 
              end 

              fx = loss; 
              neg = fx; 
              neg_size = size(neg);
              param_data_reshaped(j,i) = oldval; 

              pos-neg;

              sum_numerator = sum((pos-neg)); 

              while(prod(size(sum_numerator)) > 1)
                sum_numerator = sum(sum_numerator); 
                %size(sum_numerator);
                %prod(size(sum_numerator));
              end 
              sum_numerator;
              size(sum_numerator); 
              param_data_num(j,i) = sum_numerator / (2 * h); 
          end 
      end
      param_data_num;
      
      if(ndims(param_data) == 2) 
        param_data_num = permute(param_data_num, [2,1]);
      elseif(ndims(param_data) == 3) 
        param_data_num = reshape(param_data_num, param_data_dim(3), param_data_dim(2), param_data_dim(1));    
        param_data_num = permute(param_data_num, [3,2,1]);
      elseif(ndims(param_data) == 4) 
        param_data_num = reshape(param_data_num, param_data_dim(4)*param_data_dim(3), param_data_dim(2), param_data_dim(1)); 
        param_data_num = reshape(param_data_num, param_data_dim(4), param_data_dim(3), param_data_dim(2), param_data_dim(1));    
        param_data_num = permute(param_data_num, [4,3,2,1]);
      end 
      param_data_num;
      
      grad_num(p) = {param_data_num};
      params(p) = {param_data};
  end  

end 
  
          

  