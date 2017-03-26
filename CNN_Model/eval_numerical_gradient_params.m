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
      
      
  grads = {};  

  
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
          

          if (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x_pos, y, params, num_layers, reg); 
          elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x_pos, y, reg, params);
          end 
              
          
          fx = loss; 
      
          pos = fx;
          pos_size = size(pos);
          
          x_reshaped(i,j) = (oldval - h); 
          x_neg = transpose(x_reshaped); 
          x_neg = reshape(x_neg, x_dim); 
          size(x_neg); 
          
          if (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x_neg, y, params, num_layers, reg); 
          elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x_neg, y, reg, params);
          end 
              
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
  
  for p = 1:1:length(params)
      p; 
      param_data = cell2mat(params(p));
      param_data_dim = size(param_data); 
      param_data_num = 0*param_data;
      
      D = prod(param_data_dim(2:end));
      param_data_reshaped = reshape(param_data,D, param_data_dim(1));
      param_data_reshaped = transpose(param_data_reshaped); 
      param_data_reshaped_dim = size(param_data_reshaped);
      

      for i = 1:1:param_data_dim(1)
          for j = 1:1:param_data_dim(2)
              i;
              j;
              oldval = param_data_reshaped(i,j); 

              param_data_reshaped(i,j) = oldval + h; 
              
              param_data_pos = transpose(param_data_reshaped); 
              param_data_pos = reshape(param_data_pos, param_data_dim); 
              params(p) = {param_data_pos}; 
              
              if (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x, y, params, num_layers, reg); 
              elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x, y, reg, params); 
              end 
              

              fx = loss; 
              pos = fx; 
              pos_size = size(pos);

              param_data_reshaped(i,j) = oldval - h; 
              param_data_neg = transpose(param_data_reshaped); 
              param_data_neg = reshape(param_data_neg, param_data_dim); 
              params(p) = {param_data_neg}; 
              
              if (strcmp(type, 'FullyConnectedNet_loss') == 1) [loss, grads, scores] = FullyConnectedNet_loss(x, y, params, num_layers, reg); 
              elseif (strcmp(type, 'ThreeLayerConvNet_loss') == 1) [loss, grads, scores] = ThreeLayerConvNet_loss(x, y, reg, params); 
              end 

              fx = loss; 
              neg = fx; 
              neg_size = size(neg);
              param_data_reshaped(i,j) = oldval; 

              pos-neg;

              sum_numerator = sum((pos-neg)); 

              if(length(sum_numerator) > 1)
                sum_numerator = sum(sum_numerator); 
              end 
              sum_numerator;
              size(sum_numerator); 
              param_data_num(i,j) = sum_numerator / (2 * h); 
          end 
      end
      param_data_num;
      grads(p) = {param_data_num};
      params(p) = {param_data};
  end  

end 
  
          

  