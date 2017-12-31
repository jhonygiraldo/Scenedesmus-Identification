clear all, close all, clc;
FolderPath = '../../DatabaseVs04/';
FolderList = dir(FolderPath);
for(i=3:3:size(FolderList,1)-5)
    i
    AlgaeSegmentedPath = [FolderPath FolderList(i).name '/'];
    AlgaeGTPath = AlgaeSegmentedPath;
    AlgaeGTPath(22:end) = [];
    AlgaeGTPath = [AlgaeGTPath 'GT'];
    AlgaeGTSegmentedPath = [AlgaeGTPath ' Binary/'];
    AlgaeGTPath = [AlgaeGTPath '/'];
    mkdir(AlgaeGTSegmentedPath);
    for(j=1:500)
        img = imread([AlgaeGTPath int2str(j) '.bmp']);
        indices = find((img(:,:,1) >= 100) & (img(:,:,2) <= 50) & (img(:,:,3) <= 50));
        [x y z] = size(img);
        imgBin = zeros(x,y);
        imgBin(indices) = 1;
        imgBin = logical(imgBin);
        imgFilled = imfill(imgBin,'holes');
        stats = regionprops(imgFilled,'Area');
        areas = [];
        for(k=1:size(stats,1))
            areas(k) = stats(k).Area;
        end
        imgFilled = bwareaopen(imgFilled,max(areas));
        imwrite(imgFilled,[AlgaeGTSegmentedPath int2str(j) '.bmp']);
    end
end