clc
%clear all
% test comment

global parameters;
parameters = struct();
parameters.threshold = 0.01;
parameters.maskPreset = 12;
% maskScanSize
% if 0 : will be calculated at loadAndPrepareImage.m (ins*outs *1.5)
% else : DO IT FUCKIN MANUALLY
parameters.maskScanSize = 0;
parameters.maxUnclassified = 0.1;
parameters.maxModelsPerImage = 50;
% for debugging: to save image.classID image plot
parameters.debugImgCount = 0;
parameters.passOtherClassModels = false;
% directory with the pics
% must contain folder named with the containing pictures class name
% - parameters.dir/
% - - fox/
% - - burger/
% etc..

parameters.dir = '../dataset_ImageNET/';
%%
models = [];
% storing actual models
models.data = [];
% models.classIdMap
models.classIdMap = containers.Map();

models = extractModels(parameters.dir, 'face', models);
models = extractModels(parameters.dir, 'fox', models);
models = extractModels(parameters.dir, 'burger', models);

%classHist = getClassHist(A,parameters.dir);
% B = getModelHist(A,'1');
%parameters are to be changed manually (for now)


%%
% getClassHist(models, imageDir, classImages, classModels, thresh)

% applying burger models to burger images
burgersHist = getClassHist(models,parameters.dir, 'burger', 'burger', 0);
figure('name','burgers-modelsBurger')
bar(burgersHist)

%%
% applying all models to burger images
burgersHistAll = getClassHist(models,parameters.dir, 'burger', 'ALL', 200);
figure('name','burgers-all models')
bar(burgersHistAll)

%%
% applying fox models to fox images
foxHist = getClassHist(models,parameters.dir, 'fox', 'fox', 200);
figure('name','fox-fox models')
bar(foxHist)

%%
% applying all models to burger images
foxHistAll = getClassHist(models,parameters.dir, 'fox', 'ALL', 200);
figure('name','fox-all models')
bar(foxHistAll)

%%
% applying burger models to fox images
foxHist_modelsBurger = getClassHist(models,parameters.dir,'fox', 'burger', 0);
figure('name','foxHist_modelsBurger')
bar(foxHist_modelsBurger)

%%
% applying burger models to face images
faceHist_modelsBurger = getClassHist(models,parameters.dir,'face', 'burger', 0);
figure('name','faceHist_modelsBurger')
bar(faceHist_modelsBurger)

%%
% applying fox models to burger images
burgersHist_modelsFox = getClassHist(models,parameters.dir,'burger','fox', 200);
figure('name','burgers-modelsFox')
bar(burgersHist_modelsFox)

%% testing (playing around) purposes: apply one model to one image
testImage = applyModelToImage(models, parameters.dir, 'fox', 13, 2);
imagesc(testImage.classID)

%% testing: applying a model to the image it was trained in
testImage = applyModelToImageTrained(models, 14);
imagesc(testImage.classID);