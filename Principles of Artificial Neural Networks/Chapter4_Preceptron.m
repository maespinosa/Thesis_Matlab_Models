% Principles of Artificial Neural Networks 

% Preceptron 

f1 = fopen('ESTIMATEBP1.dat','w'); 
fprintf(f1,'\nTHE FOLLOWING IS THE WEIGHT CHANGE AND THE MEAN SQUARE ERROR'); 
fprintf(f1,'\n------------------------------------------------------------\n\n'); 

w1 = rand(5,1)/5;                   % First set of randomly initialied weights 
w2 = rand(1)/5;                     % Second set of randomly initialied weights  
bias = 4.0;                         % For this example this is the White Gaussian Noise
delw2 = 0;                          % 
mu = 0.001; 
delw1 = 0; 
momentum= 0.5; 

n = 5;                              % N samples 

ITERATION = 2000; 
X = [randn(5,1); zeros(ITERATION-n,1)]; 
Xpad = zeros(ITERATION+n,1); 
Xpad(n+1:n+ITERATION) = X; 
Xest = zeros(ITERATION+n, 1);       %
error = zeros(size(X));             % Initialize the error vector 
MSE = zeros(200,1);                 % Initialize the Mean Square Error Vector 
count = 1; 

for loop = 1:1:400
    totalerr = 0; 
    for i = n+1:n+ITERATION
        xt = Xpad(i-n:i-1); 
        dt = Xpad(i); 
        z1 = w1'*xt + w2*bias; 
        error(i) = dt - z1; 
        phi_o = (dt-z1)*xt; 
        delw1 = mu*phi_o + momentum*delw1; 
        delw2 = mu*(dt-z1)*bias + momentum*delw2;
        w1 = w1 + delw1; 
        w2 = w2 + delw2; 
        if (round(i/500)*500 == i)
            fprintf(f1, '\n\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3',fliplr(w1')); 
            if (mu > 0.0000001) 
                mu = mu/ 1.01; 
            end 
        end 
    end 
    if (round(loop/1)*1 == loop)
        MSE(loop) = (error'*error)/ITERATION; 
        fprintf(f1, '\n\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3',fliplr(w1')); 
        fprintf(f1, '\n    %d\t      MEANSQUARE ERROR = %6.4f\n\n',loop, MSE(loop)); 
        disp([loop   fliplr(w1')])
        momentum= momentum/ 1.00001; 
        if MSE < 0.019 
            loop = 1000
        end 
    end 
end 

fclose(f1); 
