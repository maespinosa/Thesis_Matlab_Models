fclose('all'); 
clear all; 
close all; 

%% W1 - Get Truth Data from Python file

num_channels = 96*3; 
height = 11; 
width = 11; 

disp('Getting truth data from Python bin file')

weight_file = fopen('.\python_bins\W1.bin');

weight_read = fread(weight_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(weight_read);

weight_show = cnn_filter_images(weight_read,height,width,num_channels,8); 
figure_index = 1; 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(weight_show)

%% W2 - Get Truth Data from Python file

num_channels = 256; 
height = 5; 
width = 5; 

disp('Getting truth data from Python bin file')

weight_file = fopen('.\python_bins\W2.bin');

weight_read = fread(weight_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(weight_read);

weight_show = cnn_filter_images(weight_read,height,width,num_channels,8); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(weight_show)

%% W3 - Get Truth Data from Python file

num_channels = 384; 
height = 3; 
width = 3; 

disp('Getting truth data from Python bin file')

weight_file = fopen('.\python_bins\W3.bin');

weight_read = fread(weight_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(weight_read);

weight_show = cnn_filter_images(weight_read,height,width,num_channels,8); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(weight_show)

%% W4 - Get Truth Data from Python file

num_channels = 384; 
height = 3; 
width = 3; 

disp('Getting truth data from Python bin file')

weight_file = fopen('.\python_bins\W4.bin');

weight_read = fread(weight_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(weight_read);

weight_show = cnn_filter_images(weight_read,height,width,num_channels,8); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(weight_show)


%% W5 - Get Truth Data from Python file

num_channels = 256; 
height = 3; 
width = 3; 

disp('Getting truth data from Python bin file')

weight_file = fopen('.\python_bins\W5.bin');

weight_read = fread(weight_file,[num_channels*height*width,1],'single'); %File saved as 64bit Floating Point Double Precision 
[R,C] = size(weight_read);

weight_show = cnn_filter_images(weight_read,height,width,num_channels,8); 
figure(figure_index)
figure_index = figure_index + 1; 
imshow(weight_show)

