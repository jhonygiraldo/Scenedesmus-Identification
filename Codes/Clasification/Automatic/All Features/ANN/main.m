clear all, close all, clc;
load(['../salidas.mat']);
mkdir('resultadosSFSelection');
kfolds = 10;
classNumber = 4;
errorMatriz = [];
stdMatriz = [];
confusionMatriz = {};
vectorNeuronas = [5 10 15 20 25 30 35 40 45 50 55 60 ...
    5 10 15 20 25 30 35 40 45 50 55 60];
parpool;
pctRunOnAll warning('off');
if(exist('resultadosSFSelection/errorMatriz.mat') == 2)
    load('resultadosSFSelection/errorMatriz.mat');
    load('resultadosSFSelection/stdMatriz.mat');
    load('resultadosSFSelection/confusionMatriz.mat');
    inicio = size(errorMatriz,2);
else
    inicio = 1;
end
for(i=inicio:215)
    i
    load(['../SFSelection/' int2str(i) 'features.mat']);
    caracteristicas = [X salidas];
    folds = crossValidationFolds(caracteristicas,kfolds,classNumber);
    error = [];
    parfor(j=1:kfolds)
        [trainingSet testSet] = extractTrainingTestSetFold(folds,j);
        salidasTrainingSet = trainingSet(:,end);
        salidasTestSet = testSet(:,end);
        trainingSet(:,end) = [];
        testSet(:,end) = [];
        [trainingSet testSet] = zscoreNormalization(trainingSet,testSet);
        [errorAux confusion] = trainingNeuralNetwork(trainingSet,testSet,salidasTrainingSet,salidasTestSet,vectorNeuronas);
        error(:,j) = errorAux;
        confusionMatriz{j,i} = confusion;
    end
    mediasError = mean(error');
    mediasError = mediasError';
    stdError = std(error');
    stdError = stdError';
    errorMatriz(:,i) = mediasError;
    stdMatriz(:,i) = stdError;
    save('resultadosSFSelection\errorMatriz.mat','errorMatriz');
    save('resultadosSFSelection\stdMatriz.mat','stdMatriz');
    save('resultadosSFSelection\confusionMatriz.mat','confusionMatriz');
end