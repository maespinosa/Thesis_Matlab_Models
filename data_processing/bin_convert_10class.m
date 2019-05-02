fclose('all'); 
clear all; 
close all; 

% Essential Parameters 
H = 227; 
W = 227; 
C = 3;  

%% Get Input Data

disp('Get n02992529_59933 Data')

folder = '.\python_bins\n02992529_59933'; 
mean_data = 148.64771940719464; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 95.06333086788867; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%
disp('Get n02690373_6755 Data')

folder = '.\python_bins\n02690373_6755'; 
mean_data = 138.70201892785292; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 23.305629074847413; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n02690373_3435 Data')

folder = '.\python_bins\n02690373_3435'; 
mean_data = 126.14419711877454; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 33.62731720193337; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n02690373_17389 Data')

folder = '.\python_bins\n02690373_17389'; 
mean_data = 211.71277015531706; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 51.491373831438274; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n02708093_1783 Data')

folder = '.\python_bins\n02708093_1783'; 
mean_data = 135.02890281847763; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 79.74280806637773; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n02708093_3688 Data')

folder = '.\python_bins\n02708093_3688'; 
mean_data = 137.31801509829415; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 82.404894039195; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n03063599_3650 Data')

folder = '.\python_bins\n03063599_3650'; 
mean_data = 187.98363381138128; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 37.317697674263826; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n03063599_4149 Data')

folder = '.\python_bins\n03063599_4149'; 
mean_data = 76.73968056822372; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 81.67654478989937; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n03063599_5006 Data')

folder = '.\python_bins\n03063599_5006'; 
mean_data = 141.38373213788998; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 70.04364572003597; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

%%

disp('Get n03930630_24834 Data')

folder = '.\python_bins\n03930630_24834'; 
mean_data = 106.40409607534916; %mean(reshape(image_4d,[H*W*C,1])); 
std_dev = 54.77445770104519; %std(reshape(X1,[H*W*C,1]));
filename = strcat(folder,'.\input_image.bin'); 
image_file = fopen(filename);
image_read_single = fread(image_file,[C*H*W,1],'double');
bin_only = 1; 

input_image_translator(image_read_single,H,W,C,mean_data,std_dev,bin_only,folder); 

