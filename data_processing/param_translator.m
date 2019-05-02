fclose('all'); 
clear all; 
close all; 

%W6_file = fopen('.\W6.bin');
% W7_file = fopen('.\W7_tensorflow.bin');
% W8_file = fopen('.\W8_tensorflow.bin');


%% Convert W1 Data
disp('Converting W1 data')
W1_file = fopen('.\python_bins\W1.bin');
W1_num_filters = 96; 
W1_num_channels = 3; 
W1_height = 11; 
W1_width = 11; 

W1_read = fread(W1_file,[W1_num_filters*W1_num_channels*W1_height*W1_width,1],'double');
W1 = zeros(W1_height,W1_width,W1_num_channels,W1_num_filters);

index = 1; 

for filters = 1:1:W1_num_filters 
    for channels = 1:1:W1_num_channels
        for HH = 1:1:W1_height
            for WW = 1:1:W1_width
                W1(HH,WW,channels,filters) = W1_read(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 

W1_array = reshape(W1,[W1_height*W1_width*W1_num_channels*W1_num_filters,1]);

%% Writing W1 TXT File
disp('Writing W1 TXT File ...')

W1_permute = permute(W1,[2,1,3,4]); 
W1_reshape = reshape(W1_permute,[W1_height*W1_width*W1_num_channels*W1_num_filters,1]);

W1_char = []; 
W1_char_8bit = []; 
for i = 1:1:length(W1_reshape)
    char_data = dec_to_hex_single(W1_reshape(i)); 
    W1_char = [W1_char; dec_to_hex_single(W1_reshape(i))]; 
    W1_char_8bit = [W1_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
end 

W1_char_size=size(W1_char)
W1_char_size(1)
W1_char_8bit_size =size(W1_char_8bit)
W1_char_8bit_size(1)

fileID = fopen('.\script_txts\W1_coe.txt','w');
for i = 1:1:W1_char_size(1)
    data = W1_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\W1.txt','w');
for i = 1:1:W1_char_size(1)
    data = W1_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\W1_8bit.txt','w');
for i = 1:1:W1_char_8bit_size(1)
    data = W1_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\W1_single.bin','w');
for i = 1:1:length(W1_read)
    data = W1_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert W2 Data
disp('Converting W2 data')
W2_file = fopen('.\python_bins\W2.bin');
W2_num_filters = 256; 
W2_num_channels = 96; 
W2_height = 5; 
W2_width = 5; 

W2_read = fread(W2_file,[W2_num_filters*W2_num_channels*W2_height*W2_width,1],'double');
W2 = zeros(W2_height,W2_width,W2_num_channels,W2_num_filters);

index = 1; 

for filters = 1:1:W2_num_filters 
    for channels = 1:1:W2_num_channels
        for HH = 1:1:W2_height
            for WW = 1:1:W2_width
                W2(HH,WW,channels,filters) = W2_read(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 

W2_array = reshape(W2,[W2_height*W2_width*W2_num_channels*W2_num_filters,1]);

%% Writing W2 TXT File
disp('Writing W2 TXT File ...')

W2_permute = permute(W2,[2,1,3,4]); 
W2_reshape = reshape(W2_permute,[W2_height*W2_width*W2_num_channels*W2_num_filters,1]);

W2_char = []; 
W2_char_8bit = []; 
for i = 1:1:length(W2_reshape)
    char_data = dec_to_hex_single(W2_reshape(i)); 
    W2_char = [W2_char; dec_to_hex_single(W2_reshape(i))]; 
    W2_char_8bit = [W2_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
end 

W2_char_size=size(W2_char)
W2_char_size(1)
W2_char_8bit_size =size(W2_char_8bit)
W2_char_8bit_size(1)

% fileID = fopen('.\W2_coe.txt','w');
% for i = 1:1:W2_char_size(1)
%     data = W2_char(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\W2.txt','w');
% for i = 1:1:W2_char_size(1)
%     data = W2_char(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\W2_8bit.txt','w');
% for i = 1:1:W2_char_8bit_size(1)
%     data = W2_char_8bit(i,1:2); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_bins\W2_single.bin','w');
for i = 1:1:length(W2_read)
    data = W2_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert W3 Data
disp('Converting W3 data')
W3_file = fopen('.\python_bins\W3.bin');
W3_num_filters = 384; 
W3_num_channels = 256; 
W3_height = 3; 
W3_width = 3; 

W3_read = fread(W3_file,[W3_num_filters*W3_num_channels*W3_height*W3_width,1],'double');
W3 = zeros(W3_height,W3_width,W3_num_channels,W3_num_filters);

index = 1; 

for filters = 1:1:W3_num_filters 
    for channels = 1:1:W3_num_channels
        for HH = 1:1:W3_height
            for WW = 1:1:W3_width
                W3(HH,WW,channels,filters) = W3_read(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 

W3_array = reshape(W3,[W3_height*W3_width*W3_num_channels*W3_num_filters,1]);

%% Writing W3 TXT File
disp('Writing W3 TXT File ...')

W3_permute = permute(W3,[2,1,3,4]); 
W3_reshape = reshape(W3_permute,[W3_height*W3_width*W3_num_channels*W3_num_filters,1]);

W3_char = []; 
W3_char_8bit = []; 
for i = 1:1:length(W3_reshape)
    char_data = dec_to_hex_single(W3_reshape(i)); 
    W3_char = [W3_char; dec_to_hex_single(W3_reshape(i))]; 
    W3_char_8bit = [W3_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
end 

W3_char_size=size(W3_char)
W3_char_size(1)
W3_char_8bit_size =size(W3_char_8bit)
W3_char_8bit_size(1)

fileID = fopen('.\script_txts\W3_coe.txt','w');
for i = 1:1:W3_char_size(1)
    data = W3_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\W3.txt','w');
for i = 1:1:W3_char_size(1)
    data = W3_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txt\W3_8bit.txt','w');
for i = 1:1:W3_char_8bit_size(1)
    data = W3_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\W3_single.bin','w');
for i = 1:1:length(W3_read)
    data = W3_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert W4 Data
disp('Converting W4 data')
W4_file = fopen('.\python_bins\W4.bin');
W4_num_filters = 384; 
W4_num_channels = 384; 
W4_height = 3; 
W4_width = 3; 

W4_read = fread(W4_file,[W4_num_filters*W4_num_channels*W4_height*W4_width,1],'double');
W4 = zeros(W4_height,W4_width,W4_num_channels,W4_num_filters);

index = 1; 

for filters = 1:1:W4_num_filters 
    for channels = 1:1:W4_num_channels
        for HH = 1:1:W4_height
            for WW = 1:1:W4_width
                W4(HH,WW,channels,filters) = W4_read(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 

W4_array = reshape(W4,[W4_height*W4_width*W4_num_channels*W4_num_filters,1]);

%% Writing W4 TXT File
disp('Writing W4 TXT File ...')

W4_permute = permute(W4,[2,1,3,4]); 
W4_reshape = reshape(W4_permute,[W4_height*W4_width*W4_num_channels*W4_num_filters,1]);

W4_char = []; 
W4_char_8bit = []; 
for i = 1:1:length(W4_reshape)
    char_data = dec_to_hex_single(W4_reshape(i)); 
    W4_char = [W4_char; dec_to_hex_single(W4_reshape(i))]; 
    W4_char_8bit = [W4_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
end 

W4_char_size=size(W4_char)
W4_char_size(1)
W4_char_8bit_size =size(W4_char_8bit)
W4_char_8bit_size(1)

fileID = fopen('.\script_txts\W4_coe.txt','w');
for i = 1:1:W4_char_size(1)
    data = W4_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\W4.txt','w');
for i = 1:1:W4_char_size(1)
    data = W4_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\W4_8bit.txt','w');
for i = 1:1:W4_char_8bit_size(1)
    data = W4_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\W4_single.bin','w');
for i = 1:1:length(W4_read)
    data = W4_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 





%% Convert W5 Data
disp('Converting W5 data')
W5_file = fopen('.\python_bins\W5.bin');
W5_num_filters = 256; 
W5_num_channels = 384; 
W5_height = 3; 
W5_width = 3; 

W5_read = fread(W5_file,[W5_num_filters*W5_num_channels*W5_height*W5_width,1],'double');
W5 = zeros(W5_height,W5_width,W5_num_channels,W5_num_filters);

index = 1; 

for filters = 1:1:W5_num_filters 
    for channels = 1:1:W5_num_channels
        for HH = 1:1:W5_height
            for WW = 1:1:W5_width
                W5(HH,WW,channels,filters) = W5_read(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 

W5_array = reshape(W5,[W5_height*W5_width*W5_num_channels*W5_num_filters,1]);

%% Writing W5 TXT File
disp('Writing W5 TXT File ...')

W5_permute = permute(W5,[2,1,3,4]); 
W5_reshape = reshape(W5_permute,[W5_height*W5_width*W5_num_channels*W5_num_filters,1]);

W5_char = []; 
W5_char_8bit = []; 
for i = 1:1:length(W5_reshape)
    char_data = dec_to_hex_single(W5_reshape(i)); 
    W5_char = [W5_char; dec_to_hex_single(W5_reshape(i))]; 
    W5_char_8bit = [W5_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
end 

W5_char_size=size(W5_char)
W5_char_size(1)
W5_char_8bit_size =size(W5_char_8bit)
W5_char_8bit_size(1)

fileID = fopen('.\script_txts\W5_coe.txt','w');
for i = 1:1:W5_char_size(1)
    data = W5_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\W5.txt','w');
for i = 1:1:W5_char_size(1)
    data = W5_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\W5_8bit.txt','w');
for i = 1:1:W5_char_8bit_size(1)
    data = W5_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\W5_single.bin','w');
for i = 1:1:length(W5_read)
    data = W5_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 



fclose('all');




