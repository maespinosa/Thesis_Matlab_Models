clear all; 
close all; 
fclose('all'); 


%% Get Scores Data
disp('Get Scores Data')
scores_file = fopen('.\python_bins\affine3.bin');
% Essential Parameters 

num_classes = 10; 


scores_read = fread(scores_file,[num_classes,1],'double');

exp_data = exp(scores_read) 
sum_exp = sum(exp_data)
probs = exp_data./sum_exp
loss = -1*log(probs)