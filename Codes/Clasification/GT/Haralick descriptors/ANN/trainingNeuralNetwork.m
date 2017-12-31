function [error confusion] = trainingNeuralNetwork(trainingSet,testSet,salidasTrainingSet,salidasTestSet,vectorNeurons)
numTraining = size(vectorNeurons,2);
confusion = cell(numTraining,1);
error = zeros(numTraining,1);
salidasTrainingSetRed = zeros(size(salidasTrainingSet,1),max(salidasTrainingSet));
for(i=1:size(salidasTrainingSet,1))
    salidasTrainingSetRed(i,salidasTrainingSet(i)) = 1;
end
for(i=1:numTraining)
    net = patternnet(vectorNeurons(:,i)');
    %net.divideParam.trainRatio = 1;
    %net.divideParam.valRatio = 0;
    %net.divideParam.testRatio = 0;
    %net.trainparam.epochs = 3000;
    %net.trainparam.min_grad=1e-4;
    %net = train(net,trainingSet',salidasTrainingSetRed');
    %net = train(net,trainingSet',salidasTrainingSetRed','useParallel','yes','showResources','yes');
    net = train(net,trainingSet',salidasTrainingSetRed');
    salidasRed = net(testSet');
    [dummy, salidasRed] = max(salidasRed', [], 2);
    error(i) = (sum(salidasRed ~= salidasTestSet))/(size(testSet,1));
    confusion{i,1} = confusionmat(salidasTestSet,salidasRed);
end