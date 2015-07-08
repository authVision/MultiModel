function image = updateClassifyMatrix(image, errorMap, modelID)
	% update classID and noClassified
	global parameters;
	thres = parameters.threshold;
	temp(:,:,1)=errorMap;
	temp(:,:,2)=image.errorMap;
	image.errorMap = min(temp,[],3);
	image.classID(image.noClassified & image.errorMap<thres) = modelID;
	image.noClassified = image.classID == 0;
end