fclose('all'); 
clear all; 
close all; 

%% Get Weight Data
disp('Get Weight Data')
disp('W7_1')
W7_1_file = fopen('.\python_bins\W7.bin');
W7_1_read_single = fread(W7_1_file,'double');
% disp('W7_2')
% W7_2_file = fopen('.\W7_2.bin');
% W7_2_read_single = fread(W7_2_file,'double');
% disp('W7_3')
% W7_3_file = fopen('.\W7_3.bin');
% W7_3_read_single = fread(W7_3_file,'double');
% disp('W7_4')
% W7_4_file = fopen('.\W7_4.bin');
% W7_4_read_single = fread(W7_4_file,'double');
% disp('W7_5')
% W7_5_file = fopen('.\W7_5.bin');
% W7_5_read_single = fread(W7_5_file,'double');
% disp('W7_6')
% W7_6_file = fopen('.\W7_6.bin');
% W7_6_read_single = fread(W7_6_file,'double');
% disp('W7_7')
% W7_7_file = fopen('.\W7_7.bin');
% W7_7_read_single = fread(W7_7_file,'double');

% Essential Parameters 
num_filters = 4096; 
num_channels = 4096; 
height = 1; 
width = 1;

W7_read_single = [W7_1_read_single]; %W7_2_read_single; W7_3_read_single; W7_4_read_single; W7_5_read_single; W7_6_read_single; W7_7_read_single; W7_8_read_single; W7_9_read_single; W7_10_read_single; W7_11_read_single; W7_12_read_single; W7_13_read_single; W7_14_read_single; W7_15_read_single];  
W7_single = zeros(height,width,num_channels,num_filters);

% %% Rearrange Data into Image Matrix
% disp('Rearrange Data into Image Matrix')
% index = 1; 
% 
% for filters = 1:1:num_filters 
%     filters; 
%     for channels = 1:1:num_channels
%         for HH = 1:1:width%filters = 1:1:num_filters %channels = 1:1:num_channels
%             for WW = 1:1:width%channels = 1:1:num_channels
%                 W7_single(HH,WW,channels,filters) = W7_read_single(index,1); 
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
                W7_single(HH,WW,channels,filters) = W7_read_single(index,1); 
                index = index + 1;
            end
        end 
    end 
end 
fclose('all');



%% Writing W7 TXT File
disp('Writing W7 TXT File ...')

W7_permute = permute(W7_single,[2,1,3,4]); 
W7_reshape = reshape(W7_permute,[height*width*num_channels*num_filters,1]);

W7_char = []; 
W7_char_8bit = char(ones(height*width*num_channels*num_filters,2)); %[];
loop_counter = 1; 
time_accumulate = 0; 
index = 1; 
limit = (length(W7_reshape)*4)
% for i = 1:4:limit
%     %tic; 
%     i;
%     char_data = dec_to_hex_single(W7_reshape(index)); 
%     index; 
%     %W7_char = [W7_char; dec_to_hex_single(W7_reshape(i))]; 
%    % W7_char_8bit = [W7_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)]; 
%     W7_char_8bit(i,:) = char_data(7:8);
%     W7_char_8bit(i+1,:) = char_data(5:6); 
%     W7_char_8bit(i+2,:) = char_data(3:4); 
%     W7_char_8bit(i+3,:) = char_data(1:2); 
% %     timer_val = toc; 
% %     time_accumulate = time_accumulate+datenum(timer_val); 
% %     loop_counter = loop_counter + 1; 
% %     if(loop_counter == 10000)
% %         loop_counter = 0; 
% %          
% %         X = sprintf('Element %d of %d',i,length(W7_reshape));
% %         disp(X)
% %     
% %         T = sprintf('Time Remaining %s',datestr((time_accumulate/10000)*(length(W7_reshape)-i), 'HH:MM:SS'));
% %         disp(T)
% %         time_accumulate = 0;
% %     end 
%     index = index + 1; 
% end 
% 
% %W7_char_size=size(W7_char)
% %W7_char_size(1)
% W7_char_8bit_size =size(W7_char_8bit)
% W7_char_8bit_size(1)
% 
% % fileID = fopen('.\W7_coe.txt','w');
% % for i = 1:1:W7_char_size(1)
% %     data = W7_char(i,1:4); 
% %     fprintf(fileID, '%s,\n',data);
% % end 
% % fclose(fileID); 
% % 
% % fileID = fopen('.\W7.txt','w');
% % for i = 1:1:W7_char_size(1)
% %     data = W7_char(i,1:4); 
% %     fprintf(fileID, '%s\n',data);
% % end 
% % fclose(fileID); 
% 
% fileID = fopen('.\W7_8bit.txt','w');
% for i = 1:1:W7_char_8bit_size(1)
%     data = W7_char_8bit(i,1:2); 
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_bins\W7_single.bin','w');
for i = 1:1:length(W7_reshape)
    X = sprintf('Element %d of %d',i,length(W7_reshape));
    disp(X)
    data = W7_reshape(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 


% %W7_single = permute(W7_single,[4,3,1,2]); 
% 
% 
% %% Rearrange Data to Feed into Simulation
% disp('Rearrange Data to Feed into Simulation') 
num_chans_in_set = 32; 
num_filters_in_set = 4096; 
channel_iterations = num_channels/num_chans_in_set; 
filter_iterations = num_filters/num_filters_in_set; 

%% Get Bias Data
disp('Get Bias Data')
b7_file = fopen('.\python_bins\b7.bin');
% Essential Parameters 
%num_filters = num_filters_in_set*filter_iterations; 

b7_read = fread(b7_file,[num_filters,1],'double');
%b7_read = zeros(num_filters,1);

% Hex_b7_read = []; 
% for i=1:1:length(num_filters)
%     %Hex_b7_read = [Hex_b7_read; dec_to_hex_single(b7_read(i))];
%     Hex_b7_read = [Hex_b7_read; dec_to_hex_single(b7_single(i))];
% end
size(b7_read)
Hex_b7_read = []; 
for i=1:1:length(b7_read)
    Hex_b7_read = [Hex_b7_read; dec_to_hex_single(b7_read(i))];
end


%% Get Affine Data
disp('Get Affine1 Data')
FC6_file = fopen('.\python_bins\affine1.bin');
% Essential Parameters 
H = 1; 
W = 1; 
C = 4096;  

FC6_read_single = fread(FC6_file,[C*H*W,1],'double');
FC6_single = zeros(H,W,C);

Hex_FC6_read_single = []; 
for i=1:1:length(FC6_read_single)
    Hex_FC6_read_single = [Hex_FC6_read_single; dec_to_hex_single(FC6_read_single(i))];
end


%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:C
    for HH = 1:1:H
        for WW = 1:1:W
            %FC6_single(HH,WW,channels) = maxpool_data(index,1); 
            FC6_single(HH,WW,channels) = FC6_read_single(index,1); 
            index = index + 1; 
        end
    end 
end 
fclose('all');

FC6_single = permute(FC6_single,[3,1,2]); 
size(FC6_single)
image_4d = zeros(1,C,H,W); 
image_4d(1,:,:,:) = FC6_single; 

W7_single = permute(W7_single,[4,3,1,2]); 
size(W7_single)
size(b7_read)

%% Execute Affine
disp('Execute Affine')

%[out,xxx,www,bbb] = affine_forward(permute(image_4d,[1,4,2,3]), W7_single(1:num_filters_in_set*filter_iterations,:,:,:), transpose(b7_read)); 
[out,xxx,www,bbb] = affine_forward(image_4d, W7_single(1:num_filters_in_set*filter_iterations,:,:,:), transpose(b7_read)); 



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
fileID = fopen('.\script_txts\fc7_truth_data_32.txt','w');
for i = 1:1:length(out_data_reshape)
    data = hex_out_data(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\fc7_truth_data_8bit.txt','w');
for i = 1:1:hex_out_data_size(1)
    data = hex_out_data(i,1:2);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\fc7_data_8bit.bin','w');
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

