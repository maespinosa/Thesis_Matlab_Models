clear all; 
close all; 

pic = imread('test_image.jpg'); 
figure(1)
imshow(pic); 
[y,x,z] = size(pic); 

% Shift all values down buy 4 bits 
pic_scaled = floor(15.0*double(pic)/255.0); 
%pic_scaled = floor(double(pic)/16.0); 
%pic_scaled(pic_scaled >= 15) = 15.0; 

r = pic_scaled(:,:,1);
g = pic_scaled(:,:,2);
b = pic_scaled(:,:,3);
figure(2)
imshow(uint8(pic_scaled)); 
[y,x,z] = size(pic_scaled);

pic_concat_input = []; %zeros(y*x,1);


for rows = 1:1:y
    for cols = 1:1:x
        %disp(['Row: ', num2str(rows),'Column:', num2str(cols)]) ;     
        pic_concat_input = [pic_concat_input, pic_scaled(rows, cols, 1), pic_scaled(rows, cols, 2)*16 + pic_scaled(rows, cols, 3)]; 
    end; 
end; 


disp('Writing Test Image TXT File ...')

fileID = fopen('test_image_input.txt','w');
image_array = transpose(pic_concat_input);

for i = 1:1:x*y*2
    data = dec2hex(uint16(pic_concat_input(i)),3); 
    fprintf(fileID, '0x0000%3s\r\n',data);
end 
fclose(fileID); 

pic_concat_output = []; %zeros(y*x,1);
pic_concat_input = uint16(pic_concat_input); 

for i = 1:2:length(pic_concat_input)-1
        %disp(['Row: ', num2str(rows),'Column:', num2str(cols)]) ;     
        pic_concat_output = [pic_concat_output, pic_concat_input(i)*256 + pic_concat_input(i + 1)]; 

end 


disp('Writing Test Image TXT File ...')

fileID = fopen('test_image_output.txt','w');
image_array = transpose(pic_concat_output);

for i = 1:1:x*y
    data = dec2hex(uint16(pic_concat_output(i)),3); 
    fprintf(fileID, '0x0000%3s\r\n',data);
end 
fclose(fileID); 