fclose('all'); 
clear all; 
close all; 

%% Convert SOFTMAX Data
disp('Converting SOFTMAX data')

softmax_file = fopen('.\python_bins\softmax.bin');
num_channels = 10; 
height = 1; 
width = 1; 

softmax_read = fread(softmax_file,[num_channels*height*width,1],'double');
softmax = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            softmax(HH,WW,channels) = softmax_read(index,1); 
            index = index + 1; 
        end 
    end 
    
end 

fclose('all');

softmax_permute = permute(softmax,[2,1,3]); 
softmax_reshape = reshape(softmax_permute,[height*width*num_channels,1]);
%affine3_char = num2hex(single(affine3_reshape)); 
softmax_reshape_size = size(softmax_reshape); 

softmax_char_8bit = []; 
for i = 1:1:length(softmax_read) 
    hex = dec_to_hex_single(softmax_read(i))  %
    softmax_char_8bit = [softmax_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 
   

%% WRITE AFFINE3 TXT FILE
disp('Writing SOFTMAX TXT File ...')

%affine3_char_size=size(affine3_char);
%affine3_char_size(1);
softmax_char_size_8bit = size(softmax_char_8bit); 
softmax_char_size_8bit(1); 


% fileID = fopen('.\affine3_coe.txt','w');
% for i = 1:1:affine3_char_size(1)
%     data = affine3_char(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\affine3.txt','w');
% for i = 1:1:affine3_char_size(1)
%     data = affine3_char(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\softmax_8bit.txt','w');
for i = 1:1:softmax_char_size_8bit(1)
    data = softmax_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\softmax_truth.bin','w');
for i = 1:1:length(softmax_read)
    data = softmax_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 



