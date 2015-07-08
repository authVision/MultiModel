function errorMap = getErrorMap(image, model)
	% computes the image.errorMap for a specific model

	PR=model.C*image.in;
	errorMap=mean((PR-image.out).^2);
	errorMap=reshape(errorMap,size(image.errorMap,1),size(image.errorMap,2));
end