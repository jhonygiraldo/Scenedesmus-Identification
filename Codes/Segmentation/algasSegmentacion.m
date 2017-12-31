clear all, close all, clc;
folderPath = '../../DatabaseVs04/';
folderList = dir(folderPath);
for(i=1:2:size(folderList,1)-3)
    i
    algasPath = [folderPath folderList(i+3).name '/'];
    algasList = dir(algasPath);
    numberFolder = folderList(i+3).name;
    numberFolder(3:end) = [];
    newFolderName = [folderPath numberFolder 'Automatico/'];
    mkdir(newFolderName)
    parfor(j=1:size(algasList,1)-3)
        originalImage = imread([algasPath algasList(j+2).name]);
        originalImage = rgb2gray(originalImage);
        mask = ones(size(originalImage));
        segmentedAlga = activecontour(originalImage,mask);
        imwrite(segmentedAlga,[newFolderName algasList(j+2).name]);
    end
end