clear all, close all, clc;
load(['../salidas.mat']);
salidas([421:500 921:1000 1421:1500 1921:2000]) = [];
mkdir('resultadosSFSelection');
kfolds = 10;
classNumber = 4;
errorMatriz = [];
stdMatriz = [];
confusionMatriz = {};
error = [];
box = [0.01 , 0.1 , 1 , 10 , 100];
sigma = [0.01 , 0.1 , 1 , 10 , 100];
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
        [errorAux confusion] = trainingSVM(trainingSet,testSet,salidasTrainingSet,salidasTestSet,box,sigma);
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