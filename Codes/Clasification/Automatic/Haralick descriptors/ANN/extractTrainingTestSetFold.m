function [trainingSet testSet] = extractTrainingTestSetFold(foldSet,indice);
%Extrae el conjunto de entrenamiento y de validación para foldSet que es
%una celda que tiene los kfolds, en alguno de los indices donde
%indices = 1,2,3,...,kfolds.
kfolds = size(foldSet,1);
testSet = foldSet{indice,1};
trainingSet = [];
for(i=1:kfolds)
    if(i ~= indice)
        trainingSet = [trainingSet ; foldSet{i,1}];
    end
end