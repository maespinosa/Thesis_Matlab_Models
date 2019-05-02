clear all
close all 
tic

%Read Original Image
disp('Reading Original Image ...')

pic = imread('earth.png');
pic = double(pic);
[M,N,Z] =size(pic);

%Display Original Image
disp('Showing Original Image ...')
figure(1)
imshow(uint8(pic))

%Normalize between 0 and 1
% pic = pic./255.0;

%Define Variables 
pic_I = []; 

% 
%Calculate Intensity from RGB
%============================
disp('Calculating Intensity from RGB ...')
for i = 1:1:M
    for j = 1:1:N
        R = pic(i,j,1); 
        G = pic(i,j,2); 
        B = pic(i,j,3); 
        
        I = (1.0/3.0)*(R+G+B);
        pic_I(i,j) = I;
    end
end

pic_I = uint8(pic_I); 
imwrite(pic_I, 'earth_bw.jpg');
figure(2)
imshow('earth_bw.jpg');  

%Add Noise
disp('Adding Noise ...')

% %Add salt and pepper noise to image 
% pic_I_noisy = imnoise(pic_I, 'salt & pepper'); 

%Add gaussian noise to image 
pic_I_noisy = imnoise(pic_I, 'gaussian',0,0.01); 

imwrite(pic_I_noisy, 'earth_bw_noisy.jpg');
figure(3)
imshow('earth_bw_noisy.jpg');  

%Select portion of image 64x672
disp('Cutting Tile 64x672...')
tile = pic_I_noisy(832:832+63,632:632+671);
imwrite(tile, 'earth_tile.jpg');
figure(4)
imshow('earth_tile.jpg'); 

%Show Cross Scan CMF Filtered Image
disp('Showing Cross Scan CMF Filtered Images...')

filtered = cmf_xscan(tile,5,[1 0 1 0 1]);
filtered = uint8(filtered); 
imwrite(filtered, 'filtered_tile_3of5.jpg');
figure(5); 
imshow('filtered_tile_3of5.jpg')

% filtered = cmf_xscan(tile,7,[1 1 0 1 0 1 1]);
% filtered = uint8(filtered);
% imwrite(filtered, 'filtered_tile_5of7.jpg');
% figure(6); 
% imshow('filtered_tile_5of7.jpg')
% 
% filtered = cmf_xscan(tile,9,[1 1 1 0 1 0 1 1 1]);
% filtered = uint8(filtered);
% imwrite(filtered, 'filtered_tile_7of9.jpg');
% figure(7); 
% imshow('filtered_tile_7of9.jpg')
% 
% filtered = cmf_xscan(tile,11,[1 1 1 1 0 1 0 1 1 1 1]);
% filtered = uint8(filtered);
% imwrite(filtered, 'filtered_tile_9of11.jpg');
% figure(8); 
% imshow('filtered_tile_9of11.jpg')
% 
% filtered = cmf_xscan(tile,13,[1 1 1 1 1 0 1 0 1 1 1 1 1]);
% filtered = uint8(filtered);
% imwrite(filtered, 'filtered_tile_11of13.jpg');
% figure(9); 
% imshow('filtered_tile_11of13.jpg')
% 
% filtered = cmf_xscan(tile,15,[1 1 1 1 1 1 0 1 0 1 1 1 1 1 1]);
% filtered = uint8(filtered);
% imwrite(filtered, 'filtered_tile_13of15.jpg');
% figure(10); 
% imshow('filtered_tile_13of15.jpg')


tile_array = [];  
for tile_row = 1:1:64
    for tile_column = 1:1:672
        tile_array = [tile_array,tile(tile_row,tile_column)]; 
    end 
end 

filtered_tile_array = []; 
for filtered_tile_row = 1:1:64
    for filtered_tile_column = 1:1:672
        filtered_tile_array = [filtered_tile_array,filtered(filtered_tile_row,filtered_tile_column)]; 
    end 
end 

% disp('Writing BIN File ...')
% 
% % Open and write bin file
% fileID = fopen('test_tile.bin','w'); 
% fwrite(fileID, tile_array, 'uint16'); 
% fclose(fileID); 


disp('Writing Test Tile TXT File ...')

fileID = fopen('test_tile.txt','w');
tile_array = transpose(tile_array);

for i = 1:1:43008
    data = dec2hex(tile_array(i),4); 
    fprintf(fileID, '%4s\n',data);
end 
fclose(fileID); 


disp('Writing Filtered Tile TXT File ...')

fileID = fopen('mfiltered_test_tile.txt','w');
filtered_tile_array = transpose(filtered_tile_array);

for i = 1:1:43008
    filtered_data = dec2hex(filtered_tile_array(i),4); 
    fprintf(fileID, '%4s\n',filtered_data);
end 
fclose(fileID); 


toc
