clc
%clear all

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

parameters.dir = '../data/images/';
%%
models = [];
% storing actual models
models.data = [];
% models.classIdMap
models.classIdMap = containers.Map();
subfolders = dir(fullfile(parameters.dir));
for i=3:1:length(subfolders)
    models = extractModels(parameters.dir, subfolders(i,1).name, models);
end

