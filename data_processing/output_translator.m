fclose('all'); 
clear all; 
close all; 



%% CONV1 - Get Truth Data from Python file

num_channels = 96; 
height = 55; 
width = 55; 

disp('Getting truth data from Python bin file')

conv1_file = fopen('.\python_bins\conv1.bin');

conv1_read = fread(conv1_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv1_read);

conv1 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            conv1(HH,WW,channels) = conv1_read(index,1); 
            index = index + 1; 
        end 
    end 
end 



%conv1_read_image = reshape(conv1_read, [55,55,96]);
%conv1_read_image = permute(conv1_read_image, [2,1,3]);

%min_value = min(min(conv1_read_image,[],1),[],2);
%adjusted = repmat(abs(min_value),55,55);
%adjusted = adjusted + conv1_read_image; 

%max_value = max(max(adjusted,[],1),[],2); 
%norm_values = repmat(max_value,55,55); 
%conv_image = 255.*(adjusted ./ norm_values); 

%figure(1)
%imshow([uint8(conv_image(:,:,1)),uint8(conv_image(:,:,1)),uint8(conv_image(:,:,1))])

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

conv1_permute = permute(conv1,[2,1,3]); 
conv1_reshape = reshape(conv1_permute,[height*width*num_channels,1]);

conv1_char_8bit = []; 
conv1_char_32bit = [];
for i = 1:1:length(conv1_reshape)
    hex = dec_to_hex_single(conv1_reshape(i));  %
    conv1_char_32bit = [conv1_char_32bit; hex];
    conv1_char_8bit = [conv1_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 


% conv1_hex = []; 
% conv1_hex_8bit = []; 
% for i = 1:1:R
%     hex = dec_to_hex_single(conv1_read(i));  %
%     %hex
%     %size(hex)
%     conv1_hex = [conv1_hex; hex(1:4)]; 
%     conv1_hex_8bit = [conv1_hex_8bit;hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
% end 

%disp('Convert to Decimal from Half Precision Hex')
% 
% conv1_python_data = []; 
% 
% for i = 1:1:R
%     conv1_python_data = [conv1_python_data; hex_to_dec_single([conv1_hex(i,1:4),'0000'])]; 
% end 

disp('Writing conv1 TXT File ...')
% conv1_char_size=size(conv1_hex);
% conv1_char_size(1);
conv1_char_size_8bit = size(conv1_char_8bit);
conv1_char_size_8bit(1);
conv1_char_size_32bit = size(conv1_char_32bit);
conv1_char_size_32bit(1);
conv1_reshape_size = size(conv1_reshape); 

% fileID = fopen('.\conv1_coe.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\conv1.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\conv1_8bit.txt','w');
for i = 1:1:conv1_char_size_8bit(1)
    data = conv1_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\conv1_truth.bin','w');
for i = 1:1:conv1_reshape_size(1)
    data = conv1_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID);

fileID = fopen('.\script_txts\conv1_32bit.txt','w');
for i = 1:1:conv1_char_size_32bit(1)
    data = conv1_char_32bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 




%% CONV2 - Get Truth Data from Python file

num_channels = 256; 
height = 27; 
width = 27; 

disp('Getting truth data from Python bin file')

conv2_file = fopen('.\python_bins\conv2.bin');

conv2_read = fread(conv2_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv2_read);

conv2 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            conv2(HH,WW,channels) = conv2_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

conv2_permute = permute(conv2,[2,1,3]); 
conv2_reshape = reshape(conv2_permute,[height*width*num_channels,1]);

conv2_char_8bit = []; 
conv2_char_32bit = [];
for i = 1:1:length(conv2_reshape)
    hex = dec_to_hex_single(conv2_reshape(i));  %
    conv2_char_32bit = [conv2_char_32bit; hex];
    conv2_char_8bit = [conv2_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 


disp('Writing conv2 TXT File ...')
% conv1_char_size=size(conv1_hex);
% conv1_char_size(1);
conv2_char_size_8bit = size(conv2_char_8bit);
conv2_char_size_8bit(1);
conv2_char_size_32bit = size(conv2_char_32bit);
conv2_char_size_32bit(1);
conv2_reshape_size = size(conv2_reshape); 

% fileID = fopen('.\conv1_coe.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\conv1.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\conv2_8bit.txt','w');
for i = 1:1:conv2_char_size_8bit(1)
    data = conv2_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\conv2_truth.bin','w');
for i = 1:1:conv2_reshape_size(1)
    data = conv2_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID);

fileID = fopen('.\script_txts\conv2_32bit.txt','w');
for i = 1:1:conv2_char_size_32bit(1)
    data = conv2_char_32bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 




%% CONV3 - Get Truth Data from Python file

num_channels = 384; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

conv3_file = fopen('.\python_bins\conv3.bin');

conv3_read = fread(conv3_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv3_read);

conv3 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            conv3(HH,WW,channels) = conv3_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

conv3_permute = permute(conv3,[2,1,3]); 
conv3_reshape = reshape(conv3_permute,[height*width*num_channels,1]);

conv3_char_8bit = []; 
conv3_char_32bit = [];
for i = 1:1:length(conv3_reshape)
    hex = dec_to_hex_single(conv3_reshape(i));  %
    conv3_char_32bit = [conv3_char_32bit; hex];
    conv3_char_8bit = [conv3_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 


disp('Writing conv3 TXT File ...')
% conv1_char_size=size(conv1_hex);
% conv1_char_size(1);
conv3_char_size_8bit = size(conv3_char_8bit);
conv3_char_size_8bit(1);
conv3_char_size_32bit = size(conv3_char_32bit);
conv3_char_size_32bit(1);
conv3_reshape_size = size(conv3_reshape); 

% fileID = fopen('.\conv1_coe.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\conv1.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\conv3_8bit.txt','w');
for i = 1:1:conv3_char_size_8bit(1)
    data = conv3_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\conv3_truth.bin','w');
for i = 1:1:conv3_reshape_size(1)
    data = conv3_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID);

fileID = fopen('.\script_txts\conv3_32bit.txt','w');
for i = 1:1:conv3_char_size_32bit(1)
    data = conv3_char_32bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

















%% CONV4 - Get Truth Data from Python file

num_channels = 384; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

conv4_file = fopen('.\python_bins\conv4.bin');

conv4_read = fread(conv4_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv4_read);

conv4 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            conv4(HH,WW,channels) = conv4_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

conv4_permute = permute(conv4,[2,1,3]); 
conv4_reshape = reshape(conv4_permute,[height*width*num_channels,1]);

conv4_char_8bit = []; 
conv4_char_32bit = [];
for i = 1:1:length(conv4_reshape)
    hex = dec_to_hex_single(conv4_reshape(i));  %
    conv4_char_32bit = [conv4_char_32bit; hex];
    conv4_char_8bit = [conv4_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 


disp('Writing conv4 TXT File ...')
% conv1_char_size=size(conv1_hex);
% conv1_char_size(1);
conv4_char_size_8bit = size(conv4_char_8bit);
conv4_char_size_8bit(1);
conv4_char_size_32bit = size(conv4_char_32bit);
conv4_char_size_32bit(1);
conv4_reshape_size = size(conv4_reshape); 

% fileID = fopen('.\conv1_coe.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\conv1.txt','w');
% for i = 1:1:conv1_char_size(1)
%     data = conv1_hex(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\conv4_8bit.txt','w');
for i = 1:1:conv4_char_size_8bit(1)
    data = conv4_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\conv4_truth.bin','w');
for i = 1:1:conv4_reshape_size(1)
    data = conv4_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID);

fileID = fopen('.\script_txts\conv4_32bit.txt','w');
for i = 1:1:conv4_char_size_32bit(1)
    data = conv4_char_32bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 






%% CONV5 - Get Truth Data from Python file

num_channels = 256; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

conv5_file = fopen('.\python_bins\conv5.bin');

conv5_read = fread(conv5_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv5_read);

conv5 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            conv5(HH,WW,channels) = conv5_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

conv5_permute = permute(conv5,[2,1,3]); 
conv5_reshape = reshape(conv5_permute,[height*width*num_channels,1]);

conv5_char_8bit = []; 
conv5_char_32bit = [];
for i = 1:1:length(conv5_reshape)
    hex = dec_to_hex_single(conv5_reshape(i));  %
    conv5_char_32bit = [conv5_char_32bit; hex];
    conv5_char_8bit = [conv5_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing conv5 TXT File ...')
conv5_char_size_8bit = size(conv5_char_8bit);
conv5_char_size_8bit(1);
conv5_char_size_32bit = size(conv5_char_32bit);
conv5_char_size_32bit(1);
conv5_reshape_size = size(conv5_reshape); 

fileID = fopen('.\script_txts\conv5_8bit.txt','w');
for i = 1:1:conv5_char_size_8bit(1)
    data = conv5_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\conv5_truth.bin','w');
for i = 1:1:conv5_reshape_size(1)
    data = conv5_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\conv5_32bit.txt','w');
for i = 1:1:conv5_char_size_32bit(1)
    data = conv5_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);




%% Affine1 - Get Truth Data from Python file

num_channels = 4096; 
height = 1; 
width = 1; 

disp('Getting truth data from Python bin file')

affine1_file = fopen('.\python_bins\affine1.bin');

affine1_read = fread(affine1_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(affine1_read);

affine1 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            affine1(HH,WW,channels) = affine1_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

affine1_permute = permute(affine1,[2,1,3]); 
affine1_reshape = reshape(affine1_permute,[height*width*num_channels,1]);

affine1_char_8bit = []; 
affine1_char_32bit = [];
for i = 1:1:length(affine1_reshape)
    hex = dec_to_hex_single(affine1_reshape(i));  %
    affine1_char_32bit = [affine1_char_32bit; hex];
    affine1_char_8bit = [affine1_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing affine1 TXT File ...')
affine1_char_size_8bit = size(affine1_char_8bit);
affine1_char_size_8bit(1);
affine1_char_size_32bit = size(affine1_char_32bit);
affine1_char_size_32bit(1);
affine1_reshape_size = size(affine1_reshape); 

fileID = fopen('.\script_txts\affine1_8bit.txt','w');
for i = 1:1:affine1_char_size_8bit(1)
    data = affine1_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\affine1_truth.bin','w');
for i = 1:1:affine1_reshape_size(1)
    data = affine1_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\affine1_32bit.txt','w');
for i = 1:1:affine1_char_size_32bit(1)
    data = affine1_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);



%% Affine2 - Get Truth Data from Python file

num_channels = 4096; 
height = 1; 
width = 1; 

disp('Getting truth data from Python bin file')

affine2_file = fopen('.\python_bins\affine2.bin');

affine2_read = fread(affine2_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(affine2_read);

affine2 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            affine2(HH,WW,channels) = affine2_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

affine2_permute = permute(affine2,[2,1,3]); 
affine2_reshape = reshape(affine2_permute,[height*width*num_channels,1]);

affine2_char_8bit = []; 
affine2_char_32bit = [];
for i = 1:1:length(affine2_reshape)
    hex = dec_to_hex_single(affine2_reshape(i));  %
    affine2_char_32bit = [affine2_char_32bit; hex];
    affine2_char_8bit = [affine2_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing affine2 TXT File ...')
affine2_char_size_8bit = size(affine2_char_8bit);
affine2_char_size_8bit(1);
affine2_char_size_32bit = size(affine2_char_32bit);
affine2_char_size_32bit(1);
affine2_reshape_size = size(affine2_reshape); 

fileID = fopen('.\script_txts\affine2_8bit.txt','w');
for i = 1:1:affine2_char_size_8bit(1)
    data = affine2_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\affine2_truth.bin','w');
for i = 1:1:affine2_reshape_size(1)
    data = affine2_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\affine2_32bit.txt','w');
for i = 1:1:affine2_char_size_32bit(1)
    data = affine2_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);




%% Affine3 - Get Truth Data from Python file

num_channels = 10; 
height = 1; 
width = 1; 

disp('Getting truth data from Python bin file')

affine3_file = fopen('.\python_bins\affine3.bin');

affine3_read = fread(affine3_file,[num_channels*height*width,1],'double'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(affine3_read);

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

fclose('all');
   

disp('Convert to Floating Point Single Precision Hex'); 

affine3_permute = permute(affine3,[2,1,3]); 
affine3_reshape = reshape(affine3_permute,[height*width*num_channels,1]);

affine3_char_8bit = []; 
affine3_char_32bit = [];
for i = 1:1:length(affine3_reshape)
    hex = dec_to_hex_single(affine3_reshape(i));  %
    affine3_char_32bit = [affine3_char_32bit; hex];
    affine3_char_8bit = [affine3_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end 

disp('Writing affine3 TXT File ...')
affine3_char_size_8bit = size(affine3_char_8bit);
affine3_char_size_8bit(1);
affine3_char_size_32bit = size(affine3_char_32bit);
affine3_char_size_32bit(1);
affine3_reshape_size = size(affine3_reshape); 

fileID = fopen('.\script_txts\affine3_8bit.txt','w');
for i = 1:1:affine3_char_size_8bit(1)
    data = affine3_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 


fileID = fopen('.\script_bins\affine3_truth.bin','w');
for i = 1:1:affine3_reshape_size(1)
    data = affine3_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

fileID = fopen('.\script_txts\affine3_32bit.txt','w');
for i = 1:1:affine3_char_size_32bit(1)
    data = affine3_char_32bit(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID);



%% Test Out - Get Data from Test file

num_channels = 10; 
height = 1; 
width = 1; 

disp('Getting data from Test bin file')

test_file = fopen('.\test_bins\conv_test_output_layer8.bin');

test_read = fread(test_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(test_read)

test = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            test(HH,WW,channels) = test_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

max(max(test))

