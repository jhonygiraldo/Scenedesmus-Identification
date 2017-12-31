clear all, close all, clc;
folderPath = '../../DatabaseVs04/8 Original_ajuste_sin_lineas/';
for(i=421:500)
    i
    originalImage = imread([folderPath 'sin_linea_' int2str(i) '.bmp']);
    imwrite(originalImage,['../../DatabaseVs04/8 Original/' int2str(i) '.bmp']);
    originalImage = rgb2gray(originalImage);
    mask = ones(size(originalImage));
    segmentedAlga = activecontour(originalImage,mask);
    imwrite(segmentedAlga,['../../DatabaseVs04/8 Automatico/' int2str(i) '.bmp']);
end