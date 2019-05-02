stride = 1; 
pad = 1; 
output_height = 13; 
output_width = 13; 
output_channels = 256; 

[WF,WC, WH, WW] = size(W5_single); 
[N, IC, IH, IW] = size(image_4d); 

channels_allowed = 8;%floor(33/3) 
channel_counter = 0; 
iterations_required = IC/channels_allowed
conv_subset = zeros(output_channels*output_height*output_width,1); 
 
for i = 1:1:iterations_required
    i
    index  = 1;
    W5_subset = W5_single(:,1+channel_counter:channels_allowed+channel_counter, :,:); 
    image_subset = image_4d(:,1+channel_counter:channels_allowed+channel_counter, :, :); 

    image_subset_padded = zeros(1,channels_allowed,IH + pad*2, IW + pad*2); 
    image_subset_padded(:,:,1+pad:pad+IH, 1+pad:pad+IW) = image_subset; 

  
%     for OH = 1:1:output_height
%         OH;  
%         for Filters = 1:1:WF
%             WF;  
%             for OW = 1:1:output_width
%                 OW; 
%                 mult = W5_subset(Filters,:,:,:).*image_subset_padded(:,:,OH:OH+WH-1, OW:OW+WW-1); 
%                 size(mult);
%                 conv_subset(index,1) = conv_subset(index,1) + sum(sum(sum(mult)));
%                 index= index +1;  
%             end; 
%         end; 
%     end; 
    
    for Filters = 1:1:WF
        WF;
        for OH = 1:1:output_height
            OH;   
            for OW = 1:1:output_width
                OW; 
                mult = W5_subset(Filters,:,:,:).*image_subset_padded(:,:,OH:OH+WH-1, OW:OW+WW-1); 
                size(mult);
                conv_subset(index,1) = conv_subset(index,1) + sum(sum(sum(mult)));
                index= index +1;  
            end; 
        end; 
    end; 
    
    
    hex_out_data = []; 
    out_char_8bit = [];
    for j=1:1:length(conv_subset)
        hex = dec_to_hex_single(conv_subset(j)); 
        hex_out_data = [hex_out_data; hex]; 
        out_char_8bit = [out_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)];
    end 
    
    out_char_8bit_size = size(out_char_8bit)
    out_char_8bit_size(1)
       
%      % Write Conv Output Sim File 
%     disp('Write Conv Output Rearranged File ')
%     fileID = fopen('.\conv5_compare.txt','a');
%     for k = 1:1:length(conv_subset)
%         data = hex_out_data(k,:);  
%         fprintf(fileID, '%s\n',data);
%     end 
%     fclose(fileID); 
%     
%     fileID = fopen('.\conv5_compare_8bit.txt','a');
%     for i = 1:1:out_char_8bit_size(1)
%         data = out_char_8bit(i,1:2);  
%         fprintf(fileID, '%s\n',data);
%     end 
%     fclose(fileID);
    
    fileID = fopen('.\script_bins\conv5_compare.bin','a');
    for j = 1:1:length(conv_subset)
        data = conv_subset(j,:); 
        fwrite(fileID,data,'single');
    end 
    fclose(fileID); 

    channel_counter = channel_counter + channels_allowed
end; 
    
F = 1; 
SH = 0;
SW = 0; 
W5_1 = W5_single(F,1+8*(iterations_required-1),:,:); 
W5_1 = permute(W5_1,[3,4,1,2]); 

W5_2 = W5_single(F,2+8*(iterations_required-1),:,:); 
W5_2 = permute(W5_2,[3,4,1,2]); 

W5_3 = W5_single(F,3+8*(iterations_required-1),:,:); 
W5_3 = permute(W5_3,[3,4,1,2]); 

W5_4 = W5_single(F,4+8*(iterations_required-1),:,:); 
W5_4 = permute(W5_4,[3,4,1,2]); 

W5_5 = W5_single(F,5+8*(iterations_required-1),:,:); 
W5_5 = permute(W5_5,[3,4,1,2]); 

W5_6 = W5_single(F,6+8*(iterations_required-1),:,:); 
W5_6 = permute(W5_6,[3,4,1,2]); 

W5_7 = W5_single(F,7+8*(iterations_required-1),:,:); 
W5_7 = permute(W5_7,[3,4,1,2]); 

W5_8 = W5_single(F,8+8*(iterations_required-1),:,:); 
W5_8 = permute(W5_8,[3,4,1,2]); 


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

image_4 = filter_pad;  
image_4 = image_subset_padded(1,4,1+SH:WH+SH,1+SW:WW+SW); 
image_4 = permute(image_4, [3,4,1,2]); 

image_5 = filter_pad;  
image_5 = image_subset_padded(1,5,1+SH:WH+SH,1+SW:WW+SW); 
image_5 = permute(image_5, [3,4,1,2]); 

image_6 = filter_pad;  
image_6 = image_subset_padded(1,6,1+SH:WH+SH,1+SW:WW+SW); 
image_6 = permute(image_6, [3,4,1,2]); 

image_7 = filter_pad;  
image_7 = image_subset_padded(1,7,1+SH:WH+SH,1+SW:WW+SW); 
image_7 = permute(image_7, [3,4,1,2]); 

image_8 = filter_pad;  
image_8 = image_subset_padded(1,8,1+SH:WH+SH,1+SW:WW+SW); 
image_8 = permute(image_8, [3,4,1,2]); 

mult_1 = image_1(1:3,1:3).*W5_1; 
mult_2 = image_2(1:3,1:3).*W5_2; 
mult_3 = image_3(1:3,1:3).*W5_3; 
mult_4 = image_4(1:3,1:3).*W5_4; 
mult_5 = image_5(1:3,1:3).*W5_5; 
mult_6 = image_6(1:3,1:3).*W5_6; 
mult_7 = image_7(1:3,1:3).*W5_7; 
mult_8 = image_8(1:3,1:3).*W5_8; 

adder1 = sum(mult_1,1) + sum(mult_2,1) + sum(mult_3,1) + sum(mult_4,1) + sum(mult_5,1) + sum(mult_6,1) + sum(mult_7,1) + sum(mult_8,1);  

dec_to_hex_single(sum(adder1))
