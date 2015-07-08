%% Function that tests models and updates model array

function [image, models] = findNewModelsInImage(models, filename, className)
	global parameters;
	image=loadAndPrepareImage(filename);
	if(parameters.passOtherClassModels)
		image=passAllModels(image,models.data);
	elseif( isKey(models.classIdMap,className) )
		tempModels.data = models.data([models.data.classId] == models.classIdMap(className) );
		image=passAllModels(image,tempModels.data);
	end
	[image,models]=findNewModels(image,models, filename, className);
end