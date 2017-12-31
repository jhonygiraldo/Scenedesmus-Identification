function [trainingSetZScore testSetZScore] = zscoreNormalization(trainingSet,testSet)
meanTrainingSet = mean(trainingSet);
stdTrainingSet = std(trainingSet);
trainingSetZScore = (trainingSet - repmat(meanTrainingSet,size(trainingSet,1),1))./(repmat(stdTrainingSet,size(trainingSet,1),1));
testSetZScore = (testSet - repmat(meanTrainingSet,size(testSet,1),1))./(repmat(stdTrainingSet,size(testSet,1),1));