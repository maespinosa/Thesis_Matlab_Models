fclose('all'); 
clear all; 
close all; 

%% Get Weight Data
disp('Get Weight Data')
W2_file = fopen('.\python_bins\W2.bin');
% Essential Parameters 
num_filters = 256; 
num_channels = 96; 
height = 5; 
width = 5; 

W2_read_single = fread(W2_file,[num_filters*num_channels*height*width,1],'double');
W2_single = zeros(height,width,num_channels,num_filters);

% Hex_W2_read_single = []; 
% for i=1:1:length(W2_read_single)
%     Hex_W2_read_single = [Hex_W2_read_single; dec_to_hex_single(W2_read_single(i))];
% end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% weight_data_half_hex = []; 
% 
% for i = 1:1:length(W2_read_single)
%         hex = dec_to_hex_single(W2_read_single(i));  %
%         weight_data_half_hex = [weight_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
% %% Convert to Decimal from Half Precision Hex
% disp('Convert to Decimal from Half Precision Hex')
% 
% weight_data = []; 
% 
% for i = 1:1:length(W2_read_single)
%     weight_data = [weight_data; hex_to_dec_single(weight_data_half_hex(i,:))]; 
% end 
%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for filters = 1:1:num_filters 
    for channels = 1:1:num_channels
        for HH = 1:1:width%filters = 1:1:num_filters %channels = 1:1:num_channels
            for WW = 1:1:width%channels = 1:1:num_channels
                W2_single(HH,WW,channels,filters) = W2_read_single(index,1); 
                index = index + 1; 
            end
        end 
    end 
end 
fclose('all');

W2_single = permute(W2_single,[4,3,1,2]); 

%% Get Bias Data
disp('Get Bias Data')
b2_file = fopen('.\python_bins\b2.bin');
% Essential Parameters 
num_filters = 256; 

b2_read = fread(b2_file,[num_filters,1],'double');
b2_single = zeros(num_filters);

% Hex_b2_read = []; 
% for i=1:1:length(b2_read)
%     Hex_b2_read = [Hex_b2_read; dec_to_hex_single(b2_read(i))];
% end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% bias_data_half_hex = []; 
% 
% for i = 1:1:length(b2_read)
%         hex = dec_to_hex_single(b2_read(i));  %
%         bias_data_half_hex = [bias_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
% %% Convert to Decimal from Half Precision Hex
% disp('Convert to Decimal from Half Precision Hex')
% 
% bias_data = []; 
% 
% for i = 1:1:length(b2_read)
%     bias_data = [bias_data; hex_to_dec_single(bias_data_half_hex(i,:))]; 
% end 

bias_data = b2_read;

%% Get Maxpool Data
disp('Get Maxpool Data')
MP1_file = fopen('.\python_bins\maxpool1.bin');
% Essential Parameters 
H = 27; 
W = 27; 
C = 96;  

MP1_read_single = fread(MP1_file,[C*H*W,1],'double');
MP1_single = zeros(H,W,C);

% Hex_MP1_read_single = []; 
% for i=1:1:length(MP1_read_single)
%     Hex_MP1_read_single = [Hex_MP1_read_single; dec_to_hex_single(MP1_read_single(i))];
% end

% %% Convert to Floating Point Half Precision Hex
% disp('Convert to Floating Point Half Precision Hex'); 
% 
% maxpool_data_half_hex = []; 
% 
% for i = 1:1:length(MP1_read_single)
%         hex = dec_to_hex_single(MP1_read_single(i));  %
%         maxpool_data_half_hex = [maxpool_data_half_hex; [hex(1:4),'0000']]; %Make data Half Precision
% end 
% %% Convert to Decimal from Half Precision Hex
% disp('Convert to Decimal from Half Precision Hex')
% 
% maxpool_data = []; 
% 
% for i = 1:1:length(MP1_read_single)
%     maxpool_data = [maxpool_data; hex_to_dec_single(maxpool_data_half_hex(i,:))]; 
% end 
%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:C
    for HH = 1:1:H
        for WW = 1:1:W
            MP1_single(HH,WW,channels) = MP1_read_single(index,1); 
            index = index + 1; 
        end
    end 
end 
fclose('all');

MP1_single = permute(MP1_single,[3,1,2]); 
image_4d = zeros(1,C,H,W); 
image_4d(1,:,:,:) = MP1_single; 



%% Execute Convolution
disp('Execute Convolution')
stride = 1;
pad = 2;
    
conv_param = {pad, stride}; 
[out, cache] = conv_forward_naive(image_4d, W2_single, bias_data, conv_param); 

%% Convert Convolution Ouptut to Floating Point Single Precision Hex
disp('Convert Convolution Ouptut to Proper Formats')
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
fileID = fopen('.\script_txts\conv2_truth_data_32.txt','w');
for i = 1:1:length(out_data_reshape)
    data = hex_out_data(i,:);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\conv2_truth_data_8bit.txt','w');
for i = 1:1:out_char_8bit_size(1)
    data = out_char_8bit(i,1:2);  
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\conv2_truth_data_8bit.bin','w');
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

relu2_mask = out >= 0;
relu2 = out .* relu2_mask;

relu_data_permute = permute(relu2,[4,3,2,1]);
relu_data_reshape = reshape(relu_data_permute,[N*F*H*W,1]);

fileID = fopen('.\script_bins\relu2_data.bin','w');
for i = 1:1:length(relu_data_reshape)
    data = relu_data_reshape(i,:);
    fwrite(fileID,data,'single');
end
fclose(fileID);




%% Maxpool
disp('Execute Maxpool')
stride = 2;
PW = 3;
PH = 3; 
pool_param = {PW,PH, stride};
[max_out, cache] = max_pool_forward_naive(relu2, pool_param);

%% Convert MaxPool Ouptut to Floating Point Single Precision Hex
disp('Convert MaxPool Ouptut to Floating Point Hex')
[N,F,H,W] = size(max_out)

max_out_data_permute = permute(max_out,[4,3,2,1]);
max_out_data_reshape = reshape(max_out_data_permute,[N*F*H*W,1]);

hex_out_data = [];
max_out_char_8bit = [];
for i=1:1:length(max_out_data_reshape)
    hex = dec_to_hex_single(max_out_data_reshape(i));
    hex_out_data = [hex_out_data; hex];
    max_out_char_8bit = [max_out_char_8bit; hex(7:8); hex(5:6); hex(3:4); hex(1:2)];
end

max_out_char_8bit_size = size(max_out_char_8bit)
max_out_char_8bit_size(1)

%% Write MaxPool Output Truth File
disp('Write MP Output Truth File ')
fileID = fopen('.\script_txts\mp2_truth_data_32.txt','w');
for i = 1:1:length(max_out_data_reshape)
    data = hex_out_data(i,:); 
    fprintf(fileID, '%s\n',data);
end
fclose(fileID);

fileID = fopen('.\script_txts\mp2_truth_data_8bit.txt','w');
for i = 1:1:max_out_char_8bit_size(1)
    data = max_out_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end
fclose(fileID);

fileID = fopen('.\script_bins\mp2_truth_data.bin','w');
for i = 1:1:length(max_out_data_reshape)
    data = max_out_data_reshape(i,:);
    fwrite(fileID,data,'single');
end
fclose(fileID);





















% 
% 
% %% Get Modelsim Output
% disp('Getting Modelsim Simulation Output')
% num_channels = 256; 
% height = 27; 
% width = 27; 
% 
% 
% sim_file = fopen('.\conv2_output.txt','r'); 
% conv_sim_data_read = fscanf(sim_file,'%x'); %Will import as integer
% fclose(sim_file); 
% 
% conv_sim_data_hex_read = dec2hex(conv_sim_data_read); 
% 
% disp('Rearrange Data') 
% 
% % rearranged_data = reshape(conv_sim_data_read, [55,96,55]); 
% % rearranged_data_permute = permute(rearranged_data, [1,3,2]); 
% % rearranged_data_reshape = reshape(rearranged_data_permute,[55*55*96,1]); 
% 
% rearranged_data = zeros(height*width*num_channels,1); 
% for j = 1:1:27
%     for i = 1:1:256
%         i;
%         j;
%         %%rearranged_data(j,:,i) = conv_sim_data_read(1+55*(i-1):55+55*(i-1),1); 
%         from_start = 1+27*(i-1)+27*256*(j-1);
%         from_end = 27+27*(i-1)+27*256*(j-1);
%         to_start = 1+27*27*(i-1)+27*(j-1);
%         to_end = 27+27*27*(i-1)+27*(j-1);
%         rearranged_data(to_start:to_end,1) = conv_sim_data_read(from_start:from_end,1); 
%     end 
% end 
% 
% %rearranged_data_permute = permute(rearranged_data,[2,1,3]); 
% %rearranged_data_reshape = reshape(rearranged_data, [55*55*96,1]); 
% 
% 
% disp('Converting Data to Hex Integer')
% conv_sim_data_hex = dec2hex(rearranged_data); %Convert to hex
% [M,N] = size(conv_sim_data_hex);
% 
% %%Convert to Floating Point Single Precision
% disp('Convert to Floating Point Single Precision')
% conv_sim_data_hex_8 = []; 
% for i = 1:1:M
%     conv_sim_data_hex_8 = [conv_sim_data_hex_8; conv_sim_data_hex(i,:)];
% end
% 
% 
% %%Convert from Floating Point Single Precision to decimal
% disp('Convert from Floating Point Single Precision to decimal')
% conv_sim_data = []; 
% for i = 1:1:M
%     conv_sim_data = [conv_sim_data;hex_to_dec_single(conv_sim_data_hex_8(i,:))];  
% end
% 
% %% Write Conv Output Sim File 
% disp('Write Conv Output Rearranged File ')
% fileID = fopen('.\conv2_sim_reout_32.txt','w');
% for i = 1:1:M
%     data = conv_sim_data_hex_8(i,:);  
%     fprintf(fileID, '%s\n',data);
% end 
% fclose(fileID); 
% 
% 
% truth_data = conv_truth_data;
% sim_data = conv_sim_data;
% data_delta = abs(truth_data-sim_data);
% percent_diff = (data_delta./truth_data)*100.00;
% diff_average = sum(percent_diff)/length(percent_diff)
