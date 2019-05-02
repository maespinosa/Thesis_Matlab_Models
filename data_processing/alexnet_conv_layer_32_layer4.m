fclose('all'); 
clear all; 
close all; 

%% Get Weight Data
disp('Get Weight Data')
W4_file = fopen('.\python_bins\W4.bin');
% Essential Parameters 
num_filters = 384; 
num_channels = 384; 
height = 3; 
width = 3; 

W4_read_single = fread(W4_file,[num_filters*num_channels*height*width,1],'double');
W4_single = zeros(height,width,num_channels,num_filters);
% 
% Hex_W4_read_single = []; 
% for i=1:1:length(W4_read_single)
%     Hex_W4_read_single = [Hex_W4_read_single; dec_to_hex_single(W4_read_single(i))];
% end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% weight_data_half_hex = []; 
% 
% for i = 1:1:length(W4_read_single)
%         hex = dec_to_hex_single(W4_read_single(i));  %
%         weight_data_half_hex = [weight_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
% %% Convert to Decimal from Half Precision Hex
% disp('Convert to Decimal from Half Precision Hex')
% 
% weight_data = []; 
% 
% for i = 1:1:length(W4_read_single)
%     weight_data = [weight_data; hex_to_dec_single(Hex_W4_read_single(i,:))]; 
% end 
%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for filters = 1:1:num_filters 
    for channels = 1:1:num_channels
        for HH = 1:1:width%filters = 1:1:num_filters %channels = 1:1:num_channels
            for WW = 1:1:width%channels = 1:1:num_channels
                W4_single(HH,WW,channels,filters) = W4_read_single(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 
fclose('all');

W4_single = permute(W4_single,[4,3,1,2]); 

%% Get Bias Data
disp('Get Bias Data')
b4_file = fopen('.\python_bins\b4.bin');
% Essential Parameters 
num_filters = 384; 

b4_read = fread(b4_file,[num_filters,1],'double');
b4_single = zeros(num_filters);

Hex_b4_read = []; 
for i=1:1:length(b4_read)
    Hex_b4_read = [Hex_b4_read; dec_to_hex_single(b4_read(i))];
end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% bias_data_half_hex = []; 
% 
% for i = 1:1:length(b4_read)
%         hex = dec_to_hex_single(b4_read(i));  %
%         bias_data_half_hex = [bias_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
% %% Convert to Decimal from Half Precision Hex
% disp('Convert to Decimal from Half Precision Hex')
% 
% bias_data = []; 
% 
% for i = 1:1:length(b4_read)
%     %bias_data = [bias_data; hex_to_dec_single(bias_data_half_hex(i,:))]; 
%     bias_data = [bias_data; hex_to_dec_single(Hex_b4_read(i,:))];
% end 

bias_data = b4_read;


%% Get Input Data
disp('Get Input Data')
RELU3_file = fopen('.\python_bins\relu3.bin');
% Essential Parameters 
H = 13; 
W = 13; 
C = 384;  

RELU3_read_single = fread(RELU3_file,[C*H*W,1],'double');
RELU3_single = zeros(H,W,C);

Hex_RELU3_read_single = []; 
for i=1:1:length(RELU3_read_single)
    Hex_RELU3_read_single = [Hex_RELU3_read_single; dec_to_hex_single(RELU3_read_single(i))];
end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% maxpool_data_half_hex = []; 
% 
% for i = 1:1:length(RELU3_read_single)
%         hex = dec_to_hex_single(RELU3_read_single(i));  %
%         maxpool_data_half_hex = [maxpool_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
%% Convert to Decimal from Half Precision Hex
disp('Convert to Decimal from Half Precision Hex')

relu_data = []; 

for i = 1:1:length(RELU3_read_single)
    %relu_data = [relu_data; hex_to_dec_single(maxpool_data_half_hex(i,:))]; 
    relu_data = [relu_data; hex_to_dec_single(Hex_RELU3_read_single(i,:))]; 
end 
%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:C
    for HH = 1:1:H
        for WW = 1:1:W
            RELU3_single(HH,WW,channels) = RELU3_read_single(index,1); 
            index = index + 1; 
        end
    end 
end 
fclose('all');

RELU3_single = permute(RELU3_single,[3,1,2]); 
image_4d = zeros(1,C,H,W); 
image_4d(1,:,:,:) = RELU3_single; 










%% Execute Convolution
disp('Execute Convolution')
stride = 1;
pad = 1;
    
conv_param = {pad, stride}; 
[out, cache] = conv_forward_naive(image_4d, W4_single, bias_data, conv_param); 

%% Convert Convolution Ouptut to Floating Point Single Precision Hex
disp('Convert Convolution Ouptut to Floating Point Half Precision Hex')
[N,F,H,W] = size(out); 

out_data_permute = permute(out,[4,3,2,1]); 
out_data_reshape = reshape(out_data_permute,[N*F*H*W,1]); 

hex_out_data = []; 
out_char_8bit = [];
% for i=1:1:length(out_data_reshape)
%     hex = dec_to_hex_single(out_data_reshape(i)); 
%     hex_out_data = [hex_out_data; hex]; 
%     out_char_8bit = [out_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)];
% end 

out_char_8bit_size = size(out_char_8bit)
out_char_8bit_size(1)

%% Write Conv Output Truth File 
disp('Write Conv Output Truth File ')
% fileID = fopen('.\script_txts\conv4_truth_data_32.txt','w');
% for i = 1:1:length(out_data_reshape)
%     data = hex_out_data(i,:);  
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\script_txts\conv4_truth_data_8bit.txt','w');
% for i = 1:1:out_char_8bit_size(1)
%     data = out_char_8bit(i,1:2);  
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 

fileID = fopen('.\script_bins\conv4_truth_data_8bit.bin','w');
for j = 1:1:length(out_data_reshape)
    data = out_data_reshape(j,:);
    fwrite(fileID,data,'single');
end 
fclose(fileID); 



%% Convert to Decimal from Single Precision Hex
disp('Convert to Decimal from Single Precision Hex')

conv_truth_data = []; 

for i = 1:1:length(out_data_reshape)
    conv_truth_data = [conv_truth_data; hex_to_dec_single(hex_out_data(i,:))]; 
end 


