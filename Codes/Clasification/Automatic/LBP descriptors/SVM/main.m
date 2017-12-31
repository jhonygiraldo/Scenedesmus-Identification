clear all, close all, clc;
load('../Lbp.mat');
load('../salidas.mat');
mkdir('resultadosLbp');
kfolds = 10;
classNumber = 4;
errorMatriz = [];
stdMatriz = [];
confusionMatriz = {};
caracteristicas = [XLbp salidas];
folds = crossValidationFolds(caracteristicas,kfolds,classNumber);
error = [];
box = [0.01 , 0.1 , 1 , 10 , 100];
sigma = [0.01 , 0.1 , 1 , 10 , 100];
%parpool;
pctRunOnAll warning('off');
parfor(i=1:kfolds)
    [trainingSet testSet] = extractTrainingTestSetFold(folds,i);
    salidasTrainingSet = trainingSet(:,end);
    salidasTestSet = testSet(:,end);
    trainingSet(:,end) = [];
    testSet(:,end) = [];
    [trainingSet testSet] = zscoreNormalization(trainingSet,testSet);
    [errorAux confusion] = trainingSVM(trainingSet,testSet,salidasTrainingSet,salidasTestSet,box,sigma);
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