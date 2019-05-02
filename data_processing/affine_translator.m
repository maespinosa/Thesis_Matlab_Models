fclose('all'); 
clear all; 
close all; 

%% Convert AFFINE3 Data
disp('Converting AFFINE3 data')

affine3_file = fopen('.\affine3.bin');
num_channels = 10; 
height = 1; 
width = 1; 

affine3_read = fread(affine3_file,[num_channels*height*width,1],'double');
affine3 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            affine3(HH,WW,channels) = affine3_read(index,1); 
            index = index + 1; 
        end 
    end 
    
end 

affine3_array = reshape(affine3,[height*width*num_channels,1]);

fclose('all');

affine3_permute = permute(affine3,[2,1,3]); 
affine3_reshape = reshape(affine3_permute,[height*width*num_channels,1]);
%affine3_char = num2hex(single(affine3_reshape)); 
affine3_reshape_size = size(affine3_reshape); 

affine3_char_8bit = []; 
for i = 1:1:length(affine3_read) 
    hex = dec_to_hex_single(affine3_read(i))  %
    affine3_char_8bit = [affine3_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 
   

%% WRITE AFFINE3 TXT FILE
disp('Writing AFFINE3 TXT File ...')

%affine3_char_size=size(affine3_char);
%affine3_char_size(1);
affine3_char_size_8bit = size(affine3_char_8bit); 
affine3_char_size_8bit(1); 


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

fileID = fopen('.\affine3_8bit.txt','w');
for i = 1:1:affine3_char_size_8bit(1)
    data = affine3_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\affine3_truth.bin','w');
for i = 1:1:length(affine3_read)
    data = affine3_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 



