function data_show = cnn_filter_images(layer_output, height, width, num_channels,display_rows)


data = zeros(height,width,num_channels);

index = 1; 

for channels = 1:1:num_channels 
    for HH = 1:1:height 
        for WW = 1:1:width
            data(HH,WW,channels) = layer_output(index,1); 
            index = index + 1; 
        end 
    end 
end


% data_shifted = zeros(size(data)); 
% for channels = 1:1:num_channels
%     min_data = min(min(data(channels))); 
%     data_shifted(:,:,channels) = data(:,:,channels) + min_data; 
%     data_max = max(max(data_shifted(:,:,channels))); 
%     data_scaled(:,:,channels) = (data_shifted(:,:,channels).*255)./data_max; 
% end  

%data_uint = uint8(data_scaled); 
data_show = zeros([display_rows*height,(num_channels/display_rows)*width]); 
column_counter = 0;
row_counter = 0; 

for channels = 1:1:num_channels 


    %data_temp = zeros([height,width,3]); 
    %data_temp(:,:,1) = data_uint(:,:,channels);    
    %data_temp(:,:,2) = data_uint(:,:,channels); 
    %data_temp(:,:,3) = data_uint(:,:,channels); 
    test = mat2gray(data(:,:,channels));
    amax = max(max(test(:,:)));
    amin = min(min(test(:,:)));
    data_show(row_counter*height + 1:row_counter*height + height, column_counter*width + 1: column_counter*width + width) = mat2gray(data(:,:,channels));%,[amin,amax]);%data_temp; 
    
    if(column_counter == (num_channels/display_rows)-1) 
        row_counter = row_counter + 1; 
        column_counter = 0; 
    else 
        column_counter = column_counter + 1; 
    end 
end 
