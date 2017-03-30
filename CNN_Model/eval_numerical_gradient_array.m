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
  
  conv_pad = conv_param(1); 
  conv_stride = conv_param(2); 
  
  pool_height = pool_param(1); 
  pool_width = pool_param(2); 
  pool_stride = pool_param(3); 
  
  %x_eval = x(1,1,:,:)

  x_dim = size(x); 

  df_dim = size(df) ;
  
  x_dim_eval = size(x);
  
    
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
  dx_num = zeros(x_reshaped_dim);
  
 
  for i = 1:1:x_reshaped_dim(2)
      for j = 1:1:x_reshaped_dim(1)
          oldval = x_reshaped(j,i); 
          
          x_reshaped(j,i) = (oldval + h); 
          
%           x_pos = transpose(x_reshaped); 
%           x_pos_dim = size(x_pos);
%           x_pos = reshape(x_pos, x_dim); 
%           x_pos_dim = size(x_pos);
%           if(i == 1 && j == 1) 
%               x_pos(1,1,:,:); 
%           end 


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
          
          
          
          if(strcmp(neuron_type,'affine') == 1) fx = affine_forward(x_pos, transpose(w), b);
          elseif(strcmp(neuron_type,'relu') == 1) fx = relu_forward(x_pos);
          elseif(strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x_pos, w, b);
          elseif(strcmp(neuron_type,'conv_forward_naive') == 1) [fx, cache] = conv_forward_naive(x_pos, w, b, conv_param); 
          elseif(strcmp(neuron_type,'max_pool_forward_naive') == 1) fx = max_pool_forward_naive(x_pos, pool_param);
          elseif(strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x_pos, w, b, conv_param, pool_param); 
          end
      
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
          
          
          if(strcmp(neuron_type,'affine') == 1) fx = affine_forward(x_neg, transpose(w), b);
          elseif(strcmp(neuron_type,'relu') == 1) fx = relu_forward(x_neg);
          elseif(strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x_neg, w, b);
          elseif(strcmp(neuron_type,'conv_forward_naive') == 1) [fx, cache] = conv_forward_naive(x_neg, w, b, conv_param); 
          elseif(strcmp(neuron_type,'max_pool_forward_naive') == 1) fx = max_pool_forward_naive(x_neg, pool_param);
          elseif(strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x_neg, w, b, conv_param, pool_param); 
          end
          
          neg = fx;
          neg_size = size(neg);
          x_reshaped(j,i) = oldval; 
          
          pos-neg; 
          df;
          sum_numerator = sum((pos-neg) .* df); 
          size(sum_numerator);
          while(prod(size(sum_numerator)) > 1)
            sum_numerator = sum(sum_numerator); 
            %size(sum_numerator);
            %prod(size(sum_numerator));
          end 
          %ndims(sum_numerator);
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

  
  
  
  if (strcmp(neuron_type, 'affine') == 1) || (strcmp(neuron_type, 'affine_relu') == 1) || (strcmp(neuron_type, 'conv_forward_naive') == 1) || (strcmp(neuron_type, 'conv_relu_pool_forward') == 1)
      w_dim = size(w);
      b_dim = size(b);

      if(ndims(w) == 2)
        w_reshaped = permute(w, [2,1]);
      elseif(ndims(w) == 3)
        w_reshaped = permute(w, [3,2,1]);
        w_reshaped = reshape(w_reshaped, w_dim(3)*w_dim(2), w_dim(1)); 
      elseif(ndims(w) == 4)
        w_reshaped = permute(w, [4,3,2,1]);
        w_reshaped = reshape(w_reshaped, w_dim(4)*w_dim(3), w_dim(2), w_dim(1)); 
        w_reshaped = reshape(w_reshaped, w_dim(4)*w_dim(3)*w_dim(2), w_dim(1)); 
      end 

      w_reshaped_dim = size(w_reshaped);
      dw_num = zeros(w_reshaped_dim);
      
      
      for i = 1:1:w_reshaped_dim(2)
          for j = 1:1:w_reshaped_dim(1)
              oldval = w_reshaped(j,i); 

              w_reshaped(j,i) = oldval + h; 
              
%               w_pos = transpose(w_reshaped); 
%               w_pos = reshape(w_pos, w_dim); 
%               size(w_pos);

              if(ndims(w) == 2)  
                w_pos = permute(w_reshaped, [2,1]);
              elseif(ndims(w) == 3)  
                w_pos = reshape(w_reshaped, w_dim(3), w_dim(2), w_dim(1));    
                w_pos = permute(w_pos, [3,2,1]);
              elseif(ndims(w) == 4) 
                w_pos = reshape(w_reshaped, w_dim(4)*w_dim(3), w_dim(2), w_dim(1)); 
                w_pos = reshape(w_pos, w_dim(4), w_dim(3), w_dim(2), w_dim(1));    
                w_pos = permute(w_pos, [4,3,2,1]);
              end 

              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w_pos), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w_pos, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) [fx, cache] = conv_forward_naive(x, w_pos, b, conv_param); 
              elseif (strcmp(neuron_type,'conv_relu_pool_forward') == 1) [fx, conv_cache, relu_x, pool_x, pool_param] = conv_relu_pool_forward(x, w_pos, b, conv_param, pool_param); 
              end
              pos = fx; 
              pos_size = size(pos);

              w_reshaped(j,i) = oldval - h; 
              
%               w_neg = transpose(w_reshaped); 
%               w_neg = reshape(w_neg, w_dim); 
%               size(w_neg); 

              if(ndims(w) == 2)  
                w_neg = permute(w_reshaped, [2,1]);
              elseif(ndims(w) == 3)  
                w_neg = reshape(w_reshaped, w_dim(3), w_dim(2), w_dim(1));    
                w_neg = permute(w_neg, [3,2,1]);
              elseif(ndims(w) == 4) 
                w_neg = reshape(w_reshaped, w_dim(4)*w_dim(3), w_dim(2), w_dim(1)); 
                w_neg = reshape(w_neg, w_dim(4), w_dim(3), w_dim(2), w_dim(1));    
                w_neg = permute(w_neg, [4,3,2,1]);
              end 

              
              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w_neg), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w_neg, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) [fx, cache] = conv_forward_naive(x, w_neg, b, conv_param); 
              elseif (strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x, w_neg, b, conv_param, pool_param); 
              end
              neg = fx; 
              neg_size = size(neg);
              w_reshaped(j,i) = oldval; 

              pos-neg;
              df;
              sum_numerator = sum((pos-neg) .* df);

              while(prod(size(sum_numerator)) > 1)

                sum_numerator = sum(sum_numerator); 
              end 
              sum_numerator;
              dw_num(j,i) = sum_numerator / (2 * h);
          end 
      end 
      dw_num; 
      
      if(ndims(w) == 2)  
        dw_num = permute(dw_num, [2,1]);
      elseif(ndims(w) == 3) 
        dw_num = reshape(dw_num, w_dim(3), w_dim(2), w_dim(1));    
        dw_num = permute(dw_num, [3,2,1]);
      elseif(ndims(w) == 4) 
        dw_num = reshape(dw_num, w_dim(4)*w_dim(3), w_dim(2), w_dim(1)); 
        dw_num = reshape(dw_num, w_dim(4), w_dim(3), w_dim(2), w_dim(1));    
        dw_num = permute(dw_num, [4,3,2,1]);
      end 
      
      dw_num_dim = size(dw_num);
      
      

      for i = 1:1:b_dim(1)
          for j = 1:1:b_dim(2)
              oldval = b(i,j); 

              b(i,j) = oldval + h; 
              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) [fx, cache] = conv_forward_naive(x, w, b, conv_param); 
              elseif (strcmp(neuron_type,'conv_relu_pool_forward') == 1) fx = conv_relu_pool_forward(x, w, b, conv_param, pool_param); 
              end
              pos = fx; 
              pos_size = size(pos);

              b(i,j) = oldval - h; 
              if (strcmp(neuron_type,'affine') == 1) fx = affine_forward(x, transpose(w), b);
              elseif (strcmp(neuron_type,'affine_relu') == 1) fx = affine_relu_forward(x, w, b);
              elseif (strcmp(neuron_type,'conv_forward_naive') == 1) [fx, cache] = conv_forward_naive(x, w, b, conv_param); 
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
  
          
