fclose('all'); 
clear all; 
close all; 

%% Get Weight Data
disp('Get Weight Data')
W3_file = fopen('.\python_bins\W3.bin');
% Essential Parameters 
num_filters = 384; 
num_channels = 256; 
height = 3; 
width = 3; 

W3_read_single = fread(W3_file,[num_filters*num_channels*height*width,1],'double');
W3_single = zeros(height,width,num_channels,num_filters);

% Hex_W3_read_single = []; 
% for i=1:1:length(W3_read_single)
%     Hex_W3_read_single = [Hex_W3_read_single; dec_to_hex_single(W3_read_single(i))];
% end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% weight_data_half_hex = []; 
% 
% for i = 1:1:length(W3_read_single)
%         hex = dec_to_hex_single(W3_read_single(i));  %
%         weight_data_half_hex = [weight_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
% %% Convert to Decimal from Half Precision Hex
% disp('Convert to Decimal from Half Precision Hex')
% 
% weight_data = []; 
% 
% for i = 1:1:length(W3_read_single)
%     weight_data = [weight_data; hex_to_dec_single(Hex_W3_read_single(i,:))]; 
% end 
%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for filters = 1:1:num_filters 
    for channels = 1:1:num_channels
        for HH = 1:1:width%filters = 1:1:num_filters %channels = 1:1:num_channels
            for WW = 1:1:width%channels = 1:1:num_channels
                W3_single(HH,WW,channels,filters) = W3_read_single(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 
fclose('all');

W3_single = permute(W3_single,[4,3,1,2]); 

%% Get Bias Data
disp('Get Bias Data')
b3_file = fopen('.\python_bins\b3.bin');
% Essential Parameters 
num_filters = 384; 

b3_read = fread(b3_file,[num_filters,1],'double');
b3_single = zeros(num_filters);

Hex_b3_read = []; 
for i=1:1:length(b3_read)
    Hex_b3_read = [Hex_b3_read; dec_to_hex_single(b3_read(i))];
end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% bias_data_half_hex = []; 
% 
% for i = 1:1:length(b3_read)
%         hex = dec_to_hex_single(b3_read(i));  %
%         bias_data_half_hex = [bias_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
% %% Convert to Decimal from Half Precision Hex
% disp('Convert to Decimal from Half Precision Hex')
% 
% bias_data = []; 
% 
% for i = 1:1:length(b3_read)
%     %bias_data = [bias_data; hex_to_dec_single(bias_data_half_hex(i,:))]; 
%     bias_data = [bias_data; hex_to_dec_single(Hex_b3_read(i,:))];
% end 

bias_data = b3_read;


%% Get Input Data
disp('Get Input Data')
MP2_file = fopen('.\python_bins\maxpool2.bin');
% Essential Parameters 
H = 13; 
W = 13; 
C = 256;  

MP2_read_single = fread(MP2_file,[C*H*W,1],'double');
MP2_single = zeros(H,W,C);

Hex_MP2_read_single = []; 
for i=1:1:length(MP2_read_single)
    Hex_MP2_read_single = [Hex_MP2_read_single; dec_to_hex_single(MP2_read_single(i))];
end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% maxpool_data_half_hex = []; 
% 
% for i = 1:1:length(MP2_read_single)
%         hex = dec_to_hex_single(MP2_read_single(i));  %
%         maxpool_data_half_hex = [maxpool_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
%% Convert to Decimal from Half Precision Hex
disp('Convert to Decimal from Half Precision Hex')

maxpool_data = []; 

for i = 1:1:length(MP2_read_single)
    %maxpool_data = [maxpool_data; hex_to_dec_single(maxpool_data_half_hex(i,:))]; 
    maxpool_data = [maxpool_data; hex_to_dec_single(Hex_MP2_read_single(i,:))]; 
end 
%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:C
    for HH = 1:1:H
        for WW = 1:1:W
            MP2_single(HH,WW,channels) = MP2_read_single(index,1); 
            index = index + 1; 
        end
    end 
end 
fclose('all');

MP2_single = permute(MP2_single,[3,1,2]); 
image_4d = zeros(1,C,H,W); 
image_4d(1,:,:,:) = MP2_single; 










%% Execute Convolution
disp('Execute Convolution')
stride = 1;
pad = 1;
    
conv_param = {pad, stride}; 
[out, cache] = conv_forward_naive(image_4d, W3_single, bias_data, conv_param); 

%% Convert Convolution Ouptut to Floating Point Single Precision Hex
disp('Convert Convolution Ouptut to Floating Point Half Precision Hex')
[N,F,H,W] = size(out); 

out_data_permute = permute(out,[4,3,2,1]); 
out_data_reshape = reshape(out_data_permute,[N*F*H*W,1]); 

hex_out_data = []; 
out_char_8bit = [];
for i=1:1:length(out_data_reshape)
    hex = dec_to_hex_single(out_data_reshape(i)); 
    hex_out_data = [hex_out_data; hex]; 
    out_char_8bit = [out_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)];
end 

out_char_8bit_size = size(out_char_8bit)
out_char_8bit_size(1)

%% Write Conv Output Truth File 
disp('Write Conv Output Truth File ')
fileID = fopen('.\script_txts\conv3_truth_data_32.txt','w');
for i = 1:1:length(out_data_reshape)
    data = hex_out_data(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\conv3_truth_data_8bit.txt','w');
for i = 1:1:out_char_8bit_size(1)
    data = out_char_8bit(i,1:2);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\conv3_truth_data_8bit.bin','w');
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

%% Relu

relu3_mask = out >= 0;
relu3 = out .* relu3_mask;

relu_data_permute = permute(relu3,[4,3,2,1]);
relu_data_reshape = reshape(relu_data_permute,[N*F*H*W,1]);

fileID = fopen('.\script_bins\relu3_data.bin','w');
for i = 1:1:length(relu_data_reshape)
    data = relu_data_reshape(i,:);
    fwrite(fileID,data,'single');
end
fclose(fileID);

