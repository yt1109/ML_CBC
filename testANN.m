function predictions = testANN(net, x2)
%{
net = a neural network, x2 = examples x2 
produces a vector of label predictions
%}

    predictions = zeros(size(x2, 1));
    %steps through each row of examples, and predict a label
    for i = 1: size(x2, 1)
        t = sim(net, x2(1, :));
        predictions(i) = NNout2labels(t);
    end
end

function prediction = NNout2labels(t)
% t is the output of a feed-forwarded Neural Network 
% predictions is the corresponding output in the format that 1 = anger, 2 = disgust etc.
	prediction = 0;
	for i = 1: size(t, 2)
        if (t(i) == 1) 
            prediction = i;
        end
	end
end