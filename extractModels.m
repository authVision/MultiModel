%% Function that returns all models created from images of a certain folder.
% for parameter models pass existing models OR [] (empty array)
function models = extractModels(imageDir, className, models)
    global parameters;
    parts = strsplit(imageDir, '/');
    parameters.debugDir = ['./debug/' parts{end}];
        mkdir(parameters.debugDir);
    if( exist(parameters.debugDir, 'dir' ) == 0 )
        
    end
	% models = [];
    images = [];
	srcFiles = dir([imageDir className '/*.JPEG']);
	filename = {};
	% keeping last 5 images for testing
	nTrain = 0.9*length(srcFiles);
	for i=1:nTrain
		filename{i} = [imageDir className '/' srcFiles(i).name];
	end

	for i=1:nTrain
        fprintf( 'Image %d of %d (%s)\n', i, nTrain, filename{i});
		tic
		[image,models] = findNewModelsInImage(models, filename{i}, className);
        images = [images image];
		toc
	end

	models = updateIntraModelError(models);
end