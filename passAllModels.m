%% Function that applies existing models in image file and updates image structure

function image = passAllModels(image, models)

	for i=1:1:length(models)
		errorMap = getErrorMap (image, models(i));
		image = updateClassifyMatrix(image, errorMap, models(i).modelId);
	end
end