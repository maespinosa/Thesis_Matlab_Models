fclose('all'); 
clear all; 
close all; 

%% IMAGE - Get Input Image file


% disp('Getting truth data from Python bin file')
% 
% image_data = imread('./input_image.jpg');
% imshow(image_data)
 figure_index = 1; 
% figure(figure_index)
% figure_index = figure_index + 1; 

%% CONV1 - Get Truth Data from Python file

num_channels = 96; 
height = 55; 
width = 55; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output.bin');
%conv_file = fopen('.\script_bins\conv1_truth.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv1_show = cnn_filter_images(conv_read,height,width,num_channels,8); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv1_show)


%% MP1 - Get Truth Data from Python file

num_channels = 96; 
height = 27; 
width = 27; 

disp('Getting truth data from Python bin file')

mp_file = fopen('.\test_bins\maxpool1_test_output.bin');

mp_read = fread(mp_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(mp_read);

mp1_show = cnn_filter_images(mp_read,height,width,num_channels,8); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(mp1_show)

%% CONV2 - Get Truth Data from Python file

num_channels = 256; 
height = 27; 
width = 27; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output_layer2.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv2_show = cnn_filter_images(conv_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv2_show)

%% MP2 - Get Truth Data from Python file

num_channels = 256; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

mp_file = fopen('.\test_bins\maxpool2_test_output.bin');

mp_read = fread(mp_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(mp_read);

mp2_show = cnn_filter_images(mp_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(mp2_show)

%% CONV3 - Get Truth Data from Python file

num_channels = 384; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output_layer3.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv3_show = cnn_filter_images(conv_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv3_show)

%% CONV4 - Get Truth Data from Python file

num_channels = 384; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output_layer4.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv4_show = cnn_filter_images(conv_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv4_show)

%% CONV5 - Get Truth Data from Python file

num_channels = 256; 
height = 13; 
width = 13; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output_layer5.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv5_show = cnn_filter_images(conv_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv5_show)

%% MP3 - Get Truth Data from Python file

num_channels = 256; 
height = 6; 
width = 6; 

disp('Getting truth data from Python bin file')

mp_file = fopen('.\test_bins\maxpool3_test_output.bin');

mp_read = fread(mp_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(mp_read);

mp3_show = cnn_filter_images(mp_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(mp3_show)

%% AFFINE1 - Get Truth Data from Python file

num_channels = 4096; 
height = 1; 
width = 1; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output_layer6.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv6_show = cnn_filter_images(conv_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv6_show)

%% AFFINE2 - Get Truth Data from Python file

num_channels = 4096; 
height = 1; 
width = 1; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output_layer7.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv7_show = cnn_filter_images(conv_read,height,width,num_channels,16); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv7_show)

%% AFFINE3 - Get Truth Data from Python file

num_channels = 10; 
height = 1; 
width = 1; 

disp('Getting truth data from Python bin file')

conv_file = fopen('.\test_bins\conv_test_output_layer8.bin');

conv_read = fread(conv_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(conv_read);

conv8_show = cnn_filter_images(conv_read,height,width,num_channels,1); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(conv8_show)
