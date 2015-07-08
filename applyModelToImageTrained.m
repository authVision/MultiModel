function [ image ] = applyModelToImageTrained(models, modelId )
%APPLYMODELTOIMAGETRAINED Summary of this function goes here
%   Detailed explanation goes here
    tempModels.data = models.data([models.data.modelId] == modelId );
    tempModel = tempModels.data(1);
    fileName = tempModel.trainFileName;
    image = loadAndPrepareImage(fileName);
    image = passAllModels(image, tempModels.data);
end

