%% Function that creates histogramm of a class.
% thresh: if 0, normal histogram
% if >0 (x) : count of images that have a model (in each image model must
	%           appear at least x times)

% we apply the models created for {classModels} to the images of {classImages}
% classModels var can take value 'ALL' to apply all models
function classHist = getClassHist(models, imageDir, classImages, classModels, thresh)
	fprintf( 'Creating class hist %s \n', classImages );
	srcFiles = dir([imageDir classImages '/*.JPEG']);
	filename = {};

	if(strcmp(classModels, 'ALL') == 1 )
		tempModels = models.data;
	else
		tempModels = models.data([models.data.classId] == models.classIdMap(classModels) );
	end
	% keeping only models in bounding box
	tempModels = tempModels([tempModels.boundingBox] == 1);
	
	allModelsData = models.data;

	% keeping last 5 images for testing
	%nTrain = length(srcFiles) - 5;
	nTrain = 10;
	for i=1:nTrain
		filename{i} = [imageDir classImages '/' srcFiles(i).name];
	end
	classHist = [];
	for i=1:nTrain
		fprintf( '%d / %d \n', i, nTrain );
		tic
		image=loadAndPrepareImage(filename{i});
		image=passAllModels(image, tempModels);
		modelHist=hist(image.classID(:), [0 allModelsData.modelId]);
		if(thresh>0)
			modelHist(modelHist<thresh) = 0;
			modelHist(modelHist>=thresh) = 1;
		end
		
		if(i==1)
			classHist = modelHist;
		else
			classHist = classHist + modelHist;
		end
		% modelHist=modelHist/sum(modelHist);
		toc
	end
	% each models appears n times in each picture (mean)
	if(thresh == 0)
		classHist = classHist/nTrain;
	end
end