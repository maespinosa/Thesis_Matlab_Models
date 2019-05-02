fclose('all'); 
clear all; 
close all; 

%% Convert B1 Data
disp('Converting b1 data')

b1_file = fopen('.\python_bins\b1.bin');
b1_num_filters = 96; 
b1_read = fread(b1_file,[b1_num_filters,1],'double');

fclose('all');

%% Writing b1 TXT File
disp('Writing b1 TXT File ...')

b1_char = []; 
b1_char_8bit = []; 
for i = 1:1:length(b1_read)
    char_data = dec_to_hex_single(b1_read(i)); 
    b1_char = [b1_char; dec_to_hex_single(b1_read(i))]; 
    b1_char_8bit = [b1_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

b1_char_size=size(b1_char)
b1_char_size(1)
b1_char_8bit_size =size(b1_char_8bit)
b1_char_8bit_size(1)

fileID = fopen('.\script_txts\b1_coe.txt','w');
for i = 1:1:b1_char_size(1)
    data = b1_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b1.txt','w');
for i = 1:1:b1_char_size(1)
    data = b1_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b1_8bit.txt','w');
for i = 1:1:b1_char_8bit_size(1)
    data = b1_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b1_single.bin','w');
for i = 1:1:length(b1_read)
    data = b1_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 



%% Convert B2 Data
disp('Converting b2 data')

b2_file = fopen('.\python_bins\b2.bin');
b2_num_filters = 256; 
b2_read = fread(b2_file,[b2_num_filters,1],'double');

fclose('all');

%% Writing b2 TXT File
disp('Writing b2 TXT File ...')

b2_char = []; 
b2_char_8bit = []; 
for i = 1:1:length(b2_read)
    char_data = dec_to_hex_single(b2_read(i)); 
    b2_char = [b2_char; dec_to_hex_single(b2_read(i))]; 
    b2_char_8bit = [b2_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

b2_char_size=size(b2_char)
b2_char_size(1)
b2_char_8bit_size =size(b2_char_8bit)
b2_char_8bit_size(1)

fileID = fopen('.\script_txts\b2_coe.txt','w');
for i = 1:1:b2_char_size(1)
    data = b2_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b2.txt','w');
for i = 1:1:b2_char_size(1)
    data = b2_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b2_8bit.txt','w');
for i = 1:1:b2_char_8bit_size(1)
    data = b2_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b2_single.bin','w');
for i = 1:1:length(b2_read)
    data = b2_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert B3 Data
disp('Converting B3 data')

B3_file = fopen('.\python_bins\B3.bin');
B3_num_filters = 384; 
B3_read = fread(B3_file,[B3_num_filters,1],'double');

fclose('all');

%% Writing B3 TXT File
disp('Writing B3 TXT File ...')

B3_char = []; 
B3_char_8bit = []; 
for i = 1:1:length(B3_read)
    char_data = dec_to_hex_single(B3_read(i)); 
    B3_char = [B3_char; dec_to_hex_single(B3_read(i))]; 
    B3_char_8bit = [B3_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

B3_char_size=size(B3_char)
B3_char_size(1)
B3_char_8bit_size =size(B3_char_8bit)
B3_char_8bit_size(1)

fileID = fopen('.\script_txts\b3_coe.txt','w');
for i = 1:1:B3_char_size(1)
    data = B3_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b3.txt','w');
for i = 1:1:B3_char_size(1)
    data = B3_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b3_8bit.txt','w');
for i = 1:1:B3_char_8bit_size(1)
    data = B3_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b3_single.bin','w');
for i = 1:1:length(B3_read)
    data = B3_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert B4 Data
disp('Converting b4 data')

b4_file = fopen('.\python_bins\b4.bin');
b4_num_filters = 384; 
b4_read = fread(b4_file,[b4_num_filters,1],'double');

fclose('all');

%% Writing b4 TXT File
disp('Writing b4 TXT File ...')

b4_char = []; 
b4_char_8bit = []; 
for i = 1:1:length(b4_read)
    char_data = dec_to_hex_single(b4_read(i)); 
    b4_char = [b4_char; dec_to_hex_single(b4_read(i))]; 
    b4_char_8bit = [b4_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

b4_char_size=size(b4_char)
b4_char_size(1)
b4_char_8bit_size =size(b4_char_8bit)
b4_char_8bit_size(1)

fileID = fopen('.\script_txts\b4_coe.txt','w');
for i = 1:1:b4_char_size(1)
    data = b4_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b4.txt','w');
for i = 1:1:b4_char_size(1)
    data = b4_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b4_8bit.txt','w');
for i = 1:1:b4_char_8bit_size(1)
    data = b4_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b4_single.bin','w');
for i = 1:1:length(b4_read)
    data = b4_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 





%% Convert B5 Data
disp('Converting b5 data')

b5_file = fopen('.\python_bins\b5.bin');
b5_num_filters = 256; 
b5_read = fread(b5_file,[b5_num_filters,1],'double');

fclose('all');

%% Writing b5 TXT File
disp('Writing b5 TXT File ...')

b5_char = []; 
b5_char_8bit = []; 
for i = 1:1:length(b5_read)
    char_data = dec_to_hex_single(b5_read(i)); 
    b5_char = [b5_char; dec_to_hex_single(b5_read(i))]; 
    b5_char_8bit = [b5_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

b5_char_size=size(b5_char)
b5_char_size(1)
b5_char_8bit_size =size(b5_char_8bit)
b5_char_8bit_size(1)

fileID = fopen('.\script_txts\b5_coe.txt','w');
for i = 1:1:b5_char_size(1)
    data = b5_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b5.txt','w');
for i = 1:1:b5_char_size(1)
    data = b5_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b5_8bit.txt','w');
for i = 1:1:b5_char_8bit_size(1)
    data = b5_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b5_single.bin','w');
for i = 1:1:length(b5_read)
    data = b5_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert B6 Data
disp('Converting b6 data')

b6_file = fopen('.\python_bins\b6.bin');
b6_num_filters = 4096; 
b6_read = fread(b6_file,[b6_num_filters,1],'double');
b6_read = zeros(b6_num_filters,1);

fclose('all');

%% Writing b6 TXT File
disp('Writing b6 TXT File ...')

b6_char = []; 
b6_char_8bit = []; 
for i = 1:1:length(b6_read)
    char_data = dec_to_hex_single(b6_read(i)); 
    b6_char = [b6_char; dec_to_hex_single(b6_read(i))]; 
    b6_char_8bit = [b6_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

b6_char_size=size(b6_char)
b6_char_size(1)
b6_char_8bit_size =size(b6_char_8bit)
b6_char_8bit_size(1)

fileID = fopen('.\script_txts\b6_coe.txt','w');
for i = 1:1:b6_char_size(1)
    data = b6_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b6.txt','w');
for i = 1:1:b6_char_size(1)
    data = b6_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b6_8bit.txt','w');
for i = 1:1:b6_char_8bit_size(1)
    data = b6_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b6_single.bin','w');
for i = 1:1:length(b6_read)
    data = b6_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 




%% Convert b7 Data
disp('Converting b7 data')

b7_file = fopen('.\python_bins\b7.bin');
b7_num_filters = 4096; 
b7_read = fread(b7_file,[b7_num_filters,1],'double');
%b7_read = zeros(b7_num_filters,1);

fclose('all');

%% Writing b7 TXT File
disp('Writing b7 TXT File ...')

b7_char = []; 
b7_char_8bit = []; 
for i = 1:1:length(b7_read)
    char_data = dec_to_hex_single(b7_read(i)); 
    b7_char = [b7_char; dec_to_hex_single(b7_read(i))]; 
    b7_char_8bit = [b7_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

b7_char_size=size(b7_char)
b7_char_size(1)
b7_char_8bit_size =size(b7_char_8bit)
b7_char_8bit_size(1)

fileID = fopen('.\script_txts\b7_coe.txt','w');
for i = 1:1:b7_char_size(1)
    data = b7_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b7.txt','w');
for i = 1:1:b7_char_size(1)
    data = b7_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b7_8bit.txt','w');
for i = 1:1:b7_char_8bit_size(1)
    data = b7_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b7_single.bin','w');
for i = 1:1:length(b7_read)
    data = b7_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 



%% Convert b8 Data
disp('Converting b8 data')

b8_file = fopen('.\python_bins\b8.bin');
b8_num_filters = 4096; 
b8_read = fread(b8_file,[b8_num_filters,1],'double');
%b8_read = zeros(b8_num_filters,1);

fclose('all');

%% Writing b8 TXT File
disp('Writing b8 TXT File ...')

b8_char = []; 
b8_char_8bit = []; 
for i = 1:1:length(b8_read)
    char_data = dec_to_hex_single(b8_read(i)); 
    b8_char = [b8_char; dec_to_hex_single(b8_read(i))]; 
    b8_char_8bit = [b8_char_8bit; char_data(7:8); char_data(5:6); char_data(3:4); char_data(1:2)];
end 

b8_char_size=size(b8_char)
b8_char_size(1)
b8_char_8bit_size =size(b8_char_8bit)
b8_char_8bit_size(1)

fileID = fopen('.\script_txts\b8_coe.txt','w');
for i = 1:1:b8_char_size(1)
    data = b8_char(i,1:4); 
    fprintf(fileID, '%s,\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b8.txt','w');
for i = 1:1:b8_char_size(1)
    data = b8_char(i,1:4); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_txts\b8_8bit.txt','w');
for i = 1:1:b8_char_8bit_size(1)
    data = b8_char_8bit(i,1:2); 
    fprintf(fileID, '%s\n',data);
end 
fclose(fileID); 

fileID = fopen('.\script_bins\b8_single.bin','w');
for i = 1:1:length(b8_read)
    data = b8_read(i,:); 
    fwrite(fileID,data,'single');
end 
fclose(fileID); 
