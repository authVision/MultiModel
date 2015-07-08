function model = trainNewModel(roi)
% Training the C parameters
	model.errors = [];
	model.C = roi.out/roi.in;
	model.trainIn = roi.in;
	model.trainOut = roi.out;
	% model.predOut = model.C*model.trainIn;
	
end