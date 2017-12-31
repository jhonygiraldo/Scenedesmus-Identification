clear all, close all, clc;
load('../Zernike.mat');
load('../salidas.mat');
mkdir('resultadosZernike');
XZernike([421:500 921:1000 1421:1500 1921:2000],:) = [];
salidas([421:500 921:1000 1421:1500 1921:2000]) = [];
kfolds = 10;
classNumber = 4;
errorMatriz = [];
stdMatriz = [];
confusionMatriz = {};
vectorNeuronas = [5 10 15 20 25 30 35 40 45 50 55 60; ...
    5 10 15 20 25 30 35 40 45 50 55 60];
caracteristicas = [XZernike salidas];
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
errorMatriz = [errorMatriz,mediasError];
stdMatriz = [stdMatriz,stdError];
save('resultadosZernike/errorMatriz.mat','errorMatriz');
save('resultadosZernike/stdMatriz.mat','stdMatriz');
save('resultadosZernike/confusionMatriz.mat','confusionMatriz');