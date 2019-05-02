output_height = 1; 
output_channels = 4096; 

[WF,WC, WH, WW] = size(W6_single); 
[N, IC, IH, IW] = size(image_4d); 

channels_allowed = 4; %floor(33/5); 
channel_counter = 0; 
channel_iterations_required = IC/channels_allowed; 
%filter_iterations_required = 2; 
filters_in_subset = 4096; 
%affine_subset = zeros((output_channels/filter_iterations_required)*output_height,1); 
affine_subset = zeros((output_channels)*output_height,1); 

for z = 1:1:channel_iterations_required
    z

    %W6_subset = W6_single(1+filters_in_subset*(i-1):filters_in_subset+filters_in_subset*(i-1),1+channel_counter:channels_allowed+channel_counter, :,:); 
    W6_subset = W6_single(1:filters_in_subset,1+channel_counter:channels_allowed+channel_counter, :,:); 
    %size(W6_subset)
    W6_subset = reshape(permute(W6_subset, [4,3,2,1]),[WW*WH*channels_allowed,filters_in_subset]); 
    %size(W6_subset)
    image_subset = image_4d(:,1+channel_counter:channels_allowed+channel_counter, :, :); 
    %size(image_subset)
    image_subset_reshaped = reshape(permute(image_subset, [4,3,2,1]),[IW*IH*channels_allowed,N]); 
    %size(image_subset)

    mult = transpose(W6_subset)*image_subset_reshaped;
    if(z==1) 
        mult1 = mult; % + b6_read; 
        size(mult1);
    else 
        mult1 = mult;
    end 
    affine_subset = affine_subset + mult1;
    %index= index +1;  

    hex_out_data = []; 
    out_char_8bit = []; 
    for j=1:1:length(affine_subset)
        hex = dec_to_hex_single(affine_subset(j)); 
        hex_out_data = [hex_out_data; hex]; 
        out_char_8bit = [out_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)];
    end 
    
    out_char_8bit_size = size(out_char_8bit)
    out_char_8bit_size(1)

     % Write Conv Output Sim File 
%     disp('Write Conv Output Rearranged File ')
%     fileID = fopen('.\affine_compare_layer6.txt','a');
%     for k = 1:1:length(affine_subset)
%         data = hex_out_data(k,:);  
%         fprintf(fileID, '%s,\n',data);
%     end 
%     fclose(fileID); 
%     
%     fileID = fopen('.\affine_compare_layer6_8bit.txt','a');
%     for i = 1:1:out_char_8bit_size(1)
%         data = out_char_8bit(i,1:2);  
%         fprintf(fileID, '%s\n',data);
%     end 
%     fclose(fileID); 
%     
    fileID = fopen('.\script_bins\fc6_compare.bin','a');
    for j = 1:1:length(affine_subset)
        data = affine_subset(j,:); 
        fwrite(fileID,data,'single');
    end 
    fclose(fileID); 

    channel_counter = channel_counter + channels_allowed; 
end; 
    
F = 4096-48; 
CI = 1; 
W6_1 = W6_single(F,1+channels_allowed*(CI-1),:,:); 
W6_1 = permute(W6_1,[3,4,1,2]); 

W6_2 = W6_single(F,2+channels_allowed*(CI-1),:,:); 
W6_2 = permute(W6_2,[3,4,1,2]); 

W6_3 = W6_single(F,3+channels_allowed*(CI-1),:,:); 
W6_3 = permute(W6_3,[3,4,1,2]); 

W6_4 = W6_single(F,4+channels_allowed*(CI-1),:,:); 
W6_4 = permute(W6_4,[3,4,1,2]); 

image_1 = image_subset(1,1,:,:); 
image_1 = permute(image_1, [3,4,1,2]); 

image_2 = image_subset(1,2,:,:); 
image_2 = permute(image_2, [3,4,1,2]); 

image_3 = image_subset(1,3,:,:); 
image_3 = permute(image_3, [3,4,1,2]); 
  
image_4 = image_subset(1,4,:,:); 
image_4 = permute(image_4, [3,4,1,2]); 
  
mult_1 = image_1(1:IH,1:IW).*W6_1; 
mult_2 = image_2(1:IH,1:IW).*W6_2; 
mult_3 = image_3(1:IH,1:IW).*W6_3; 
mult_4 = image_4(1:IH,1:IW).*W6_4; 

adder1 = sum(mult_1,1) + sum(mult_2,1) + sum(mult_3,1) + sum(mult_4,1); %  + b6_read(F); 

dec_to_hex_single(sum(adder1))
