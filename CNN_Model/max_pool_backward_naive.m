function dx = max_pool_backward_naive(dout, x, pool_param)
%   """
%   A naive implementation of the backward pass for a max pooling layer.
% 
%   Inputs:
%   - dout: Upstream derivatives
%   - cache: A tuple of (x, pool_param) as in the forward pass.
% 
%   Returns:
%   - dx: Gradient with respect to x
%   """

%   #############################################################################
%   # TODO: Implement the max pooling backward pass                             #
%   #############################################################################
% 
%   
  %dout; 
  dout_dim = size(dout); 
  dout_repelem = repelem(dout, 1, 1, 2, 2); 
  %dout_repelem_dim = size(dout_repelem)
  %x; 
  x_dim = size(x); 
  %x_max_pool_backward_dim = size(x)
   
  dx = zeros(x_dim); 
  
  N = x_dim(1); 
  F = x_dim(2);
  H = x_dim(3);
  W = x_dim(4);
  
  F = 2; 
  
  PW = cell2mat(pool_param(1)); 
  PH = cell2mat(pool_param(2)); 
  stride = cell2mat(pool_param(3)); 
  
  x_loc =((W-F)/stride) + 1; 
  y_loc =((H-F)/stride) + 1; 
  
  [out, cache] = max_pool_forward_naive(x, pool_param); 
  out_dim = size(out); 
  
  out_repelem = repelem(out, 1, 1, 2, 2); 
  %out_repelem_dim = size(out_repelem)
  
  y_index = 1;
  x_index = 1; 
  pool_y_loc = 1; 
  pool_x_loc = 1; 
  
  for i = 1:1:N  % Number of images

    %for j = 1:1:C % RGB colors 
        while pool_y_loc <= y_loc
            while pool_x_loc <= x_loc
                pool_block1 = x(i, :, y_index:y_index+PH-1,x_index:x_index + PW-1); 
                %pool_block1_dim = size(pool_block1);
                %out_repelem_dim = size(out_repelem(i, :, y_index:y_index+PH-1,x_index:x_index + PW-1));
                pool_block1(pool_block1 == out_repelem(i, :, y_index:y_index+PH-1,x_index:x_index + PW-1)) = 1; 
                pool_block1(pool_block1 ~= 1) = 0; 
                %pool_block1_dim = size(pool_block1)
                pool_block1 = pool_block1 .* dout_repelem(i, :, y_index:y_index+PH-1,x_index:x_index + PW-1); 

                
%                 pool_block2 = x(:, 2, y_index:y_index+PH-1,x_index:x_index + PW-1); 
%                 pool_block2(pool_block2 == out(:,2,pool_y_loc,pool_x_loc)) = 1; 
%                 pool_block2(pool_block2 ~= 1) = 0; 
%                 pool_block2(pool_block2 == 1) = dout(:, 2, pool_y_loc, pool_x_loc); 
%                 
%                 pool_block3 = x(:, 3, y_index:y_index+PH-1,x_index:x_index + PW-1); 
%                 pool_block3(pool_block3 == out(:,3,pool_y_loc,pool_x_loc)) = 1; 
%                 pool_block3(pool_block3 ~= 1) = 0; 
%                 pool_block3(pool_block3 == 1) = dout(:, 3, pool_y_loc, pool_x_loc); 
				
                dx(i,:, y_index:y_index+PH-1, x_index:x_index + PW-1) = pool_block1; 
%                 dx(i,2, y_index:y_index+PH-1, x_index:x_index + PW-1) = pool_block2;
%                 dx(i,3, y_index:y_index+PH-1, x_index:x_index + PW-1) = pool_block3;
                

                x_index = x_index + stride; 
				
                pool_x_loc = pool_x_loc + 1; 
            end 
        
				
            x_index = 1; 
            pool_x_loc = 1; 
			
            y_index = y_index + stride;  
            pool_y_loc = pool_y_loc + 1; 		
        end 
		
        y_index = 1; 
        x_index = 1; 
        pool_y_loc = 1; 
        pool_x_loc = 1; 
    %end 
  end 
  
  %out_max_pool_backward_dim = size(dx)
end 


 
  
  


