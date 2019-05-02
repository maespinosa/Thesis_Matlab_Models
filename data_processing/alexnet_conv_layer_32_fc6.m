fclose('all'); 
clear all; 
close all; 

%% Get Weight Data
disp('Get Weight Data')
disp('W6')
W6_file = fopen('.\python_bins\W6.bin');
W6_read_single = fread(W6_file,'double');
% disp('W6_2')
% W6_2_file = fopen('.\W6_2.bin');
% W6_2_read_single = fread(W6_2_file,'double');
% disp('W6_3')
% W6_3_file = fopen('.\W6_3.bin');
% W6_3_read_single = fread(W6_3_file,'double');
% disp('W6_4')
% W6_4_file = fopen('.\W6_4.bin');
% W6_4_read_single = fread(W6_4_file,'double');
% disp('W6_5')
% W6_5_file = fopen('.\W6_5.bin');
% W6_5_read_single = fread(W6_5_file,'double');
% disp('W6_6')
% W6_6_file = fopen('.\W6_6.bin');
% W6_6_read_single = fread(W6_6_file,'double');
% disp('W6_7')
% W6_7_file = fopen('.\W6_7.bin');
% W6_7_read_single = fread(W6_7_file,'double');
% disp('W6_8')
% W6_8_file = fopen('.\W6_8.bin');
% W6_8_read_single = fread(W6_8_file,'double');
% disp('W6_9')
% W6_9_file = fopen('.\W6_9.bin');
% W6_9_read_single = fread(W6_9_file,'double');
% disp('W6_10')
% W6_10_file = fopen('.\W6_10.bin');
% W6_10_read_single = fread(W6_10_file,'double');
% disp('W6_11')
% W6_11_file = fopen('.\W6_11.bin');
% W6_11_read_single = fread(W6_11_file,'double');
% disp('W6_12')
% W6_12_file = fopen('.\W6_12.bin');
% W6_12_read_single = fread(W6_12_file,'double');
% disp('W6_13')
% W6_13_file = fopen('.\W6_13.bin');
% W6_13_read_single = fread(W6_13_file,'double');
% disp('W6_14')
% W6_14_file = fopen('.\W6_14.bin');
% W6_14_read_single = fread(W6_14_file,'double');
% disp('W6_15')
% W6_15_file = fopen('.\W6_15.bin');
% W6_15_read_single = fread(W6_15_file,'double');
% Essential Parameters 
num_filters = 4096; 
num_channels = 256; 
height = 6; 
width = 6;

%W6_read_single = [W6_1_read_single; W6_2_read_single; W6_3_read_single; W6_4_read_single; W6_5_read_single; W6_6_read_single; W6_7_read_single; W6_8_read_single; W6_9_read_single; W6_10_read_single; W6_11_read_single; W6_12_read_single; W6_13_read_single; W6_14_read_single; W6_15_read_single];  
W6_single = zeros(height,width,num_channels,num_filters);

% %% Rearrange Data into Image Matrix
% disp('Rearrange Data into Image Matrix')
% index = 1; 
% 
% for filters = 1:1:num_filters 
%     filters; 
%     for channels = 1:1:num_channels
%         for HH = 1:1:width%filters = 1:1:num_filters %channels = 1:1:num_channels
%             for WW = 1:1:width%channels = 1:1:num_channels
%                 W6_single(HH,WW,channels,filters) = W6_read_single(index,1); 
%                 index = index + 1;
%             end
%         end 
%     end 
% end 
% fclose('all');

%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:num_channels
    %filters; 
    for  HH = 1:1:height
        for WW = 1:1:width
            for filters = 1:1:num_filters  
                W6_single(HH,WW,channels,filters) = W6_read_single(index,1); 
                index = index + 1;
            end
        end 
    end 
end 
fclose('all');

%% Writing W6 TXT File
disp('Writing W6 TXT File ...')

W6_permute = permute(W6_single,[2,1,3,4]); 
W6_reshape = reshape(W6_permute,[height*width*num_channels*num_filters,1]);

W6_char = []; 
W6_char_8bit = char(ones(height*width*num_channels*num_filters,2)); %[];
loop_counter = 1; 
time_accumulate = 0; 
index = 1; 
limit = (length(W6_reshape)*4)
% for i = 1:4:limit
%     %tic; 
%     i;
%     char_data = dec_to_hex_single(W6_reshape(index)); 
%     index; 
%     %W6_char = [W6_char; dec_to_hex_single(W6_reshape(i))]; 
%    % W6_char_8bit = [W6_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
%     W6_char_8bit(i,:) = char_data(7:8);
%     W6_char_8bit(i+1,:) = char_data(5:6); 
%     W6_char_8bit(i+2,:) = char_data(3:4); 
%     W6_char_8bit(i+3,:) = char_data(1:2); 
% %     timer_val = toc; 
% %     time_accumulate = time_accumulate+datenum(timer_val); 
% %     loop_counter = loop_counter + 1; 
% %     if(loop_counter == 10000)
% %         loop_counter = 0; 
% %          
% %         X = sprintf('Element %d of %d',i,length(W6_reshape));
% %         disp(X)
% %     
% %         T = sprintf('Time Remaining %s',datestr((time_accumulate/10000)*(length(W6_reshape)-i), 'HH:MM:SS'));
% %         disp(T)
% %         time_accumulate = 0;
% %     end 
%     index = index + 1; 
% end 
% 
% %W6_char_size=size(W6_char)
% %W6_char_size(1)
% W6_char_8bit_size =size(W6_char_8bit)
% W6_char_8bit_size(1)
% 
% % fileID = fopen('.\W6_coe.txt','w');
% % for i = 1:1:W6_char_size(1)
% %     data = W6_char(i,1:4); 
% %     fprintf(fileID, '%s,\n',data);
% % end 
% % fclose(fileID); 
% % 
% % fileID = fopen('.\W6.txt','w');
% % for i = 1:1:W6_char_size(1)
% %     data = W6_char(i,1:4); 
% %     fprintf(fileID, '%s\n',data);
% % end 
% % fclose(fileID); 
% 
% fileID = fopen('.\W6_8bit.txt','w');
% for i = 1:1:W6_char_8bit_size(1)
%     data = W6_char_8bit(i,1:2); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_bins\W6_single.bin','w');
for i = 1:1:length(W6_reshape)
    X = sprintf('Element %d of %d',i,length(W6_reshape));
    disp(X)
    data = W6_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 


% %W6_single = permute(W6_single,[4,3,1,2]); 
% 
% 
% %% Rearrange Data to Feed into Simulation
% disp('Rearrange Data to Feed into Simulation') 
num_chans_in_set = 4; 
num_filters_in_set = 4096; 
channel_iterations = num_channels/num_chans_in_set; 
filter_iterations = num_filters/num_filters_in_set; 

%% Get Bias Data
disp('Get Bias Data')
b6_file = fopen('.\python_bins\b6.bin');
% Essential Parameters 
%num_filters = num_filters_in_set*filter_iterations; 

b6_read = fread(b6_file,[num_filters,1],'double');
%b6_read = zeros(num_filters,1);

% Hex_b6_read = []; 
% for i=1:1:length(num_filters)
%     %Hex_b6_read = [Hex_b6_read; dec_to_hex_single(b6_read(i))];
%     Hex_b6_read = [Hex_b6_read; dec_to_hex_single(b6_single(i))];
% end
size(b6_read)
Hex_b6_read = []; 
for i=1:1:length(b6_read)
    Hex_b6_read = [Hex_b6_read; dec_to_hex_single(b6_read(i))];
end


%% Get Maxpool Data
disp('Get Maxpool Data')
MP3_file = fopen('.\python_bins\maxpool3.bin');
% Essential Parameters 
H = 6; 
W = 6; 
C = 256;  

MP3_read_single = fread(MP3_file,[C*H*W,1],'double');
MP3_single = zeros(H,W,C);

Hex_MP3_read_single = []; 
for i=1:1:length(MP3_read_single)
    Hex_MP3_read_single = [Hex_MP3_read_single; dec_to_hex_single(MP3_read_single(i))];
end


%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:C
    for HH = 1:1:H
        for WW = 1:1:W
            %MP3_single(HH,WW,channels) = maxpool_data(index,1); 
            MP3_single(HH,WW,channels) = MP3_read_single(index,1); 
            index = index + 1; 
        end
    end 
end 
fclose('all');

MP3_single = permute(MP3_single,[3,1,2]); 
image_4d = zeros(1,C,H,W); 
image_4d(1,:,:,:) = MP3_single; 

W6_single = permute(W6_single,[4,3,1,2]); 

%% Execute Affine
disp('Execute Affine')

[out,xxx,www,bbb] = affine_forward(image_4d, W6_single(1:num_filters_in_set*filter_iterations,:,:,:), transpose(b6_read)); 



%% Convert Affine Ouptut to Floating Point Single Precision Hex
disp('Convert Affine Ouptut to Floating Point Half Precision Hex')
[N,F,H,W] = size(out); 

out_data_permute = permute(out,[4,3,2,1]); 
out_data_reshape = reshape(out_data_permute,[N*F*H*W,1]); 

hex_out_data = []; 
for i=1:1:length(out_data_reshape)
    hex = dec_to_hex_single(out_data_reshape(i)); 
    hex_out_data = [hex_out_data; hex]; 
end 

hex_out_data_size = size(hex_out_data)
hex_out_data_size(1)

%% Write Affine Output Truth File 
disp('Write Affine Output Truth File ')
fileID = fopen('.\script_txts\fc6_truth_data_32.txt','w');
for i = 1:1:length(out_data_reshape)
    data = hex_out_data(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\fc6_truth_data_8bit.txt','w');
for i = 1:1:hex_out_data_size(1)
    data = hex_out_data(i,1:2);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\fc6_data_8bit.bin','w');
for i = 1:1:length(out_data_reshape)
    data = out_data_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 


%% Convert to Decimal from Single Precision Hex
disp('Convert to Decimal from Single Precision Hex')

affine_truth_data = []; 

for i = 1:1:length(out_data_reshape)
    affine_truth_data = [affine_truth_data; hex_to_dec_single(hex_out_data(i,:))]; 
end 

