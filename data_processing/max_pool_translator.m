fclose('all'); 
clear all; 
close all; 



%% Convert mp1 Data
disp('Converting MAXPPOOL1 data')

mp1_file = fopen('.\python_bins\maxpool1.bin');
num_channels = 96; 
height = 27; 
width = 27; 

mp1_read = fread(mp1_file,[num_channels*height*width,1],'double');
mp1 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            mp1(HH,WW,channels) = mp1_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

mp1_array = reshape(mp1,[height*width*num_channels,1]);

fclose('all');

mp1_permute = permute(mp1,[2,1,3]); 
mp1_reshape = reshape(mp1_permute,[height*width*num_channels,1]);
%mp1_char = num2hex(single(mp1_reshape)); 

mp1_char_8bit = []; 
for i = 1:1:length(mp1_reshape) 
    hex = dec_to_hex_single(mp1_reshape(i));  %
    mp1_char_8bit = [mp1_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end
   
%% WRITE MAXPOOL1 TXT FILE
disp('Writing MAXPOOL1 TXT File ...')

%mp1_char_size=size(mp1_char);
%mp1_char_size(1);
mp1_char_size_8bit = size(mp1_char_8bit); 
mp1_char_size_8bit(1); 
mp1_reshape_size = size(mp1_reshape); 
% fileID = fopen('.\mp1_coe.txt','w');
% for i = 1:1:mp1_char_size(1)
%     data = mp1_char(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\mp1.txt','w');
% for i = 1:1:mp1_char_size(1)
%     data = mp1_char(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\mp1_8bit.txt','w');
for i = 1:1:mp1_char_size_8bit(1)
    data = mp1_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\mp1_32bit.bin','w');
for i = 1:1:mp1_reshape_size(1)
    data = mp1_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 



%% Convert mp2 Data
disp('Converting MAXPPOOL2 data')

mp2_file = fopen('.\python_bins\maxpool2.bin');
num_channels = 256; 
height = 13; 
width = 13; 

mp2_read = fread(mp2_file,[num_channels*height*width,1],'double');
mp2 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            mp2(HH,WW,channels) = mp2_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

mp2_array = reshape(mp2,[height*width*num_channels,1]);

fclose('all');

mp2_permute = permute(mp2,[2,1,3]); 
mp2_reshape = reshape(mp2_permute,[height*width*num_channels,1]);
%mp2_char = num2hex(single(mp2_reshape)); 

mp2_char_8bit = []; 
for i = 1:1:length(mp2_reshape) 
    hex = dec_to_hex_single(mp2_reshape(i));  %
    mp2_char_8bit = [mp2_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end
   
%% WRITE MAXPOOL2 TXT FILE
disp('Writing MAXPOOL2 TXT File ...')

%mp2_char_size=size(mp2_char);
%mp2_char_size(1);
mp2_char_size_8bit = size(mp2_char_8bit); 
mp2_char_size_8bit(1); 
mp2_reshape_size = size(mp2_reshape); 
% fileID = fopen('.\mp2_coe.txt','w');
% for i = 1:1:mp2_char_size(1)
%     data = mp2_char(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\mp2.txt','w');
% for i = 1:1:mp2_char_size(1)
%     data = mp2_char(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\mp2_8bit.txt','w');
for i = 1:1:mp2_char_size_8bit(1)
    data = mp2_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\mp2_32bit.bin','w');
for i = 1:1:mp2_reshape_size(1)
    data = mp2_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert mp3 Data
disp('Converting MAXPPOOL3 data')

mp3_file = fopen('.\python_bins\maxpool3.bin');
num_channels = 256; 
height = 6; 
width = 6; 

mp3_read = fread(mp3_file,[num_channels*height*width,1],'double');
mp3 = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            mp3(HH,WW,channels) = mp3_read(index,1); 
            index = index + 1; 
        end 
    end 
end 

mp3_array = reshape(mp3,[height*width*num_channels,1]);

fclose('all');

mp3_permute = permute(mp3,[2,1,3]); 
mp3_reshape = reshape(mp3_permute,[height*width*num_channels,1]);
%mp3_char = num2hex(single(mp3_reshape)); 

mp3_char_8bit = []; 
for i = 1:1:length(mp3_reshape) 
    hex = dec_to_hex_single(mp3_reshape(i));  %
    mp3_char_8bit = [mp3_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)]; 
end
   
%% WRITE MAXPOOL3 TXT FILE
disp('Writing MAXPOOL3 TXT File ...')

%mp3_char_size=size(mp3_char);
%mp3_char_size(1);
mp3_char_size_8bit = size(mp3_char_8bit); 
mp3_char_size_8bit(1); 
mp3_reshape_size = size(mp3_reshape); 
% fileID = fopen('.\mp3_coe.txt','w');
% for i = 1:1:mp3_char_size(1)
%     data = mp3_char(i,1:4); 
%     fprintf(fileID, '%s,\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\mp3.txt','w');
% for i = 1:1:mp3_char_size(1)
%     data = mp3_char(i,1:4); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_txts\mp3_8bit.txt','w');
for i = 1:1:mp3_char_size_8bit(1)
    data = mp3_char_8bit(i,:); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\mp3_32bit.bin','w');
for i = 1:1:mp3_reshape_size(1)
    data = mp3_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 

