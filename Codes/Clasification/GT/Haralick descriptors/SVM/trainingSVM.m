function [error confusion] = trainingSVM(trainingSet,testSet,salidasTrainingSet,salidasTestSet,box,sigma)
for(i=1:size(box,2))
    for(j=1:size(sigma,2))
        options = ['-s 0 -t 2 -g',' ',num2str(sigma(j)),' -c',' ',num2str(box(i)),' -b ','1',' -q'];
        Y = salidasTrainingSet;
        X = trainingSet;
        modelo = svmtrain(Y,X,options);
        options = ['-b ','1',' -q'];
        [salidasSVM , accuracy , probabilidad] = svmpredict(salidasTestSet,testSet,modelo,options);
        error((((i-1)*5)+j),1) = (sum(salidasSVM ~= salidasTestSet))/(size(testSet,1));
        confusion{(((i-1)*5)+j),1} = confusionmat(salidasTestSet,salidasSVM);
    end
end