function [X_train,X_val,X_test,y_train,y_val,y_test] = get_CIFAR10_data()

disp('GET CIFAR10 DATA')
disp('===================================================================')
batch1 = load('./cifar-10-batches-mat/data_batch_1.mat'); 
X_b1 = reshape(batch1.data, [10000,3,32,32]);
X_b1 = permute(X_b1, [1 3 4 2]);
Y_b1 = batch1.labels; 

batch2 = load('./cifar-10-batches-mat/data_batch_2.mat');
X_b2 = reshape(batch2.data, [10000,3,32,32]);
X_b2 = permute(X_b2, [1 3 4 2]);
Y_b2 = batch2.labels; 

batch3 = load('./cifar-10-batches-mat/data_batch_3.mat');
X_b3 = reshape(batch3.data, [10000,3,32,32]);
X_b3 = permute(X_b3, [1 3 4 2]);
Y_b3 = batch3.labels; 

batch4 = load('./cifar-10-batches-mat/data_batch_4.mat');
X_b4 = reshape(batch4.data, [10000,3,32,32]);
X_b4 = permute(X_b4, [1 3 4 2]);
Y_b4 = batch4.labels; 

batch5 = load('./cifar-10-batches-mat/data_batch_5.mat');
X_b5 = reshape(batch5.data, [10000,3,32,32]);
X_b5 = permute(X_b5, [1 3 4 2]);
Y_b5 = batch5.labels; 

X = zeros(50000,32,32,3);
X(1:10000,:,:,:) = X_b1; 
X(10001:20000,:,:,:) = X_b2;
X(20001:30000,:,:,:) = X_b3;
X(30001:40000,:,:,:) = X_b4;
X(40001:50000,:,:,:) = X_b5;


Y = [Y_b1; Y_b2; Y_b3; Y_b4; Y_b5]; 

test_batch = load('./cifar-10-batches-mat/test_batch.mat'); 
X_test = reshape(test_batch.data, [10000,3,32,32]);
X_test = permute(X_test, [1 3 4 2]);
Y_test = test_batch.labels; 

num_training = 49000;
num_validation = 1000;
num_test = 1000;

X_val = X(num_training:num_training + num_validation-1,:,:,:); 
y_val = Y(num_training:num_training + num_validation-1); 

X_train = X(1:num_training,:,:,:); 
y_train = Y(1:num_training); 

X_test = double(X_test(1:num_test,:,:,:)); 
y_test = Y_test(1:num_test); 

mean_image = mean(X_train, 1);
size(mean_image);

[N Y X Z] = size(X_train); 
for i = 1:1:N 
    X_train(N,:,:,:) = X_train(N,:,:,:) - mean_image; 
end 

[N Y X Z] = size(X_val); 
for i = 1:1:N 
    X_val(N,:,:,:) = X_val(N,:,:,:) - mean_image; 
end

[N Y X Z] = size(X_test)                                                                                                                                                                                            
for i = 1:1:N 
    X_test(N,:,:,:) = X_test(N,:,:,:) - mean_image; 
end


X_train = permute(X_train, [1 4 2 3]);
size(X_train);
X_val = permute(X_val, [1 4 2 3]);
X_test = permute(X_test, [1 4 2 3]);


end

