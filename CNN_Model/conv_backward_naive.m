function [dx,dw,db] =  conv_backward_naive(dout, x, w, b, conv_param)
    %disp('EXECUTING CONV BACKWARD NAIVE')
    %   A naive implementation of the backward pass for a convolutional layer.
    % 
    %   Inputs:
    %   - dout: Upstream derivatives.
    %   - cache: A tuple of (x, w, b, conv_param) as in conv_forward_naive
    % 
    %   Returns a tuple of:
    %   - dx: Gradient with respect to x
    %   - dw: Gradient with respect to w
    %   - db: Gradient with respect to b
   

    dx = [];
    dw = []; 
    db = [];

    % x, w, b, conv_param = cache

    %   - out: Output data, of shape (N, F, H', W') where H' and W' are given by
    %     H' = 1 + (H + 2 * pad - HH) / stride
    %     W' = 1 + (W + 2 * pad - WW) / stride
    
    x_conv_backward_dim = size(x)

  
    % DISPLAY THE CRITICAL DIMENSIONS 
    % =============================
    pad = cell2mat(conv_param(1)); 
    stride = cell2mat(conv_param(2)); 

    % Input Volume Dimensions
    dout; 
    dout_dim = size(dout)  ;

    N = dout_dim(1);
    H = dout_dim(3);
    W = dout_dim(4);

    % Filter Dimensions
    w; 
    w_dim = size(w);

    F = w_dim(1);
    C = w_dim(2);
    HH = w_dim(3);
    WW = w_dim(4);

    % Output Volume Dimensions
    OH = 1 + ((H + 2 * pad - HH)/stride);
    OW = 1 + ((W + 2 * pad - WW)/stride);

    
    % FIND DX 
    % =============================
    % =============================

    w_row = zeros(F,HH*WW*C); 	
    out = zeros(N,C,OH,OW); 

    % ROTATE THE WEIGHTS
    % =======================
    w; 
    w_rot180 = w * 0; 
    %w_rot180_dim = size(w_rot180); 		

    for i = 1:1:F
       for j = 1:1:C
           w_2d = zeros(w_dim(3), w_dim(4));
           w_2d(:,:) = w(i,j,:,:); 
           %size(w_2d);
           w_rot180(i,j,:,:) = (rot90(w_2d, 2)); 
       end;  
    end; 
   
    %w_rot180(1,1,:,:)
  

    % RACK AND STACK WEIGHTS INTO ROW VECTORS 
    % =============================
    filter_w = zeros(HH, WW); 


%     for ii = 1:1:F 
%         for iii = 1:1:C 
%             filter_w = w_rot180(ii,iii,:,:); 
%             %filter_w_dim = size(filter_w);
%             %filter_w = reshape(filter_w, HH*WW,1);
%             filter_w = filter_w(1,:); 
%             %filter_w_dim = size(filter_w);
%             w_row(ii,(iii*HH*WW - HH*WW + 1):(iii*HH*WW)) = filter_w; 
%         end 
%     end 
 
   
    w_rot180 = permute(w_rot180, [4,3,2,1]); 
    w_rot180 = reshape(w_rot180, HH*WW,C,F);
    w_row = reshape(w_rot180, C*HH*WW, F); 
    %w_row = transpose(w_row);
    
    dout_old = dout; 
    dout = permute(dout, [4,3,2,1]); 
    
    % INITIALIZE COLUMN SIZE
    X_col = zeros(OH*OW,HH*WW*F); 


    % INITIALIZE PADDED MATRIX 
    dout_pad = zeros(1,N*(H +(pad*2))*(W +(pad*2))*F); 	
    dout_pad = reshape(dout_pad,(W+(pad*2)),(H+(pad*2)),F,N); 
    dout_pad_dim = size(dout_pad); 
    
    % PLACE DATA INTO PADDED MATRIX 
    dout_pad(pad+1:dout_pad_dim(2)-pad, pad+1:dout_pad_dim(1)-pad,:,:) = dout; 
    
    conv = zeros(F,C,OH,OW); 
    conv_out = zeros(OH,OW,C); 
  
    


    % CONVOLVE
    % =============================
    for i = 1:1:N  %NUMBER OF SAMPLES 
       %for ff = 1:1:F   %#NUMBER OF FILTERS

            % PLACE X DATA INTO PADDED MATRIX 
            %x_pad(pad+1:x_pad_dim(1)-pad,pad+1:x_pad_dim(2)-pad) = dout(i,ff,:,:);
            
            % INITIALIZE COUNTERS
            loc_counter = 1;
            j = 1;
            k = 1;
            horz_count = 0;
            vert_count = 0;
          
            % RACK AND STACK INPUT DATA INTO COLUMNS
            while vert_count < OH
                 while horz_count < OW
                                       %Width  Height  Filter  Sample 
                    X_block = dout_pad(k:k+WW-1,j:j+HH-1,:,i);
                    
                    X_col(loc_counter,:) = X_block(:);
                    if i == 1 %&& vert_count == 1 && horz_count == 1
                        X_block(:); 
                    end 

                    k = k + stride; 
                    loc_counter = loc_counter + 1 ;
                    horz_count = horz_count + 1; 
                 end; 

                 k = 1; 
                 horz_count = 0; 
                 j = j + stride; 
                 vert_count = vert_count + 1 ;
            end; 
         
            
            %X_col
            %X_col_dim = size(X_col)
            
            %w_row_dim = size(w_row)
            


            % DOT PRODUCT OF FILTER AND X DATA
            %size(w_row(1:(HH*WW*1),:))
            %size(X_col(:,1:HH*WW))
            
            
            
            
            channel1_filter1 = transpose(w_row(1:(HH*WW*1),1)) * transpose(X_col(:,1:HH*WW));
            %channel1_filter1_dim = size(channel1_filter1)
            channel1_filter1 = transpose(reshape(channel1_filter1, OH, OW));
            
            channel1_filter2 = transpose(w_row(1:(HH*WW*1),2)) * transpose(X_col(:,HH*WW*1+1:(HH*WW*2)));
            %channel1_filter2_dim = size(channel1_filter2)
            channel1_filter2 = transpose(reshape(channel1_filter2, OH, OW));
            
            channel2_filter1 = transpose(w_row(HH*WW*1+1:(HH*WW*2),1)) * transpose(X_col(:,1:HH*WW));
            channel2_filter1 = transpose(reshape(channel2_filter1, OH, OW));
            channel2_filter2 = transpose(w_row(HH*WW*1+1:(HH*WW*2),2)) * transpose(X_col(:,HH*WW*1+1:(HH*WW*2)));
            channel2_filter2 = transpose(reshape(channel2_filter2, OH, OW)); 
            
            channel3_filter1 = transpose(w_row(HH*WW*2+1:(HH*WW*3),1)) * transpose(X_col(:,1:HH*WW));
            channel3_filter1 = transpose(reshape(channel3_filter1, OH, OW));
            channel3_filter2 = transpose(w_row(HH*WW*2+1:(HH*WW*3),2)) * transpose(X_col(:,HH*WW*1+1:(HH*WW*2)));
            channel3_filter2 = transpose(reshape(channel3_filter2, OH, OW));
%             
%             dot1_xdim = size(dot1)
%             %dot1 = transpose(reshape(dot1, OW, OH));
%             %dot1_xdim = size(dot1);
% 
%             dot2 = transpose(w_row(HH*WW*1+1:(HH*WW*2),:)) * transpose(X_col(:,HH*WW*1+1:(HH*WW*2))); 
%             %dot2 = transpose(reshape(dot2, OH, OW));
%             %dot2_xdim = size(dot2);
% 
%             dot3 = transpose(w_row(HH*WW*2+1:(HH*WW*3),:)) * transpose(X_col(:,HH*WW*2+1:(HH*WW*3))); 
%             %dot3 = transpose(reshape(dot3, OH, OW)); 
%             %dot3_xdim = size(dot3);

%             conv(ff,1,:,:) = dot1;
%             conv(ff,2,:,:) = dot2;
%             conv(ff,3,:,:) = dot3;
      
            conv(1,1,:,:) = channel1_filter1; 
            conv(2,1,:,:) = channel1_filter2; 
            conv(1,2,:,:) = channel2_filter1; 
            conv(2,2,:,:) = channel2_filter2; 
            conv(1,3,:,:) = channel3_filter1; 
            conv(2,3,:,:) = channel3_filter2; 
          
       %end; 
       
       conv_out = sum(conv, 1); 
       conv_out(1,3,:,:);
       %conv_out = reshape(conv_out,OH,OW,C); 
       conv_out_dim = size(conv_out);

       out(i,:,:,:) = conv_out;
       out_dim = size(out);

    end; 

    dout = dout_old; 
    dx = out; 
    %dx_sample1_channel1 = dx(1,1,:,:)
    %dx_sample1_channel2 = dx(1,2,:,:)
    %dx_sample1_channel3 = dx(1,3,:,:)
    
    %dx_sample2_channel1 = dx(2,1,:,:)
    %dx_sample2_channel2 = dx(2,2,:,:)
    %dx_sample2_channel3 = dx(2,3,:,:)

    %DX DONE 
    %========================================
    %========================================
  


    
    
    % FIND DW 
    % =============================
    % =============================
   
    % DOUT IS NEW FILTER  

    % Input Volume Dimensions
    x_dim = size(x);

    N = x_dim(1);
    C = x_dim(2);
    H = x_dim(3);
    W = x_dim(4);

    % Filter Dimensions
    F = dout_dim(2);
    HH = dout_dim(3);
    WW = dout_dim(4);

    % Output Volume Dimensions
    OH = 1 + ((H + 2 * pad - HH)/stride);
    OW = 1 + ((W + 2 * pad - WW)/stride);


    %ROTATE THE WEIGHTS
    %=======================
    dout;
    %dout_dim = size(dout); 

    dout_rot180 = dout * 0; 
    %dout_rot180_dim = size(dout_rot180); 	
    
    for i = 1:1:N 
       for j = 1:1:F
           dout_dim_2d = zeros(dout_dim(3), dout_dim(4));
           dout_dim_2d(:,:) = dout(i,j,:,:); 
           %size(dout_dim_2d);
            dout_rot180(i,j,:,:) = rot90(dout_dim_2d, 2); 
       end; 
    end; 
  
    %dout_rot180; 
    % RACK AND STACK WEIGHTS INTO ROW VECTORS 
    % =============================
    filter_w = zeros(HH, WW);
    w_row = zeros(N,F,HH*WW);	

    dout_rot180 = permute(dout_rot180, [4,3,2,1]); 
    dout_rot180 = reshape(dout_rot180, HH*WW,F,N);
    dout_row = reshape(dout_rot180, F*HH*WW, N); 

    dout_row_dim = size(dout_row) ; 


    % INITIALIZE COLUMN SIZE
    X_col = zeros(OH*OW,HH*WW*C);

    % INITIALIZE PADDED MATRIX 
    conv = zeros(N,F,C,OH,OW);
    conv_out = zeros(F,C,OH,OW);
    
    
    % PLACE X DATA INTO PADDED MATRIX
    x_old = x; 
    x = permute(x, [4,3,2,1]); 
    x_pad = zeros(1,N*(H +(pad*2))*(W +(pad*2))*C); 	
    x_pad = reshape(x_pad,(W+(pad*2)),(H+(pad*2)),C,N); 
    x_pad_dim = size(x_pad);

    x_pad(pad+1:x_pad_dim(2)-pad, pad+1:x_pad_dim(1)-pad,:,:) = x; 
    
    X_block = []; 
    

    % CONVOLVE
    % =============================
    for i = 1:1:N  %NUMBER OF SAMPLES 

        % INITIALIZE COUNTERS

        loc_counter = 1; 
        j = 1; 
        k = 1; 
        horz_count = 0; 
        vert_count = 0; 

        % RACK AND STACK INPUT DATA INTO COLUMNS
        while vert_count < OH
             while horz_count < OW
                                %Width     Height  Channel Sample
                 X_block = x_pad(k:k+WW-1,j:j+HH-1,:,i);

                 X_col(loc_counter,:) = X_block(:); 

                 k = k + stride; 
                 loc_counter; 
                 loc_counter = loc_counter + 1;
                 horz_count = horz_count + 1;
             end; 

             k = 1;
             horz_count = 0;
             j = j + stride; 
             vert_count = vert_count + 1;
        end; 

        %X_col;
        X_col_dim = size(X_col);
        %w_row_dim = size(w_row); 

        %DOT PRODUCT OF FILTER AND X DATA 
                                     %25x4                 9x25
        channel1_filter1 = transpose(dout_row(1:HH*WW,i)) * transpose(X_col(:, 1:HH*WW)); 
        channel1_filter1 = reshape(channel1_filter1, OH,OW); 

        channel2_filter1 = transpose(dout_row(1:HH*WW,i)) * transpose(X_col(:, HH*WW*1+1:(HH*WW*2))); 
        channel2_filter1 = reshape(channel1_filter1, OH,OW); 

        channel3_filter1 = transpose(dout_row(1:HH*WW,i)) * transpose(X_col(:, HH*WW*2+1:(HH*WW*3))); 
        channel3_filter1 = reshape(channel1_filter1, OH,OW); 

        channel1_filter2 = transpose(dout_row(HH*WW*1+1:(HH*WW*2),i)) * transpose(X_col(:, 1:HH*WW)); 
        channel1_filter2 = reshape(channel1_filter1, OH,OW); 

        channel2_filter2 = transpose(dout_row(HH*WW*1+1:(HH*WW*2),i)) * transpose(X_col(:, HH*WW*1+1:(HH*WW*2)));
        channel2_filter2 = reshape(channel1_filter1, OH,OW); 

        channel3_filter2 = transpose(dout_row(HH*WW*1+1:(HH*WW*2),i)) * transpose(X_col(:, HH*WW*2+1:(HH*WW*3))); 
        channel3_filter2 = reshape(channel1_filter1, OH,OW); 

        conv(i,1,1,:,:) = channel1_filter1;
        conv(i,1,2,:,:) = channel2_filter1;
        conv(i,1,3,:,:) = channel3_filter1;

        conv(i,2,1,:,:) = channel1_filter2;
        conv(i,2,2,:,:) = channel2_filter2;
        conv(i,2,3,:,:) = channel3_filter2;
            
       conv_out = sum(conv,1); 
       dw = reshape(conv_out, w_dim); 
       %dw_dim = size(dw);   
    end; 


    % FIND DB
    %=============================
    %=============================
    %db = zeros(N,F,HH,WW); 
%     for i = 1:1:N
%       for j = 1:1:F 
%           db(i,j,:,:) = 1 * dout(i,j,:,:); 
%       end; 
%     end; 
    db = 1*dout; 

    %db_dim = size(db);
    db = sum(db,1); 
    %db_dim = size(db); 
    db = sum(db,3); 
    %db_dim = size(db) ;
    db = sum(db,4); 
    %db_dim = size(db);
end



  

