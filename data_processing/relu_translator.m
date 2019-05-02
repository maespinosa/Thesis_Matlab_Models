% fclose('all'); 
% clear all; 
% close all; 




%% RELU1 - Get Truth Data from Python file

num_channels = 96; 
height = 55; 
width = 55; 

disp('Getting truth data from Python bin file')

relu1_file = fopen('.\python_bins\relu1.bin');

relu1_read = fread(relu1_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(relu1_read);

relu1 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            relu1(HH,WW,channels) = relu1_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

relu1_permute = permute(relu1,[2,1,3]); 
relu1_reshape = reshape(relu1_permute,[height*width*num_channels,1]);

relu1_char_8bit = []; 
relu1_char_32bit = [];
for i = 1:1:length(relu1_reshape)
    hex = dec_to_hex_single(relu1_reshape(i));  %
    relu1_char_32bit = [relu1_char_32bit; hex];
    relu1_char_8bit = [relu1_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing relu1 TXT File ...')
relu1_char_size_8bit = size(relu1_char_8bit);
relu1_char_size_8bit(1);
relu1_char_size_32bit = size(relu1_char_32bit);
relu1_char_size_32bit(1);
relu1_reshape_size = size(relu1_reshape); 

fileID = fopen('.\script_txts\relu1_8bit.txt','w');
for i = 1:1:relu1_char_size_8bit(1)
    data = relu1_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\relu1_truth.bin','w');
for i = 1:1:relu1_reshape_size(1)
    data = relu1_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\relu1_32bit.txt','w');
for i = 1:1:relu1_char_size_32bit(1)
    data = relu1_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);



%% RELU2 - Get Truth Data from Python file

num_channels = 256; 
height = 27; 
width = 27; 

disp('Getting truth data from Python bin file')

relu2_file = fopen('.\python_bins\relu2.bin');

relu2_read = fread(relu2_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(relu2_read);

relu2 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            relu2(HH,WW,channels) = relu2_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

relu2_permute = permute(relu2,[2,1,3]); 
relu2_reshape = reshape(relu2_permute,[height*width*num_channels,1]);

relu2_char_8bit = []; 
relu2_char_32bit = [];
for i = 1:1:length(relu2_reshape)
    hex = dec_to_hex_single(relu2_reshape(i));  %
    relu2_char_32bit = [relu2_char_32bit; hex];
    relu2_char_8bit = [relu2_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing relu2 TXT File ...')
relu2_char_size_8bit = size(relu2_char_8bit);
relu2_char_size_8bit(1);
relu2_char_size_32bit = size(relu2_char_32bit);
relu2_char_size_32bit(1);
relu2_reshape_size = size(relu2_reshape); 

fileID = fopen('.\script_txts\relu2_8bit.txt','w');
for i = 1:1:relu2_char_size_8bit(1)
    data = relu2_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\relu2_truth.bin','w');
for i = 1:1:relu2_reshape_size(1)
    data = relu2_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\relu2_32bit.txt','w');
for i = 1:1:relu2_char_size_32bit(1)
    data = relu2_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);




%% RELU3 - Get Truth Data from Python file

num_channels = 384; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

relu3_file = fopen('.\python_bins\relu3.bin');

relu3_read = fread(relu3_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(relu3_read);

relu3 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            relu3(HH,WW,channels) = relu3_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

relu3_permute = permute(relu3,[2,1,3]); 
relu3_reshape = reshape(relu3_permute,[height*width*num_channels,1]);

relu3_char_8bit = []; 
relu3_char_32bit = [];
for i = 1:1:length(relu3_reshape)
    hex = dec_to_hex_single(relu3_reshape(i));  %
    relu3_char_32bit = [relu3_char_32bit; hex];
    relu3_char_8bit = [relu3_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing relu3 TXT File ...')
relu3_char_size_8bit = size(relu3_char_8bit);
relu3_char_size_8bit(1);
relu3_char_size_32bit = size(relu3_char_32bit);
relu3_char_size_32bit(1);
relu3_reshape_size = size(relu3_reshape); 

fileID = fopen('.\script_txts\relu3_8bit.txt','w');
for i = 1:1:relu3_char_size_8bit(1)
    data = relu3_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\relu3_truth.bin','w');
for i = 1:1:relu3_reshape_size(1)
    data = relu3_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\relu3_32bit.txt','w');
for i = 1:1:relu3_char_size_32bit(1)
    data = relu3_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);






%% RELU4 - Get Truth Data from Python file

num_channels = 384; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

relu4_file = fopen('.\python_bins\relu4.bin');

relu4_read = fread(relu4_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(relu4_read);

relu4 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            relu4(HH,WW,channels) = relu4_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

relu4_permute = permute(relu4,[2,1,3]); 
relu4_reshape = reshape(relu4_permute,[height*width*num_channels,1]);

relu4_char_8bit = []; 
relu4_char_32bit = [];
for i = 1:1:length(relu4_reshape)
    hex = dec_to_hex_single(relu4_reshape(i));  %
    relu4_char_32bit = [relu4_char_32bit; hex];
    relu4_char_8bit = [relu4_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing relu4 TXT File ...')
relu4_char_size_8bit = size(relu4_char_8bit);
relu4_char_size_8bit(1);
relu4_char_size_32bit = size(relu4_char_32bit);
relu4_char_size_32bit(1);
relu4_reshape_size = size(relu4_reshape); 

fileID = fopen('.\script_txts\relu4_8bit.txt','w');
for i = 1:1:relu4_char_size_8bit(1)
    data = relu4_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\relu4_32bit.bin','w');
for i = 1:1:relu4_reshape_size(1)
    data = relu4_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\relu4_32bit.txt','w');
for i = 1:1:relu4_char_size_32bit(1)
    data = relu4_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);





%% RELU5 - Get Truth Data from Python file

num_channels = 256; 
height = 6; 
width = 6; 

disp('Getting truth data from Python bin file')

relu5_file = fopen('.\python_bins\relu5.bin');

relu5_read = fread(relu5_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(relu5_read);

relu5 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            relu5(HH,WW,channels) = relu5_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

relu5_permute = permute(relu5,[2,1,3]); 
relu5_reshape = reshape(relu5_permute,[height*width*num_channels,1]);

relu5_char_8bit = []; 
relu5_char_32bit = [];
for i = 1:1:length(relu5_reshape)
    hex = dec_to_hex_single(relu5_reshape(i));  %
    relu5_char_32bit = [relu5_char_32bit; hex];
    relu5_char_8bit = [relu5_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing relu5 TXT File ...')
relu5_char_size_8bit = size(relu5_char_8bit);
relu5_char_size_8bit(1);
relu5_char_size_32bit = size(relu5_char_32bit);
relu5_char_size_32bit(1);
relu5_reshape_size = size(relu5_reshape); 

fileID = fopen('.\script_txts\relu5_8bit.txt','w');
for i = 1:1:relu5_char_size_8bit(1)
    data = relu5_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\relu5_truth.bin','w');
for i = 1:1:relu5_reshape_size(1)
    data = relu5_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\relu5_32bit.txt','w');
for i = 1:1:relu5_char_size_32bit(1)
    data = relu5_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);