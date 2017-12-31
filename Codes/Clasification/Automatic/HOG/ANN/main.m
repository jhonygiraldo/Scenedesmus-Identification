clear all, close all, clc;
load('../Hog.mat');
load('../salidas.mat');
mkdir('resultadosHog');
kfolds = 10;
classNumber = 4;
errorMatriz = [];
stdMatriz = [];
confusionMatriz = {};
vectorNeuronas = [5 10 15 20 25 30 35 40 45 50 55 60; ...
    5 10 15 20 25 30 35 40 45 50 55 60];
caracteristicas = [XHog salidas];
folds = crossValidationFolds(caracteristicas,kfolds,classNumber);
error = [];
%parpool;
pctRunOnAll warning('off');
parfor(i=1:kfolds)
    [trainingSet testSet] = extractTrainingTestSetFold(folds,i);
    salidasTrainingSet = trainingSet(:,end);
    salidasTestSet = testSet(:,end);
    trainingSet(:,end) = [];
    testSet(:,end) = [];
    [trainingSet testSet] = zscoreNormalization(trainingSet,testSet);
    [errorAux confusion] = trainingNeuralNetwork(trainingSet,testSet,salidasTrainingSet,salidasTestSet,vectorNeuronas);
    error(:,i) = errorAux;
    confusionMatriz{i} = confusion;
end
mediasError = mean(error');
mediasError = mediasError';
stdError = std(error');
stdError = stdError';
errorMatriz(:,1) = mediasError;
stdMatriz(:,1) = stdError;
save('resultadosHog/errorMatriz.mat','errorMatriz');
save('resultadosHog/stdMatriz.mat','stdMatriz');
save('resultadosHog/confusionMatriz.mat','confusionMatriz');