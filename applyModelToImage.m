function [ image ] = applyModelToImage( models, imageDir, classImage, modelId, pictureId )
%SHOWIMAGEMODEL Summary of this function goes here
%   highlights the position in an image of a certain model
    srcFiles = dir([imageDir classImage '/*.JPEG']);
    filename = [imageDir classImage '/' srcFiles(pictureId).name];
    image = loadAndPrepareImage(filename);
    figure
    imagesc(image.Im)
    tempModels.data = models.data([models.data.modelId] == modelId );
    image = passAllModels(image, tempModels.data);
end

