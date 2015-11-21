function main2

cleanData = load('cleandata_students.mat');
noisyData = load('noisydata_students.mat');
[x2, y2] = ANNdata(cleanData.x, cleanData.y);
%the number of neurons in the input layer is 45 (the number of attributes),
%and the number of neurons in the output layer is six neurons,
net = feedforwardnet(5);
%[net] = feedforwardnet([S1, S2...SNl], trainFcn)
net.trainFcn = 'traingd';
net = configure(net, x2, y2);

net.trainParam.epochs = 1000;
net.trainParam.lr = 0.1;
%goal,lr,lr_inc,lr_drc,mc,min_grad,show,time

%{
trainlm
- Gradient descent backpropagation (traingd) ? Parameter: learning rate (lr).
- Gradient descent with adaptive learning rate backpropagation (traingda) ? Parameters: learning rate (lr), ratio increase/decrease learning rate (lr_inc, lr_dec).
- Gradient descent with momentum backpropagation (traingdm) ? Parameters: learning rate (lr), momentum constant (mc).
- Resilient backpropagation (trainrp) ? Parameters: Increment/Decrement to weight change (delt_inc/delt_dec).
%}
 
net = train(net, x2, y2);

predictions = testANN(net, x2);
%plot(x2, y2, x2, Y, 'r.' );


%predictions = testANN(net, x2);



end