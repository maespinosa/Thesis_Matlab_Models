fclose('all'); 
clear all; 
close all; 

% Essential Parameters 
H = 227; 
W = 227; 
C = 3;  

%% Get Images From File 
disp('Get Image 1')
image_data1 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n02690373_3435_scaled.jpg');
image_data2 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n02708093_1783_scaled.jpg');
image_data3 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n02992529_59933_scaled.jpg');
image_data4 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n02690373_6755_scaled.jpg');
image_data5 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n03930630_24834_scaled.jpg');
image_data6 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n02708093_3688_scaled.jpg');
image_data7 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n02690373_17389_scaled.jpg');
image_data8 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n03063599_3650_scaled.jpg');
image_data9 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n03063599_4149_scaled.jpg');
image_data10 = imread('C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\n03063599_5006_scaled.jpg');

mural = []
mural = [image_data1,image_data2, image_data3, image_data4, image_data5; image_data6,image_data7, image_data8, image_data9, image_data10]; 
imshow(mural)

imwrite(mural,'C:\Users\Mark_Espinosa\Documents\A_CNN_Model\archive\10_Class\input_data\mural.jpg'); 

%imshow(image_data1)
%image_read_single = fread(image_file1,[C*H*W,1],'double');
%image_single = zeros(H,W,C);
