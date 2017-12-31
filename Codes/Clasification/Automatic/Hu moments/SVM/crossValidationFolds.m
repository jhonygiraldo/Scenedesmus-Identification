function folds = crossValidationFolds(caracteristicas,kfolds,classNumber)
clase = cell(classNumber,1);
numDatosPorClase = zeros(classNumber,1);
for(i=1:classNumber)
    clase{i,1} = caracteristicas(find(caracteristicas(:,end) == i),:);
    p = randperm(size((clase{i,1}),1));
    clase{i,1} = clase{i,1}(p,:);
    numDatosPorClase(i,1) = round(size(clase{i,1},1)/kfolds);
end
folds = cell(kfolds,1);
for(i=1:kfolds)
    if(i == kfolds)
        for(j=1:classNumber)
            folds{i,1} = [folds{i,1} ; clase{j,1}((i-1)*numDatosPorClase(j,1)+1:end,:)];
        end
    else
        for(j=1:classNumber)
            folds{i,1} = [folds{i,1} ; clase{j,1}((i-1)*numDatosPorClase(j,1)+1:(i*numDatosPorClase(j,1)),:)];
        end
    end
end