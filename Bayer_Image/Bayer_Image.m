clear all; 
close all; 

pic = imread('blocks_rainbow_1280x720.jpg'); 
figure(1)
imshow(pic); 
[y,x,z] = size(pic); 

for rows = 1:1:y
    for cols = 1:1:x
        disp(['Row: ', num2str(rows),'Column:', num2str(cols)])
        if(mod(cols,2) ~= 0 && mod(rows,2) ~= 0) 
            new_pic(rows,cols) = pic(rows,cols,3); 
            pattern(rows,cols) = 3; 
        elseif(mod(cols,2) ~= 0 && mod(rows,2) == 0) 
            new_pic(rows,cols) = pic(rows,cols,2);
            pattern(rows,cols) = 2; 
        elseif(mod(cols,2) == 0 && mod(rows,2) ~= 0)  
            new_pic(rows,cols) = pic(rows,cols,2);
            pattern(rows,cols) = 2; 
        elseif(mod(cols,2) == 0 && mod(rows,2) == 0)  
            new_pic(rows,cols) = pic(rows,cols,1); 
            pattern(rows,cols) = 1; 
        else 
            new_pic(rows,cols) = 0;
            pattern(rows,cols) = 999; 
        end; 
    end; 
end; 


imwrite(new_pic,'test_image.jpg'); 
figure(2)
imshow(new_pic); 


image_array = [];  
for image_row = 1:1:y
    for image_column = 1:1:x
        image_array = [image_array,new_pic(image_row,image_column)]; 
    end 
end 

disp('Writing Test Image TXT File ...')

fileID = fopen('test_image.txt','w');
image_array = transpose(image_array);

for i = 1:1:x*y
    data = dec2hex(image_array(i),3); 
    fprintf(fileID, '%3s\n',data);
end 
fclose(fileID); 