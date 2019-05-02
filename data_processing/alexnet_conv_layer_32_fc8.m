fclose('all'); 
clear all; 
close all; 

%% Get Weight Data
disp('Get Weight Data')
disp('W8')
W8_1_file = fopen('.\python_bins\W8.bin');
W8_1_read_single = fread(W8_1_file,'double');
size(W8_1_read_single)
% disp('W8_2')
% W8_2_file = fopen('.\W8_2.bin');
% W8_2_read_single = fread(W8_2_file,'double');
% disp('W8_3')
% W8_3_file = fopen('.\W8_3.bin');
% W8_3_read_single = fread(W8_3_file,'double');
% disp('W8_4')
% W8_4_file = fopen('.\W8_4.bin');
% W8_4_read_single = fread(W8_4_file,'double');
% disp('W8_5')
% W8_5_file = fopen('.\W8_5.bin');
% W8_5_read_single = fread(W8_5_file,'double');
% disp('W8_6')
% W8_6_file = fopen('.\W8_6.bin');
% W8_6_read_single = fread(W8_6_file,'double');
% disp('W8_7')
% W8_7_file = fopen('.\W8_7.bin');
% W8_7_read_single = fread(W8_7_file,'double');

% Essential Parameters 
num_filters = 10; 
num_channels = 4096; 
height = 1; 
width = 1;

W8_read_single = [W8_1_read_single]; % W8_2_read_single; W8_3_read_single; W8_4_read_single; W8_5_read_single; W8_6_read_single; W8_7_read_single; W8_8_read_single; W8_9_read_single; W8_10_read_single; W8_11_read_single; W8_12_read_single; W8_13_read_single; W8_14_read_single; W8_15_read_single];  
W8_single = zeros(height,width,num_channels,num_filters);

% %% Rearrange Data into Image Matrix
% disp('Rearrange Data into Image Matrix')
% index = 1; 
% 
% for filters = 1:1:num_filters 
%     filters; 
%     for channels = 1:1:num_channels
%         for HH = 1:1:width%filters = 1:1:num_filters %channels = 1:1:num_channels
%             for WW = 1:1:width%channels = 1:1:num_channels
%                 W8_single(HH,WW,channels,filters) = W8_read_single(index,1); 
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
                W8_single(HH,WW,channels,filters) = W8_read_single(index,1); 
                index = index + 1;
            end
        end 
    end 
end 
fclose('all');


%% Writing W8 TXT File
disp('Writing W8 TXT File ...')

W8_permute = permute(W8_single,[2,1,3,4]); 
W8_reshape = reshape(W8_permute,[height*width*num_channels*num_filters,1]);

W8_char = []; 
W8_char_8bit = char(ones(height*width*num_channels*num_filters,2)); %[];
loop_counter = 1; 
time_accumulate = 0; 
index = 1; 
limit = (length(W8_reshape)*4)
% for i = 1:4:limit
%     %tic; 
%     i;
%     char_data = dec_to_hex_single(W8_reshape(index)); 
%     index; 
%     %W8_char = [W8_char; dec_to_hex_single(W8_reshape(i))]; 
%    % W8_char_8bit = [W8_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
%     W8_char_8bit(i,:) = char_data(7:8);
%     W8_char_8bit(i+1,:) = char_data(5:6); 
%     W8_char_8bit(i+2,:) = char_data(3:4); 
%     W8_char_8bit(i+3,:) = char_data(1:2); 
% %     timer_val = toc; 
% %     time_accumulate = time_accumulate+datenum(timer_val); 
% %     loop_counter = loop_counter + 1; 
% %     if(loop_counter == 100)
% %         loop_counter = 0; 
% %          
% %         X = sprintf('Element %d of %d',i,length(W8_reshape));
% %         disp(X)
% %     
% %         T = sprintf('Time Remaining %s',datestr((time_accumulate/100)*(length(W8_reshape)-i), 'HH:MM:SS'));
% %         disp(T)
% %         time_accumulate = 0;
% %     end 
%     index = index + 1; 
% end 
% 
% %W8_char_size=size(W8_char)
% %W8_char_size(1)
% W8_char_8bit_size =size(W8_char_8bit)
% W8_char_8bit_size(1)
% 
% % fileID = fopen('.\W8_coe.txt','w');
% % for i = 1:1:W8_char_size(1)
% %     data = W8_char(i,1:4); 
% %     fprintf(fileID, '%s,\n',data);
% % end 
% % fclose(fileID); 
% % 
% % fileID = fopen('.\W8.txt','w');
% % for i = 1:1:W8_char_size(1)
% %     data = W8_char(i,1:4); 
% %     fprintf(fileID, '%s\n',data);
% % end 
% % fclose(fileID); 
% 
% fileID = fopen('.\W8_8bit.txt','w');
% for i = 1:1:W8_char_8bit_size(1)
%     data = W8_char_8bit(i,1:2); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_bins\W8_single.bin','w');
for i = 1:1:length(W8_reshape)
    X = sprintf('Element %d of %d',i,length(W8_reshape));
    disp(X)
    data = W8_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 


% %W8_single = permute(W8_single,[4,3,1,2]); 
% 
% 
% %% Rearrange Data to Feed into Simulation
% disp('Rearrange Data to Feed into Simulation') 
num_chans_in_set = 32; 
num_filters_in_set = 10; 
channel_iterations = num_channels/num_chans_in_set; 
filter_iterations = num_filters/num_filters_in_set; 

%% Get Bias Data
disp('Get Bias Data')
b8_file = fopen('.\python_bins\b8.bin');
% Essential Parameters 
%num_filters = num_filters_in_set*filter_iterations; 

b8_read = fread(b8_file,[num_filters,1],'double');
%b8_read = zeros(num_filters,1);

% Hex_b8_read = []; 
% for i=1:1:length(num_filters)
%     %Hex_b8_read = [Hex_b8_read; dec_to_hex_single(b8_read(i))];
%     Hex_b8_read = [Hex_b8_read; dec_to_hex_single(b8_single(i))];
% end
size(b8_read)
Hex_b8_read = []; 
for i=1:1:length(b8_read)
    Hex_b8_read = [Hex_b8_read; dec_to_hex_single(b8_read(i))];
end


%% Get Affine Data
disp('Get Affine2 Data')
fc8_file = fopen('.\python_bins\affine2.bin');
% Essential Parameters 
H = 1; 
W = 1; 
C = 4096;  

fc8_read_single = fread(fc8_file,[C*H*W,1],'double');
fc8_single = zeros(H,W,C);

% Hex_fc8_read_single = []; 
% for i=1:1:length(fc8_read_single)
%     Hex_fc8_read_single = [Hex_fc8_read_single; dec_to_hex_single(fc8_read_single(i))];
% end


%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:C
    for HH = 1:1:H
        for WW = 1:1:W
            %fc8_single(HH,WW,channels) = maxpool_data(index,1); 
            fc8_single(HH,WW,channels) = fc8_read_single(index,1); 
            index = index + 1; 
        end
    end 
end 
fclose('all');

fc8_single = permute(fc8_single,[3,1,2]); 
size(fc8_single)
image_4d = zeros(1,C,H,W); 
image_4d(1,:,:,:) = fc8_single; 


W8_single = permute(W8_single,[4,3,1,2]); 

%% Execute Affine
disp('Execute Affine')

[out,xxx,www,bbb] = affine_forward(image_4d, W8_single(1:num_filters_in_set*filter_iterations,:,:,:), transpose(b8_read)); 



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
fileID = fopen('.\script_txts\fc8_truth_data_32.txt','w');
for i = 1:1:length(out_data_reshape)
    data = hex_out_data(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\fc8_truth_data_8bit.txt','w');
for i = 1:1:hex_out_data_size(1)
    data = hex_out_data(i,1:2);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\fc8_data_8bit.bin','w');
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

