clear all, close all, clc;
load('All features/allFeatures.mat');
load('All features/salidas.mat');
load('All features/allFeaturesNames.mat');
mkdir('SFSelection/');
for(i=1:214)
    i
    op.m = i;                                 % i features will be selected
    op.show = 0;                              % display results
    op.b.name = 'fisher';                     % SFS with Fisher
    s = Bfs_sfs(allFeatures,salidas,op);      % index of selected features
    X = allFeatures(:,s);                     % selected features
    Xn = allFeaturesNames(s,:);               % list of feature names
    save(['SFSelection/' int2str(i) 'features.mat'],'X');
    save(['SFSelection/' int2str(i) 'featuresNames.mat'],'Xn');
end
X = allFeatures;
Xn = allFeaturesNames;
save(['SFSelection/' int2str(215) 'features.mat'],'X');
save(['SFSelection/' int2str(215) 'featuresNames.mat'],'Xn');