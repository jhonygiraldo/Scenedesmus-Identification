clear all, close all, clc;
FolderPath = '../../../../DatabaseVs04/derechas/';
FolderList = dir(FolderPath);
allFeatures = [];
allFeaturesNames = [];
mkdir('Hu moments/');
mkdir('HOG/');
mkdir('Haralick descriptors/');
mkdir('LBP descriptors/');
mkdir('Zernike moments/');
mkdir('All features/');
XHu = [];
XHog = [];
XHaralick = [];
XLbp = [];
XZernike = [];
salidas = [ones(500,1);2*ones(500,1);3*ones(500,1);4*ones(500,1)];
cont = 0;
for(i=5:4:size(FolderList,1)-2)
    AlgaeSegmentedPath = [FolderPath FolderList(i).name '/'];
    AlgaeOriginalPath = AlgaeSegmentedPath
    AlgaeOriginalPath(37:end) = [];
    AlgaeOriginalPath = [AlgaeOriginalPath 'Originalrotar/']
    for(j=1:500)
        ((500*cont) + j)/2000
        segmentedImage = imread([AlgaeSegmentedPath int2str(j) '.bmp']);
        originalImage = imread([AlgaeOriginalPath int2str(j) '.bmp']);
        options.show  = 0;                    % show results
        %Hu moments
        [XHu(((cont*500)+j),:),XnHu] = Bfx_hugeo(segmentedImage); %Hu moments
        %HOG
        options.nj    = 3;                    % 3 x 3
        options.ni    = 3;                    % histograms
        options.B     = 9;                    % 9 bins
        J = rgb2gray(originalImage);
        [XHog(((cont*500)+j),:),XnHog] = Bfx_hog(J,options);    % HOG features (see gradients)
        %Haralick descriptor
        options.dharalick = 3;                                 % 3 pixels distance for coocurrence
        R = segmentedImage;                                    % segmentation
        [XHaralick(((cont*500)+j),:),XnHaralick] = Bfx_haralick(J,R,options);    % Haralick features
        %LBP descriptor
        options.vdiv = 1;                        % one vertical divition
        options.hdiv = 1;                        % one horizontal divition
        options.semantic = 0;                    % classic LBP
        options.samples  = 8;                    % number of neighbor samples
        options.mappingtype = 'u2';              % uniform LBP
        [XLbp(((cont*500)+j),:),XnLbp] = Bfx_lbp(J,[],options);    % LBP features
        %Zernike moments
        segmentedImage = imresize(segmentedImage,[256 256]);
        for ind=1:40
            n=4*ind;
            m=2*ind;
            [~, AOH, PhiOH] = Zernikmoment(segmentedImage,n,m);      % Call Zernikemoment fuction
            XZernike(((cont*500)+j),ind) = AOH;
            if(ind < 10)
                XnZernike(ind,:) = ['Zernike moment ' int2str(ind) '        '];
            else
                XnZernike(ind,:) = ['Zernike moment ' int2str(ind) '       '];
            end
        end
    end
    cont = cont + 1;
end
allFeatures = [XHu XHog XHaralick XLbp XZernike];
allFeaturesNames = [XnHu ; XnHog ; XnHaralick ; XnLbp ; XnZernike];
%Hu moments save
save('Hu moments/huMoments.mat','XHu');
save('Hu moments/huMomentsNames.mat','XnHu');
save('Hu moments/salidas.mat','salidas');
%Hog save
save('HOG/Hog.mat','XHog');
save('HOG/HogNames.mat','XnHog');
save('HOG/salidas.mat','salidas');
%Haralick descriptors save
save('Haralick descriptors/Haralick.mat','XHaralick');
save('Haralick descriptors/HaralickNames.mat','XnHaralick');
save('Haralick descriptors/salidas.mat','salidas');
%LBP descriptors save
save('LBP descriptors/Lbp.mat','XLbp');
save('LBP descriptors/LbpNames.mat','XnLbp');
save('LBP descriptors/salidas.mat','salidas');
%Zernike moments save
save('Zernike moments/Zernike.mat','XZernike');
save('Zernike moments/ZernikeNames.mat','XnZernike');
save('Zernike moments/salidas.mat','salidas');
%All features save
save('All features/allFeatures.mat','allFeatures');
save('All features/allFeaturesNames.mat','allFeaturesNames');
save('All features/salidas.mat','salidas');