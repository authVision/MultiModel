%% Function that creates histogramm of model instances in a certain image.

function modelHist = getModelHist(models, filemane)

	image=loadAndPrepareImage(filename);
	image=passAllModels(image, models);
	modelHist=hist(image.classID, length(models));
	modelHist=modelHist/sum(modelHist);

end