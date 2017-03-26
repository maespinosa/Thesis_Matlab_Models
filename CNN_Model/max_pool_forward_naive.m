function [out, x, pool_param] = max_pool_forward_naive(x, pool_param)
%   """
%   A naive implementation of the forward pass for a max pooling layer.
% 
%   Inputs:
%   - x: Input data, of shape (N, F, H, W)
%   - pool_param: dictionary with the following keys:
%     - 'pool_height': The height of each pooling region
%     - 'pool_width': The width of each pooling region
%     - 'stride': The distance between adjacent pooling regions
% 
%   Returns a tuple of:
%   - out: Output data
%   - cache: (x, pool_param)
%   """

%   #############################################################################
%   # TODO: Implement the max pooling forward pass                              #
%   #############################################################################

  
  %INPUT VALUES AND DIMENSIONS
  %x; 
  x_dim = size(x); 
  %x_max_pool_forward_dim = size(x)
  
  N = x_dim(1);
  F = x_dim(2); 
  H = x_dim(3) ;
  W = x_dim(4);

  PW = cell2mat(pool_param(1));
  PH = cell2mat(pool_param(2));
  stride = cell2mat(pool_param(3));
  
  x_loc = ((W-2)/stride) + 1;
  y_loc = ((H-2)/stride) + 1;
  
  x_loc_temp = x_loc + 1; 
  y_loc_temp = y_loc + 1; 

  D = F;
  
  %CALCULATIONS 
  
  max_pool = zeros(D, y_loc, x_loc);
  max_pool_dim = size(max_pool);
  
  %max_all = zeros(N, prod(max_pool_dim));
  max_all = zeros(N, F, H/2, W/2);
  
  y_index = 1; 
  x_index = 1; 
  %pool_y_loc = 1; 
  %pool_x_loc = 1;
  
  for i = 1:1:N %Number of images
%    for j = 1:1:C %RGB colors 

        for pool_y_loc = 1:1:y_loc% while (pool_y_loc < y_loc_temp)
            y_end = y_index + PH -1; 
            for pool_x_loc = 1:1:x_loc %while (pool_x_loc < x_loc_temp)
                x_end = x_index + PW -1; 
                max_temp1 = x(i, :, y_index:y_end, x_index:x_end); 
                %max_temp2 = x(i, 2, y_index:y_end, x_index:x_end); 
                %max_temp3 = x(i, 3, y_index:y_end, x_index:x_end); 
                %size(max_temp1)
                max_temp1 = max(max(max_temp1,[],3),[],4); 
                %size(max_temp1)
                %max_temp1 = max(max(max(max_temp1)));
                %max_temp2 = max(max(max(max_temp2)));
                %max_temp3 = max(max(max(max_temp3)));

                max_pool(:, pool_y_loc, pool_x_loc) = max_temp1; 
                %max_pool(2, pool_y_loc, pool_x_loc) = max_temp2; 
                %max_pool(3, pool_y_loc, pool_x_loc) = max_temp3; 

                x_index = x_index + stride;
                %pool_x_loc = pool_x_loc + 1;
            end 
            x_index = 1;
            %pool_x_loc = 1;
			
            y_index = y_index + stride; 
        end 
		
        y_index = 1;
        x_index = 1;
        %pool_y_loc = 1;
        %pool_x_loc = 1;
        
        %max_reshape = reshape(max_pool, [1,prod(max_pool_dim)]);
        %max_reshape_dim = size(max_reshape); 
    %end 
    %max_all(i,:) = max_reshape;
    max_pool_dim = size(max_pool);
    max_all(i,:,:,:) = max_pool;
  end 
  
  %out = reshape(max_all, [N, C, y_loc, x_loc]); 
  out = max_all;
  
  %out_max_pool_forward_dim = size(out)

end 
  

 

