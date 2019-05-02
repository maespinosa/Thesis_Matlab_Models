function [dx_num, dw_num, db_num] = eval_numerical_gradient_array(x, w, b, df, h, neuron_type, conv_param, pool_param )
%   """
%   Evaluate a numeric gradient for a function that accepts a numpy
%   array and returns a numpy array.
%   """
  disp('EXECUTING EVAL NUMERICAL GRADIENT ARRAY' )
  x; 
  w;
  b;
  df;
  neuron_type; 
  
  conv_pad = conv_param(1)
  conv_stride = conv_param(2); 
  
  pool_height = pool_param(1); 
  pool_width = pool_param(2); 
  pool_stride = pool_param(3); 
  

  x_dim = size(x); 
  w_dim = size(w);
  b_dim = size(b);
  df_dim = size(df); 
  
  x_dim = size(x);
  dx_num = zeros(x_dim);  
  
  D = prod(x_dim(2:end));
  x_reshaped = reshape(x,D, x_dim(1));
  x_reshaped = transpose(x_reshaped); 
  x_reshaped_dim = size(x_reshaped);
  
  D = prod(w_dim(2:end));
  w_reshaped = reshape(w,D, w_dim(1));
  w_reshaped = transpose(w_reshaped); 
  w_reshaped_dim = size(w_reshaped);
  
 
  for i = 1:1:x_reshaped_dim(1)
      for j = 1:1:x_reshaped_dim(2)
          oldval = x_reshaped(i,j); 
          
          x_reshaped(i,j) = (oldval + h); 
          x_pos = transpose(x_reshaped); 
          x_pos_dim = size(x_pos);
          x_pos = reshape(x_pos, x_dim); 
          x_pos_dim = size(x_pos);
          
          if(strcmp(neuron_type,'affine') == 1) fx = affine_forward(x_pos, transpose(w), b);
          elseif(strcmp(neuron_type,'relu') == 1) fx = relu_forward(x_pos);
          elseif(strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x_pos, w, b);
          elseif(strcmp(neuron_type,'conv_forward_naive') == 1) fx = conv_forward_naive(x_pos, w, b, conv_param); 
          elseif(strcmp(neuron_type,'max_pool_forward_naive') == 1) fx = max_pool_forward_naive(x_pos, pool_param);
          elseif(strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x_pos, w, b, conv_param, pool_param); 
          end
      
          pos = fx;
          pos_size = size(pos);
          
          x_reshaped(i,j) = (oldval - h); 
          x_neg = transpose(x_reshaped); 
          x_neg = reshape(x_neg, x_dim); 
          size(x_neg); 
          
          if(strcmp(neuron_type,'affine') == 1) fx = affine_forward(x_neg, transpose(w), b);
          elseif(strcmp(neuron_type,'relu') == 1) fx = relu_forward(x_neg);
          elseif(strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x_neg, w, b);
          elseif(strcmp(neuron_type,'conv_forward_naive') == 1) fx = conv_forward_naive(x_neg, w, b, conv_param); 
          elseif(strcmp(neuron_type,'max_pool_forward_naive') == 1) fx = max_pool_forward_naive(x_neg, pool_param);
          elseif(strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x_neg, w, b, conv_param, pool_param); 
          end
          
          neg = fx;
          neg_size = size(neg);
          x_reshaped(i,j) = oldval; 
          
          pos-neg; 
          df;
          sum_numerator = sum((pos-neg) .* df); 
          size(sum_numerator);
          while(prod(size(sum_numerator)) > 1)
            sum_numerator = sum(sum_numerator); 
            size(sum_numerator);
            prod(size(sum_numerator));
          end 
          length(sum_numerator);
          dx_num(i,j) = sum_numerator / (2 * h);
      end 
  end 
  dx_num; 
  
  
  if (strcmp(neuron_type, 'affine') == 1) || (strcmp(neuron_type, 'affine_relu') == 1) || (strcmp(neuron_type, 'conv_forward_naive') == 1) || (strcmp(neuron_type, 'conv_relu_pool_forward') == 1)
     
      for i = 1:1:w_reshaped_dim(1)
          for j = 1:1:w_reshaped_dim(2)
              oldval = w_reshaped(i,j); 

              w_reshaped(i,j) = oldval + h; 
              
              w_pos = transpose(w_reshaped); 
              w_pos = reshape(w_pos, w_dim); 
              size(w_pos); 
              
              
              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w_pos), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w_pos, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) fx = conv_forward_naive(x, w_pos, b, conv_param); 
              elseif (strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x, w_pos, b, conv_param, pool_param); 
              end
              pos = fx; 
              pos_size = size(pos);

              w_reshaped(i,j) = oldval - h; 
              
              w_neg = transpose(w_reshaped); 
              w_neg = reshape(w_neg, w_dim); 
              size(w_neg); 
              
              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w_neg), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w_neg, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) fx = conv_forward_naive(x, w_neg, b, conv_param); 
              elseif (strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x, w_neg, b, conv_param, pool_param); 
              end
              neg = fx; 
              neg_size = size(neg);
              w_reshaped(i,j) = oldval; 

              pos-neg;
              df;
              sum_numerator = sum((pos-neg) .* df); 

              while(prod(size(sum_numerator)) > 1)

                sum_numerator = sum(sum_numerator); 
              end 
              sum_numerator;
              dw_num(i,j) = sum_numerator / (2 * h);
          end 
      end 
      dw_num; 

      for i = 1:1:b_dim(1)
          for j = 1:1:b_dim(2)
              oldval = b(i,j); 

              b(i,j) = oldval + h; 
              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) fx = conv_forward_naive(x, w, b, conv_param); 
              elseif (strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x, w, b, conv_param, pool_param); 
              end
              pos = fx; 
              pos_size = size(pos);

              b(i,j) = oldval - h; 
              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) fx = conv_forward_naive(x, w, b, conv_param); 
              elseif (strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x, w, b, conv_param, pool_param); 
              end
              neg = fx; 
              neg_size = size(neg);
              b(i,j) = oldval; 

              pos-neg;
              df;
              sum_numerator = sum((pos-neg) .* df); 

              while(prod(size(sum_numerator)) > 1)

                sum_numerator = sum(sum_numerator); 
              end 
              sum_numerator;
              db_num(i,j) = sum_numerator / (2 * h);
          end 
      end 
      db_num; 
  else 
      dw_num = 0; 
      db_num = 0; 
  end 
end 
  
          
