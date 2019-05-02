function input_image_translator(image_read_single, H,W,C,mean_data, std_dev,bin_only,folder)

image_single = zeros(H,W,C);


%% Rearrange Data into Image Matrix
disp('Rearrange Data into Image Matrix')
index = 1; 

for channels = 1:1:C
    for HH = 1:1:H
        for WW = 1:1:W
            image_single(HH,WW,channels) = image_read_single(index,1); 
            index = index + 1; 
        end
    end 
end 
fclose('all');


%mean_data = 148.64771940719464; %mean(reshape(image_4d,[H*W*C,1])); 
mean_data_array = mean_data.*ones(size(image_single)); 
X1 = image_single - mean_data; 
%std_dev = 95.06333086788867; %std(reshape(X1,[H*W*C,1])); 
X2 = X1./std_dev;


% image_data = imread('input_image.jpg'); 
% [H,W,C]= size(image_single); 
% 
% imshow(image_single)

image_permute = permute(X2,[2,1,3]); 
image_reshape = reshape(image_permute,[H*W*C,1]);

disp('Writing Image TXT File ...')

if(bin_only == 0)
    image_reshape_size=size(image_reshape);
    image_reshape_size(1)

    %hex_image_reshape = num2hex(single(image_reshape)); 

    hex_image_reshape = []; 
    image_char_8bit = []; 
    image_char_32bit = []; 
    for i = 1:1:length(image_reshape)
        %image_reshape(i)
        char_data = dec_to_hex_single(image_reshape(i)); 
        hex_image_reshape = [hex_image_reshape; dec_to_hex_single(double(image_reshape(i)))]; 
        image_char_8bit = [image_char_8bit; char_data(3:4); char_data(1:2)]; 
        image_char_32bit = [image_char_32bit; char_data(7:8);char_data(5:6);char_data(3:4); char_data(1:2)];
    end

    image_char_8bit_size =size(image_char_8bit)
    image_char_8bit_size(1)
    image_char_32bit_size =size(image_char_32bit)
    image_char_32bit_size(1)
    foldername = strcat(folder,'.\input_image_coe.txt'); 
    fileID = fopen(foldername,'w');
    for i = 1:1:image_reshape_size(1)
        data = hex_image_reshape(i,1:4); 
        fprintf(fileID, '%s,\n',data(1:4));
    end 
    fclose(fileID); 
    foldername = strcat(folder,'.\input_image.txt'); 
    fileID = fopen(foldername,'w');
    for i = 1:1:image_reshape_size(1)
        data = hex_image_reshape(i,1:4);  
        fprintf(fileID, '%s\n',data(1:4));
    end 
    fclose(fileID); 
    foldername = strcat(folder,'.\input_image_8bit.txt'); 
    fileID = fopen(foldername,'w');
    for i = 1:1:image_char_8bit_size(1)
        data = image_char_8bit(i,1:2);  
        fprintf(fileID, '%s\n',data);
    end 
    fclose(fileID); 
    foldername = strcat(folder,'.\input_image_32bit.txt'); 
    fileID = fopen(foldername,'w');
    for i = 1:1:image_reshape_size(1)
        data = image_char_32bit(i,1:2);  
        fprintf(fileID, '%s,\n',data);
    end 
    fclose(fileID); 
else 
    foldername = strcat(folder,'.\input_image_single.bin'); 
    fileID = fopen(foldername,'w');
    for i = 1:1:length(image_reshape)
        data = image_reshape(i,:); 
        fwrite(fileID,data,'single');
    end 
    fclose(fileID); 
end 
% 
% 
% hex_image_reshape = []; 
% for i = 1:2:length(image_reshape)
%     %image_reshape(i)
%     if(i+1 > length(image_reshape))
%         hex_image_reshape = [hex_image_reshape;  dec_to_hex_single(0),dec_to_hex_single(image_reshape(i))]; 
%     else 
%         hex_image_reshape = [hex_image_reshape;  dec_to_hex_single(image_reshape(i+1)),dec_to_hex_single(image_reshape(i))];  
%     end  
% end
% 
% fileID = fopen('.\input_image_coe_32.txt','w');
% for i = 1:1:image_reshape_size(1)/2
%     data = [hex_image_reshape(i,1:4), hex_image_reshape(i,9:12)]; 
%     fprintf(fileID, '%s,\n',data(1:8));
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\input_image_32.txt','w');
% for i = 1:1:image_reshape_size(1)/2
%     data = [hex_image_reshape(i,1:4), hex_image_reshape(i,9:12)]; 
%     fprintf(fileID, '%s\n',data(1:8));
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\input_image_coe.txt','w');
% for i = 1:1:image_reshape_size(1)
%     data = num2hex(double(image_reshape(i))); 
%     fprintf(fileID, '%s,\n',data(1:4));
% end 
% fclose(fileID); 
% 
% fileID = fopen('.\input_image.txt','w');
% for i = 1:1:image_reshape_size(1)
%     data = num2hex(double(image_reshape(i)));  
%     fprintf(fileID, '%s\n',data(1:4));
% end 
% fclose(fileID); 