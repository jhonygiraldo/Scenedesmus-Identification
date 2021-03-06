clear all, close all, clc;
load('../Lbp.mat');
load('../salidas.mat');
mkdir('resultadosLbp');
kfolds = 10;
classNumber = 4;
errorMatriz = [];
stdMatriz = [];
confusionMatriz = {};
vectorNeuronas = [5 10 15 20 25 30 35 40 45 50 55 60; ...
    5 10 15 20 25 30 35 40 45 50 55 60];
caracteristicas = [XLbp salidas];
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
save('resultadosLbp/errorMatriz.mat','errorMatriz');
save('resultadosLbp/stdMatriz.mat','stdMatriz');
save('resultadosLbp/confusionMatriz.mat','confusionMatriz');