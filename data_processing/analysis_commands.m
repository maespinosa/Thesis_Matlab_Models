% F = 2; 
% Stride = 4; 
% 
% W1_eval = W1_single(F,:,:,:);
% 
% W1_eval_red = permute(W1_eval(1,1,:,:),[3,4,1,2]);
% W1_eval_green = permute(W1_eval(1,2,:,:),[3,4,1,2]);
% W1_eval_blue = permute(W1_eval(1,3,:,:),[3,4,1,2]);
% 
% 
% image_eval_red = permute(image_4d(1,1,:,:),[3,4,1,2]);
% image_eval_green = permute(image_4d(1,2,:,:),[3,4,1,2]);
% image_eval_blue = permute(image_4d(1,3,:,:),[3,4,1,2]);
% 
% mult_eval_red = W1_eval_red .* image_eval_red(1+Stride:11+Stride,1:11);
% mult_eval_green = W1_eval_green .* image_eval_green(1+Stride:11+Stride,1:11);
% mult_eval_blue = W1_eval_blue .* image_eval_blue(1+Stride:11+Stride,1:11);
% 
% mult_eval_all = mult_eval_red + mult_eval_green + mult_eval_blue;
% sum_rows_columns = sum(sum(mult_eval_all));
% dec_to_hex_single(sum_rows_columns)
% 
% 
% out_eval = permute(out(1,1,:,:),[3,4,1,2]);


stride = 4; 
pad = 0; 

output_height = 55; 
output_width = 55; 
output_channels = 96; 

[WF,WC, WH, WW] = size(W1_single); 
[N, IC, IH, IW] = size(image_4d); 

channels_allowed = 3;%floor(33/5); 
channel_counter = 0; 
iterations_required = IC/channels_allowed; 
conv_subset = zeros(output_channels*output_height*output_width,1); 



index  = 1;
W1_subset = W1_single(:,1+channel_counter:channels_allowed+channel_counter, :,:); 
image_subset = image_4d(:,1+channel_counter:channels_allowed+channel_counter, :, :); 

image_subset_padded = zeros(1,channels_allowed,IH + pad*2, IW + pad*2); 
image_subset_padded(:,:,1+pad:pad+IH, 1+pad:pad+IW) = image_subset; 
W_stride_counter = 1; 
H_stride_counter = 1; 

for OH = 1:1:1%output_height
    OH;  
    for Filters = 1:1:3%WF
        WF;  
        W_stride_counter = 1; 
        for OW = 1:1:output_width
            OW; 
            W_stride_counter; 
            mult = W1_subset(Filters,:,:,:).*image_subset_padded(:,:,H_stride_counter:H_stride_counter+WH-1, W_stride_counter:W_stride_counter+WW-1); 
            size(mult);
            conv_subset(index,1) = conv_subset(index,1) + sum(sum(sum(mult)));
            index= index + 1;  
            W_stride_counter = W_stride_counter + 4; 
        end; 
    end; 

    H_stride_counter = H_stride_counter + 4; 
end; 

%      hex_out_data = []; 
%      for j=1:1:length(conv_subset)
%          hex = dec_to_hex_single(conv_subset(j)); 
%          hex_out_data = [hex_out_data; hex]; 
%      end 
% 
%  % Write Conv Output Sim File 
% disp('Write Conv Output Rearranged File ')
% fileID = fopen('.\conv1_compare.txt','a');
% for k = 1:1:length(conv_subset)
%     data = hex_out_data(k,:);  
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

channel_counter = channel_counter + channels_allowed

permute(image_subset,[3,4,2,1]);
ans(:,:,1);

    
F = 1; 
SH = 4*2;
SW = 0; 
W1_1 = W1_single(F,1,:,:); 
W1_1 = permute(W1_1,[3,4,1,2]); 

W1_2 = W1_single(F,2,:,:); 
W1_2 = permute(W1_2,[3,4,1,2]); 

W1_3 = W1_single(F,3,:,:); 
W1_3 = permute(W1_3,[3,4,1,2]); 




filter_pad = zeros(1,1,WH,WW); 

image_1 = filter_pad;  
image_1 = image_subset_padded(1,1,1+SH:WH+SH,1+SW:WW+SW); 
image_1 = permute(image_1, [3,4,1,2]); 

image_2 = filter_pad;  
image_2 = image_subset_padded(1,2,1+SH:WH+SH,1+SW:WW+SW); 
image_2 = permute(image_2, [3,4,1,2]); 

image_3 = filter_pad;  
image_3 = image_subset_padded(1,3,1+SH:WH+SH,1+SW:WW+SW); 
image_3 = permute(image_3, [3,4,1,2]);

mult_1 = image_1(1:11,1:11).*W1_1; 
mult_2 = image_2(1:11,1:11).*W1_2; 
mult_3 = image_3(1:11,1:11).*W1_3; 


adder1 = sum(mult_1,1) + sum(mult_2,1) + sum(mult_3,1); 

kernel_sum = dec_to_hex_single(sum(adder1))
